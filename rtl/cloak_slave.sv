//------------------------------------------------------------------------------
// Slave 6502 and the bitmap graphics processor (docs/hardware.md section 4).
//
// This CPU does one job: draw into the bitmap. It reaches the two 256x256
// buffers only through the eight-byte window at 0008-000f, which is not a RAM
// but an address generator -- each offset stores or reads a pixel at the
// current (X, Y) and then steps the pointer in one of six directions. Writes go
// to the buffer 1200 bit 0 selects, reads come from the other one, which is the
// one on screen.
//
// A clear (1200 bit 1) takes 65536 cycles in cloak_video; bm_busy holds this
// CPU's Enable for the duration so the clear is atomic, as MAME's memset is.
//------------------------------------------------------------------------------
`default_nettype none

module cloak_slave (
    input  logic        clk,
    input  logic        reset,
    input  logic        cen_cpu,        // 1.25 MHz
    input  logic        irq_tick,       // one clock at the start of lines 0 and 128

    // ---- program ROM load (56 KB, 6502 2000-ffff) ---------------------------
    input  logic        rom_we,
    input  logic [15:0] rom_waddr,      // 0x0000-0xdfff = 6502 0x2000-0xffff
    input  logic  [7:0] rom_wdata,

    // ---- communication RAM shared with the master ---------------------------
    output logic [10:0] shr_addr,
    output logic        shr_we,
    output logic  [7:0] shr_wdata,
    input  logic  [7:0] shr_rdata,

    // ---- bitmap ------------------------------------------------------------
    output logic [15:0] bm_addr,
    output logic        bm_we,
    output logic  [3:0] bm_wdata,
    input  logic  [3:0] bm_rdata,
    output logic        bm_sel,
    output logic        bm_clear,
    input  logic        bm_busy,

    // ---- observability ------------------------------------------------------
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

    // held off while the bitmap is being cleared
    wire cen = cen_cpu & ~bm_busy;

    always_ff @(posedge clk) begin
        A <= A24[15:0]; cpu_do <= cpu_do_raw; wr <= ~rw_n; cpu_di_q <= cpu_di;
    end

    T65 u_cpu (
        .Mode    (2'b00),
        .BCD_en  (1'b1),
        .Res_n   (~reset),
        .Enable  (cen),
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
    assign dbg_sync = sync & cen;
    wire unused_a = &{1'b0, A24[23:16]};

    // -------------------------------------------------------------------------
    // address decode -- MAME's slave_map exactly
    // -------------------------------------------------------------------------
    wire sel_gp     = (A[15:3] == 13'b0000000000001);   // 0008-000f
    wire sel_ram    = (A[15:11] == 5'b00000) && !sel_gp; // 0000-07ff minus the window
    wire sel_shr    = (A[15:11] == 5'b00001);            // 0800-0fff
    wire sel_irqack = (A == 16'h1000);
    wire sel_bmctl  = (A == 16'h1200);
    wire sel_cust   = (A == 16'h1400);
    wire sel_rom    = (A >= 16'h2000);

    wire cpu_wr = cen & wr;
    wire cpu_rd = cen & ~wr;

    // -------------------------------------------------------------------------
    // memories
    // -------------------------------------------------------------------------
    (* ramstyle = "no_rw_check" *) logic [7:0] ram [2048];
    logic [7:0] ram_q;
    always_ff @(posedge clk) begin
        if (cpu_wr && sel_ram) ram[A[10:0]] <= cpu_do;
        ram_q <= ram[A[10:0]];
    end

    (* ramstyle = "no_rw_check" *) logic [7:0] rom [57344];
    logic [7:0] rom_q;
    wire [15:0] rom_ra = A - 16'h2000;
    always_ff @(posedge clk) begin
        if (rom_we) rom[rom_waddr] <= rom_wdata;
        rom_q <= rom[rom_ra];
    end

    assign shr_addr  = A[10:0];
    assign shr_we    = cpu_wr && sel_shr;
    assign shr_wdata = cpu_do;

    // -------------------------------------------------------------------------
    // the graphics processor (hardware.md 4, table)
    // -------------------------------------------------------------------------
    logic [7:0] bx, by;
    assign bm_addr  = {by, bx};
    assign bm_wdata = cpu_do[3:0];
    // 0008-000f minus the two that only set a coordinate
    wire gp_pixel = sel_gp && (A[2:0] != 3'd3) && (A[2:0] != 3'd7);
    assign bm_we  = cpu_wr && gp_pixel;

    // the six directions; 3 and 7 leave the pointer alone, which is what
    // MAME's adjust_xy does by having no case for them
    logic dx_dec, dx_inc, dy_dec, dy_inc;
    always_comb begin
        dx_dec = 1'b0; dx_inc = 1'b0; dy_dec = 1'b0; dy_inc = 1'b0;
        case (A[2:0])
            3'd0: begin dx_dec = 1'b1; dy_inc = 1'b1; end
            3'd1: begin dy_dec = 1'b1; end
            3'd2: begin dx_dec = 1'b1; end
            3'd4: begin dx_inc = 1'b1; dy_inc = 1'b1; end
            3'd5: begin dy_inc = 1'b1; end
            3'd6: begin dx_inc = 1'b1; end
            default: ;
        endcase
    end
    // a read moves the pointer too, and reads at 3 and 7 return a pixel
    // without moving it
    wire gp_step = sel_gp && cen && (gp_pixel || cpu_rd);

    always_ff @(posedge clk) begin
        if (reset) begin
            bx <= 8'h00; by <= 8'h00;
        end else if (cen && sel_gp && wr && A[2:0] == 3'd3) begin
            bx <= cpu_do;
        end else if (cen && sel_gp && wr && A[2:0] == 3'd7) begin
            by <= cpu_do;
        end else if (gp_step) begin
            if (dx_dec) bx <= bx - 8'd1;
            if (dx_inc) bx <= bx + 8'd1;
            if (dy_dec) by <= by - 8'd1;
            if (dy_inc) by <= by + 8'd1;
        end
    end

    // -------------------------------------------------------------------------
    // 1200: buffer select and clear
    // -------------------------------------------------------------------------
    always_ff @(posedge clk) begin
        bm_clear <= 1'b0;
        if (reset) begin
            bm_sel <= 1'b0;
        end else if (cpu_wr && sel_bmctl) begin
            bm_sel   <= cpu_do[0];
            bm_clear <= cpu_do[1];
        end
    end

    // -------------------------------------------------------------------------
    // interrupt: a level held until the 6502 writes 1000
    // -------------------------------------------------------------------------
    always_ff @(posedge clk) begin
        if (reset) irq <= 1'b0;
        else if (irq_tick) irq <= 1'b1;
        else if (cpu_wr && sel_irqack) irq <= 1'b0;
    end

    wire unused_cust = &{1'b0, sel_cust};

    // -------------------------------------------------------------------------
    // read mux
    // -------------------------------------------------------------------------
    always_comb begin
        if      (sel_rom) cpu_di = rom_q;
        else if (sel_gp)  cpu_di = {4'h0, bm_rdata};
        else if (sel_ram) cpu_di = ram_q;
        else if (sel_shr) cpu_di = shr_rdata;
        else              cpu_di = 8'h00;
    end

endmodule

`default_nettype wire
