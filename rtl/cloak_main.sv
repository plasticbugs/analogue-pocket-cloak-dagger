//------------------------------------------------------------------------------
// Master 6502 and its bus (docs/hardware.md section 3).
//
// Owns the 1 KB of work RAM, the 48 KB program ROM, the 512-byte NVRAM, the
// two POKEYs and the input ports; reaches the playfield RAM, the motion object
// RAM and the palette through cloak_video, and the 2 KB of communication RAM
// through cloak_core.
//
// T65 presents its address and R/W right after an Enable edge and samples DI on
// the next one, so a registered copy of the bus one clock behind is stable for
// the whole cycle. Every read here is a block RAM output or a combinational
// lookup of that address; writes commit on the Enable edge itself.
//------------------------------------------------------------------------------
`default_nettype none

module cloak_main (
    input  logic        clk,
    input  logic        reset,
    input  logic        cen_cpu,        // 1.0 MHz
    input  logic        cen_pokey,      // 1.25 MHz

    input  logic        irq_tick,       // one clock at the start of lines 0, 64, 128, 192

    // ---- program ROM load (48 KB, 6502 4000-ffff) ---------------------------
    input  logic        rom_we,
    input  logic [15:0] rom_waddr,      // 0x0000-0xbfff = 6502 0x4000-0xffff
    input  logic  [7:0] rom_wdata,

    // ---- video ports --------------------------------------------------------
    output logic  [9:0] pf_addr,
    output logic        pf_we,
    output logic  [7:0] pf_wdata,
    input  logic  [7:0] pf_rdata,
    output logic  [7:0] mo_addr,
    output logic        mo_we,
    output logic  [7:0] mo_wdata,
    input  logic  [7:0] mo_rdata,
    output logic  [6:0] pal_addr,
    output logic        pal_we,
    output logic  [7:0] pal_wdata,

    // ---- communication RAM shared with the slave ----------------------------
    output logic [10:0] shr_addr,
    output logic        shr_we,
    output logic  [7:0] shr_wdata,
    input  logic  [7:0] shr_rdata,

    // ---- inputs -------------------------------------------------------------
    input  logic  [7:0] in_p1,          // active low, both sticks (hardware.md 6)
    input  logic  [7:0] in_system,      // active low except bit 0
    input  logic  [7:0] in_start,       // POKEY 1 ALLPOT
    input  logic  [7:0] in_dsw,         // POKEY 2 ALLPOT
    input  logic        video_active,   // SYSTEM bit 0
    input  logic        nvclear,        // wipe the NVRAM (held high through a reset window)

    // ---- 74LS259 outputs ----------------------------------------------------
    output logic        flip,
    output logic  [1:0] coin_counter,
    output logic  [1:0] start_led,

    // ---- NVRAM external port (load / save), 512 bytes -----------------------
    input  logic  [8:0] nv_addr,
    input  logic        nv_we,
    input  logic  [7:0] nv_wdata,
    output logic  [7:0] nv_rdata,
    output logic        nv_dirty,       // toggles on every 6502 write to the NVRAM

    // ---- audio --------------------------------------------------------------
    output logic  [5:0] pokey1_sum,
    output logic  [5:0] pokey2_sum,
    output logic [15:0] pokey1_raw,     // MAME's m_out_raw; cloak_audio uses these
    output logic [15:0] pokey2_raw,

    // ---- observability ------------------------------------------------------
    output logic        watchdog_kick,
    output logic [15:0] dbg_addr,
    output logic        dbg_sync
);
    // -------------------------------------------------------------------------
    // CPU
    // -------------------------------------------------------------------------
    wire [23:0] A24;
    wire  [7:0] cpu_do_raw;
    wire        rw_n, sync;
    logic [15:0] A;
    logic  [7:0] cpu_do;
    logic        wr;
    logic  [7:0] cpu_di_q;
    logic  [7:0] cpu_di;
    logic        irq;

    always_ff @(posedge clk) begin
        A <= A24[15:0]; cpu_do <= cpu_do_raw; wr <= ~rw_n; cpu_di_q <= cpu_di;
    end

    T65 u_cpu (
        .Mode    (2'b00),
        .BCD_en  (1'b1),
        .Res_n   (~reset),
        .Enable  (cen_cpu),
        .Clk     (clk),
        .Rdy     (1'b1),
        .Abort_n (1'b1),
        .IRQ_n   (~irq),
        .NMI_n   (1'b1),
        .SO_n    (1'b1),
        .R_W_n   (rw_n),
        .Sync    (sync),
        .EF      (), .MF (), .XF (), .ML_n (), .VP_n (), .VDA (), .VPA (),
        .A       (A24),
        .DI      (cpu_di_q),
        .DO      (cpu_do_raw),
        .Regs    (),
        .NMI_ack ()
    );
    assign dbg_addr = A;
    assign dbg_sync = sync & cen_cpu;
    wire unused_a = &{1'b0, A24[23:16]};

    // -------------------------------------------------------------------------
    // address decode -- MAME's master_map exactly, no mirrors
    // -------------------------------------------------------------------------
    wire sel_ram   = (A[15:10] == 6'b000000);                     // 0000-03ff
    wire sel_pf    = (A[15:10] == 6'b000001);                     // 0400-07ff
    wire sel_shr   = (A[15:11] == 5'b00001);                      // 0800-0fff
    wire sel_pk1   = (A[15:4]  == 12'h100);                       // 1000-100f
    wire sel_pk2   = (A[15:4]  == 12'h180);                       // 1800-180f
    wire sel_p1    = (A == 16'h2000);
    wire sel_p2    = (A == 16'h2200);
    wire sel_sys   = (A == 16'h2400);
    wire sel_cust  = (A == 16'h2600);
    wire sel_nv    = (A[15:9] == 7'b0010100);                     // 2800-29ff
    wire sel_mo    = (A[15:8] == 8'h30);                          // 3000-30ff
    wire sel_pal   = (A[15:7] == 9'b001100100);                   // 3200-327f
    wire sel_l259  = (A[15:3] == 13'b0011100000000);              // 3800-3807
    wire sel_wdog  = (A == 16'h3a00);
    wire sel_irqack= (A == 16'h3c00);
    wire sel_nven  = (A == 16'h3e00);
    wire sel_rom   = A[15] | A[14];                               // 4000-ffff

    wire cpu_wr = cen_cpu & wr;

    // -------------------------------------------------------------------------
    // memories
    // -------------------------------------------------------------------------
    (* ramstyle = "no_rw_check" *) logic [7:0] ram [1024];
    logic [7:0] ram_q;
    always_ff @(posedge clk) begin
        if (cpu_wr && sel_ram) ram[A[9:0]] <= cpu_do;
        ram_q <= ram[A[9:0]];
    end

    (* ramstyle = "no_rw_check" *) logic [7:0] rom [49152];
    logic [7:0] rom_q;
    wire [15:0] rom_ra = A - 16'h4000;
    always_ff @(posedge clk) begin
        if (rom_we) rom[rom_waddr] <= rom_wdata;
        rom_q <= rom[rom_ra];
    end

    // NVRAM: the 6502 on one port, the Pocket's save slot on the other.
    // The menu's "Clear Settings & Scores" sweeps it to zero on the CPU port
    // while the core is held in reset -- 512 writes, 13 us -- and toggles
    // nv_dirty at the end so the wipe is written back to the .sav rather than
    // coming straight back the next time the game is loaded.
    logic [8:0] nvclr_addr;
    logic       nvclr_run;
    always_ff @(posedge clk) begin
        if (nvclear && !nvclr_run && nvclr_addr == 9'd0) nvclr_run <= 1'b1;
        else if (nvclr_run) begin
            nvclr_addr <= nvclr_addr + 9'd1;
            if (nvclr_addr == 9'd511) nvclr_run <= 1'b0;
        end else if (!nvclear) begin
            nvclr_addr <= 9'd0;
        end
    end
    wire       nv_cpu_we   = nvclr_run ? 1'b1        : (cpu_wr && sel_nv);
    wire [8:0] nv_cpu_addr = nvclr_run ? nvclr_addr  : A[8:0];
    wire [7:0] nv_cpu_wd   = nvclr_run ? 8'h00       : cpu_do;
    logic [7:0] nvq_cpu;
    tdpram #(.AW(9), .DW(8)) u_nvram (
        .clk(clk),
        .a_addr(nv_cpu_addr), .a_we(nv_cpu_we), .a_wdata(nv_cpu_wd), .a_rdata(nvq_cpu),
        .b_addr(nv_addr),     .b_we(nv_we),     .b_wdata(nv_wdata),  .b_rdata(nv_rdata)
    );
    always_ff @(posedge clk) begin
        if (cpu_wr && sel_nv) nv_dirty <= ~nv_dirty;
        else if (nvclr_run && nvclr_addr == 9'd511) nv_dirty <= ~nv_dirty;
    end

    // -------------------------------------------------------------------------
    // video ports
    // -------------------------------------------------------------------------
    assign pf_addr  = A[9:0];
    assign pf_we    = cpu_wr && sel_pf;
    assign pf_wdata = cpu_do;
    assign mo_addr  = A[7:0];
    assign mo_we    = cpu_wr && sel_mo;
    assign mo_wdata = cpu_do;
    assign pal_addr = A[6:0];
    assign pal_we   = cpu_wr && sel_pal;
    assign pal_wdata= cpu_do;
    assign shr_addr = A[10:0];
    assign shr_we   = cpu_wr && sel_shr;
    assign shr_wdata= cpu_do;

    // -------------------------------------------------------------------------
    // POKEYs. Both sit on this bus; the DIP switches and the start buttons are
    // read through their ALLPOT inputs (hardware.md 6).
    // -------------------------------------------------------------------------
    logic [7:0] pk1_q, pk2_q;
    pokey u_pokey1 (
        .clk(clk), .reset(reset), .cen(cen_pokey),
        .addr(A[3:0]), .we(cpu_wr && sel_pk1), .wdata(cpu_do), .rdata(pk1_q),
        .allpot(in_start), .sum(pokey1_sum), .out_raw(pokey1_raw)
    );
    pokey u_pokey2 (
        .clk(clk), .reset(reset), .cen(cen_pokey),
        .addr(A[3:0]), .we(cpu_wr && sel_pk2), .wdata(cpu_do), .rdata(pk2_q),
        .allpot(in_dsw), .sum(pokey2_sum), .out_raw(pokey2_raw)
    );

    // -------------------------------------------------------------------------
    // 74LS259 at 3800, written with D7 (hardware.md 3.1)
    // -------------------------------------------------------------------------
    logic [7:0] l259;
    always_ff @(posedge clk) begin
        if (reset) l259 <= 8'h00;
        else if (cpu_wr && sel_l259) l259[A[2:0]] <= cpu_do[7];
    end
    assign coin_counter = {l259[1], l259[0]};   // {left, right}
    assign flip         = l259[3];
    assign start_led    = {~l259[6], ~l259[7]};      // MAME inverts these

    // -------------------------------------------------------------------------
    // interrupt: a level held until the 6502 writes 3c00
    // -------------------------------------------------------------------------
    always_ff @(posedge clk) begin
        if (reset) irq <= 1'b0;
        else if (irq_tick) irq <= 1'b1;
        else if (cpu_wr && sel_irqack) irq <= 1'b0;
    end
    assign watchdog_kick = cpu_wr && sel_wdog;

    // 3e00 bit 0 is the NVRAM write enable. MAME latches it and never uses it,
    // so neither does this; gating writes on it is not something the oracle
    // can confirm.
    wire unused_nven = &{1'b0, sel_nven, sel_cust, sel_p2};

    // -------------------------------------------------------------------------
    // read mux. Unmapped reads give 0, as MAME's default unmap value does.
    // -------------------------------------------------------------------------
    always_comb begin
        if      (sel_rom) cpu_di = rom_q;
        else if (sel_ram) cpu_di = ram_q;
        else if (sel_pf)  cpu_di = pf_rdata;
        else if (sel_shr) cpu_di = shr_rdata;
        else if (sel_pk1) cpu_di = pk1_q;
        else if (sel_pk2) cpu_di = pk2_q;
        else if (sel_p1)  cpu_di = in_p1;
        else if (sel_p2)  cpu_di = 8'hff;
        else if (sel_sys) cpu_di = {in_system[7:1], video_active};
        else if (sel_nv)  cpu_di = nvq_cpu;
        else if (sel_mo)  cpu_di = mo_rdata;
        else              cpu_di = 8'h00;
    end

endmodule

`default_nettype wire
