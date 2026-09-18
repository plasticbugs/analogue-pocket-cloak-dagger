//------------------------------------------------------------------------------
// Cloak & Dagger core: both 6502s, the video, the two POKEYs and the image
// loader. Platform-independent -- target/pocket/core_top.sv wraps this.
//
// Clocking, from a 40 MHz system clock (docs/hardware.md sections 1 and 2):
//
//   /8   = 5.000 MHz  dot clock       (320 dots per line, 256 lines, 61.04 Hz)
//   /32  = 1.250 MHz  slave 6502 and both POKEYs
//   /40  = 1.000 MHz  master 6502
//
// Every divider is exact, so the two CPUs stay phase-locked to the beam as they
// are on the board: 64 master cycles and 80 slave cycles per scanline.
//
// Interrupts come off the vertical counter rather than from a free-running timer
// as MAME's do: the master is interrupted every 64 lines and the slave every
// 128, which puts the master's fourth interrupt exactly at the start of vertical
// blanking, where the driver's comment says it is.
//------------------------------------------------------------------------------
`default_nettype none

module cloak_core
    import cloak_pkg::*;
(
    input  logic        clk_sys,        // 40 MHz
    input  logic        reset,
    input  logic        pix_sync,       // one clock after the platform's dot clock edge
    input  logic        pause,          // the Pocket's menu is open: freeze the machine

    // ---- image load (the .rom built by tools/mra_build.py) ------------------
    input  logic        ioctl_wr,
    input  logic [24:0] ioctl_addr,
    input  logic  [7:0] ioctl_data,
    input  logic        ioctl_download,

    // ---- controls, all active high -----------------------------------------
    input  logic        p1_left_up,   p1_left_down,  p1_left_left,  p1_left_right,
    input  logic        p1_right_up,  p1_right_down, p1_right_left, p1_right_right,
    input  logic        p1_button,
    input  logic        start1, start2,
    input  logic        coin1, coin2,
    input  logic        service, test,
    input  logic  [7:0] dsw,
    input  logic        nvclear,        // menu: wipe the NVRAM while the core is held in reset

    // ---- options -----------------------------------------------------------
    input  logic        dcblock_en,

    // ---- video -------------------------------------------------------------
    output logic  [7:0] red, green, blue,
    output logic        hsync, vsync, hblank, vblank, de,
    output logic        cen_pix_out,

    // ---- audio -------------------------------------------------------------
    output logic signed [15:0] audio,

    // ---- NVRAM (the Pocket's save slot) ------------------------------------
    input  logic  [8:0] nv_addr,
    input  logic        nv_we,
    input  logic  [7:0] nv_wdata,
    output logic  [7:0] nv_rdata,
    output logic        nv_dirty,

    // ---- observability -----------------------------------------------------
    output logic [15:0] dbg_main_addr,
    output logic [15:0] dbg_slave_addr,
    output logic        dbg_bm_busy
);
    // =========================================================================
    // image layout (cloak.mra / docs/hardware.md section 7)
    // =========================================================================
    localparam logic [24:0] MAIN_BASE  = 25'h00100, MAIN_END  = 25'h0c100;
    localparam logic [24:0] SLAVE_BASE = 25'h0c100, SLAVE_END = 25'h1a100;
    localparam logic [24:0] CHAR_BASE  = 25'h1a100, CHAR_END  = 25'h1c100;
    localparam logic [24:0] SPR_BASE   = 25'h1c100, SPR_END   = 25'h1e100;
    localparam logic [24:0] PROM_BASE  = 25'h1e100, PROM_END  = 25'h1e200;

    wire in_main  = (ioctl_addr >= MAIN_BASE)  && (ioctl_addr < MAIN_END);
    wire in_slave = (ioctl_addr >= SLAVE_BASE) && (ioctl_addr < SLAVE_END);
    wire in_char  = (ioctl_addr >= CHAR_BASE)  && (ioctl_addr < CHAR_END);
    wire in_spr   = (ioctl_addr >= SPR_BASE)   && (ioctl_addr < SPR_END);
    wire in_prom  = (ioctl_addr >= PROM_BASE)  && (ioctl_addr < PROM_END);

    wire        ld = ioctl_download & ioctl_wr;
    wire        main_rom_we   = ld & in_main;
    wire [15:0] main_rom_addr = ioctl_addr[15:0] - MAIN_BASE[15:0];
    wire        slave_rom_we  = ld & in_slave;
    wire [16:0] slave_off     = ioctl_addr[16:0] - SLAVE_BASE[16:0];
    wire [15:0] slave_rom_addr= slave_off[15:0];
    wire        gfx_we        = ld & (in_char | in_spr);
    wire [13:0] gfx_waddr     = in_char ? (ioctl_addr[13:0] - CHAR_BASE[13:0])
                                        : (14'h2000 + (ioctl_addr[13:0] - SPR_BASE[13:0]));
    wire        prom_we       = ld & in_prom;
    wire  [7:0] prom_waddr    = ioctl_addr[7:0] - PROM_BASE[7:0];

    // hold the machine in reset while the image is loading
    logic core_rst;
    always_ff @(posedge clk_sys) core_rst <= reset | ioctl_download;

    // =========================================================================
    // clock enables
    // =========================================================================
    // The pixel divider is restarted from the platform's own dot clock edge so
    // the scaler samples away from the pixel's transition; pix_sync is a pulse
    // two clocks after that edge, and setting the divider to 6 here puts
    // cen_pix three clocks later -- about half a pixel in, which is where the
    // sample wants to land.
    logic [2:0] div_pix;
    logic [4:0] div_slv;
    logic [5:0] div_mst;
    logic       cen_pix, cen_slave, cen_master;
    always_ff @(posedge clk_sys) begin
        if (reset) begin
            div_pix <= '0; div_slv <= '0; div_mst <= '0;
        end else begin
            div_pix <= pix_sync ? 3'd6 : (div_pix + 3'd1);
            div_slv <= div_slv + 5'd1;
            div_mst <= (div_mst == 6'd39) ? 6'd0 : (div_mst + 6'd1);
        end
    end
    assign cen_pix     = (div_pix == 3'd0);
    // The menu freezes both CPUs and the sound chips; the beam keeps running so
    // the picture stays on screen.
    assign cen_slave   = (div_slv == 5'd0) && !pause;
    assign cen_master  = (div_mst == 6'd0) && !pause;
    assign cen_pix_out = cen_pix;

    // =========================================================================
    // input ports (docs/hardware.md section 6)
    // =========================================================================
    wire [7:0] in_p1 = ~{p1_left_left,  p1_left_right,  p1_left_up,  p1_left_down,
                         p1_right_left, p1_right_right, p1_right_up, p1_right_down};
    // bit 0 is filled in by cloak_main from the video counter
    wire [7:0] in_system = {~p1_button, 1'b1, ~service, 1'b1, ~coin1, ~coin2, ~test, 1'b0};
    wire [7:0] in_start  = {start1, start2, 2'b11, 4'b0000};

    // =========================================================================
    // interrupts off the vertical counter
    // =========================================================================
    wire [8:0] vid_hcnt;
    wire [7:0] vid_vcnt;
    logic [7:0] vcnt_q;
    logic       line_tick;
    always_ff @(posedge clk_sys) begin
        vcnt_q    <= vid_vcnt;
        line_tick <= (vid_vcnt != vcnt_q);
    end
    wire master_irq = line_tick && (vcnt_q[5:0] == 6'd0);   // lines 0, 64, 128, 192
    wire slave_irq  = line_tick && (vcnt_q[6:0] == 7'd0);   // lines 0, 128

    // =========================================================================
    // communication RAM, 2 KB, both CPUs
    // =========================================================================
    wire [10:0] m_shr_addr, s_shr_addr;
    wire        m_shr_we,   s_shr_we;
    wire  [7:0] m_shr_wdata, s_shr_wdata;
    wire  [7:0] m_shr_rdata, s_shr_rdata;
    tdpram #(.AW(11), .DW(8)) u_shared (
        .clk(clk_sys),
        .a_addr(m_shr_addr), .a_we(m_shr_we), .a_wdata(m_shr_wdata), .a_rdata(m_shr_rdata),
        .b_addr(s_shr_addr), .b_we(s_shr_we), .b_wdata(s_shr_wdata), .b_rdata(s_shr_rdata)
    );

    // =========================================================================
    // video
    // =========================================================================
    wire  [9:0] pf_addr;  wire pf_we;  wire [7:0] pf_wdata, pf_rdata;
    wire  [7:0] mo_addr;  wire mo_we;  wire [7:0] mo_wdata, mo_rdata;
    wire  [6:0] pal_addr; wire pal_we; wire [7:0] pal_wdata;
    wire [15:0] bm_addr;  wire bm_we;  wire [3:0] bm_wdata, bm_rdata;
    wire        bm_sel, bm_clear, bm_busy;
    wire        flip, video_active;

    cloak_video u_video (
        .clk(clk_sys), .reset(core_rst), .cen_pix(cen_pix),
        .pf_addr(pf_addr),   .pf_we(pf_we),   .pf_wdata(pf_wdata),   .pf_rdata(pf_rdata),
        .mo_addr(mo_addr),   .mo_we(mo_we),   .mo_wdata(mo_wdata),   .mo_rdata(mo_rdata),
        .pal_addr(pal_addr), .pal_we(pal_we), .pal_wdata(pal_wdata),
        .flip(flip),
        .bm_addr(bm_addr), .bm_we(bm_we), .bm_wdata(bm_wdata), .bm_rdata(bm_rdata),
        .bm_sel(bm_sel), .bm_clear(bm_clear), .bm_busy(bm_busy),
        .gfx_we(gfx_we), .gfx_waddr(gfx_waddr), .gfx_wdata(ioctl_data),
        .prom_we(prom_we), .prom_waddr(prom_waddr), .prom_wdata(ioctl_data),
        .red(red), .green(green), .blue(blue),
        .hsync(hsync), .vsync(vsync), .hblank(hblank), .vblank(vblank), .de(de),
        .hcnt(vid_hcnt), .vcnt(vid_vcnt), .video_active(video_active)
    );
    assign dbg_bm_busy = bm_busy;

    // =========================================================================
    // CPUs
    // =========================================================================
    wire [15:0] pokey1_raw, pokey2_raw;
    wire  [5:0] pokey1_sum, pokey2_sum;
    wire  [1:0] coin_counter, start_led;
    wire        watchdog_kick;

    cloak_main u_main (
        .clk(clk_sys), .reset(core_rst), .cen_cpu(cen_master), .cen_pokey(cen_slave),
        .irq_tick(master_irq),
        .rom_we(main_rom_we), .rom_waddr(main_rom_addr), .rom_wdata(ioctl_data),
        .pf_addr(pf_addr),   .pf_we(pf_we),   .pf_wdata(pf_wdata),   .pf_rdata(pf_rdata),
        .mo_addr(mo_addr),   .mo_we(mo_we),   .mo_wdata(mo_wdata),   .mo_rdata(mo_rdata),
        .pal_addr(pal_addr), .pal_we(pal_we), .pal_wdata(pal_wdata),
        .shr_addr(m_shr_addr), .shr_we(m_shr_we), .shr_wdata(m_shr_wdata), .shr_rdata(m_shr_rdata),
        .in_p1(in_p1), .in_system(in_system), .in_start(in_start), .in_dsw(dsw),
        .nvclear(nvclear),
        .video_active(video_active),
        .flip(flip), .coin_counter(coin_counter), .start_led(start_led),
        .nv_addr(nv_addr), .nv_we(nv_we), .nv_wdata(nv_wdata), .nv_rdata(nv_rdata),
        .nv_dirty(nv_dirty),
        .pokey1_sum(pokey1_sum), .pokey2_sum(pokey2_sum),
        .pokey1_raw(pokey1_raw), .pokey2_raw(pokey2_raw),
        .watchdog_kick(watchdog_kick),
        .dbg_addr(dbg_main_addr), .dbg_sync()
    );

    cloak_slave u_slave (
        .clk(clk_sys), .reset(core_rst), .cen_cpu(cen_slave), .irq_tick(slave_irq),
        .rom_we(slave_rom_we), .rom_waddr(slave_rom_addr), .rom_wdata(ioctl_data),
        .shr_addr(s_shr_addr), .shr_we(s_shr_we), .shr_wdata(s_shr_wdata), .shr_rdata(s_shr_rdata),
        .bm_addr(bm_addr), .bm_we(bm_we), .bm_wdata(bm_wdata), .bm_rdata(bm_rdata),
        .bm_sel(bm_sel), .bm_clear(bm_clear), .bm_busy(bm_busy),
        .dbg_addr(dbg_slave_addr), .dbg_sync()
    );

    // =========================================================================
    // audio
    // =========================================================================
    cloak_audio u_audio (
        .clk(clk_sys), .reset(core_rst), .cen_pokey(cen_slave),
        .raw1(pokey1_raw), .raw2(pokey2_raw),
        .dcblock_en(dcblock_en),
        .audio(audio), .audio_valid()
    );

    wire unused = &{1'b0, vid_hcnt, coin_counter, start_led, watchdog_kick,
                    pokey1_sum, pokey2_sum, slave_off[16]};

endmodule

`default_nettype wire
