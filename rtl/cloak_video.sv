//------------------------------------------------------------------------------
// Cloak & Dagger video (docs/hardware.md section 5).
//
// Three layers, composited playfield -> bitmap -> motion objects, in the order
// cloak_state::screen_update draws them. Everything is block RAM and every
// access is single-cycle, so there is no bandwidth budget here: the playfield
// is fetched a tile ahead, the bitmap a pixel ahead, and the motion objects are
// built into a line buffer during the line before they are shown.
//
// Unlike MAME -- which draws this screen lazily and in bands, so a playfield
// write part-way down a frame retroactively changes rows already "drawn" --
// this scans out live, one line at a time, as the board does. A write lands on
// the rows the beam has not reached yet and no others.
//
// This module owns the playfield RAM, the motion object RAM, the palette RAM,
// the two bitmap buffers and the two graphics ROMs, and gives the CPUs ports
// onto them.
//
// Pipeline: the three layers' pens are all valid during the dot they belong
// to; the palette lookup and the colour ladder add two dots, and the syncs are
// delayed to match.
//------------------------------------------------------------------------------
`default_nettype none

module cloak_video
    import cloak_pkg::*;
(
    input  logic        clk,
    input  logic        reset,
    input  logic        cen_pix,        // 5 MHz dot clock

    // ---- master 6502 ports --------------------------------------------------
    input  logic  [9:0] pf_addr,        // playfield RAM, 0400-07ff
    input  logic        pf_we,
    input  logic  [7:0] pf_wdata,
    output logic  [7:0] pf_rdata,

    input  logic  [7:0] mo_addr,        // motion object RAM, 3000-30ff
    input  logic        mo_we,
    input  logic  [7:0] mo_wdata,
    output logic  [7:0] mo_rdata,

    input  logic  [6:0] pal_addr,       // palette window, 3200-327f (write only)
    input  logic        pal_we,
    input  logic  [7:0] pal_wdata,

    input  logic        flip,           // LS259 Q3

    // ---- slave 6502 port: the bitmap ---------------------------------------
    input  logic [15:0] bm_addr,        // {y, x}
    input  logic        bm_we,
    input  logic  [3:0] bm_wdata,
    output logic  [3:0] bm_rdata,       // from the DISPLAYED buffer
    input  logic        bm_sel,         // 1200 bit 0: which buffer is drawn into
    input  logic        bm_clear,       // 1200 bit 1: one clock, clear the drawn buffer
    output logic        bm_busy,        // clear running: the slave is held

    // ---- image load ---------------------------------------------------------
    input  logic        gfx_we,
    input  logic [13:0] gfx_waddr,      // 0000-1fff chars, 2000-3fff motion objects
    input  logic  [7:0] gfx_wdata,
    input  logic        prom_we,
    input  logic  [7:0] prom_waddr,
    input  logic  [7:0] prom_wdata,

    // ---- video out ----------------------------------------------------------
    output logic  [7:0] red, green, blue,
    output logic        hsync, vsync,
    output logic        hblank, vblank,
    output logic        de,
    output logic  [8:0] hcnt,
    output logic  [7:0] vcnt,
    output logic        video_active    // the SYSTEM bit 0 the master reads (1 = active video)
);

    // =========================================================================
    // counters and the vertical timing PROM
    // =========================================================================
    // vcnt is MAME's screen row; the PROM is indexed by vcnt-1 (hardware.md 2).
    logic [1:0] vprom [256];
    always_ff @(posedge clk) if (prom_we) vprom[prom_waddr] <= prom_wdata[1:0];

    always_ff @(posedge clk) begin
        if (reset) begin
            hcnt <= '0; vcnt <= '0;
        end else if (cen_pix) begin
            if (hcnt == HTOTAL - 1) begin
                hcnt <= '0;
                vcnt <= vcnt + 8'd1;
            end else begin
                hcnt <= hcnt + 9'd1;
            end
        end
    end

    // Two dots ahead of the current one, wrapping into the next line. Every
    // prefetch below is expressed against this, because a read issued at the
    // edge that begins dot x answers during dot x+1.
    wire [8:0] h_sum2 = hcnt + 9'd2;
    wire       h_wrap = (h_sum2 >= HTOTAL);
    wire [8:0] h_p2   = h_wrap ? (h_sum2 - HTOTAL) : h_sum2;
    wire [7:0] v_p2   = h_wrap ? (vcnt + 8'd1) : vcnt;

    // latched once per line, during the back porch, for the line about to start
    logic [1:0] vflags;                 // {vsync_n, active}
    wire  [7:0] next_row = (hcnt >= HTOTAL - 8) ? (vcnt + 8'd1) : vcnt;
    always_ff @(posedge clk) begin
        if (cen_pix && hcnt == HTOTAL - 2) vflags <= vprom[next_row - 8'd1];
    end
    wire line_active = vflags[0];
    wire line_vsync  = ~vflags[1];

    assign hblank       = (hcnt >= HACTIVE);
    assign vblank       = ~line_active;
    assign video_active = line_active;

    // =========================================================================
    // playfield: 1 KB of tile codes, 256 tiles of 8x8 at 4 bits per pixel
    // =========================================================================
    // Fetched one tile (8 dots) ahead: the tile code at hcnt[2:0]==0, the tile
    // row at ==1, latched at ==2, swapped in at ==7. The group that runs over
    // the last eight dots of the line fetches column 0 of the next row, so the
    // first displayed tile is already in hand.
    wire [4:0] fcol_raw = (hcnt >= HTOTAL - 8) ? 5'd0 : (hcnt[7:3] + 5'd1);
    wire [7:0] frow_raw = next_row;
    wire [4:0] fcol = flip ? (5'd31 - fcol_raw)      : fcol_raw;
    wire [4:0] frow = flip ? (5'd31 - frow_raw[7:3]) : frow_raw[7:3];
    wire [2:0] fsub = flip ? (3'd7 - frow_raw[2:0])  : frow_raw[2:0];

    logic  [9:0] pf_vaddr;
    logic  [7:0] pf_vq;
    tdpram #(.AW(10), .DW(8)) u_pfram (
        .clk(clk),
        .a_addr(pf_addr),  .a_we(pf_we), .a_wdata(pf_wdata), .a_rdata(pf_rdata),
        .b_addr(pf_vaddr), .b_we(1'b0),  .b_wdata(8'h00),    .b_rdata(pf_vq)
    );

    logic [10:0] chr_raddr;
    logic [31:0] chr_q;
    gfxrom u_chrrom (
        .clk(clk),
        .we   (gfx_we && !gfx_waddr[13]),
        .waddr({gfx_waddr[11:4], gfx_waddr[3:1]}),
        .wlane({~gfx_waddr[0], gfx_waddr[12]}),
        .wdata(gfx_wdata),
        .raddr(chr_raddr), .q(chr_q)
    );

    logic [31:0] pf_row_next, pf_row_cur;
    always_ff @(posedge clk) if (cen_pix) begin
        case (hcnt[2:0])
            3'd0: pf_vaddr    <= {frow, fcol};
            3'd1: chr_raddr   <= {pf_vq, fsub};
            3'd2: pf_row_next <= chr_q;
            3'd7: pf_row_cur  <= pf_row_next;
            default: ;
        endcase
    end
    wire [2:0] pf_px  = flip ? (3'd7 - hcnt[2:0]) : hcnt[2:0];
    wire [3:0] pf_pen = pf_row_cur[31 - 4*pf_px -: 4];

    // =========================================================================
    // bitmap: two 64 K x 4 buffers; the slave draws into one and the beam shows
    // the other. Source column for screen dot x is (x + 6) & 0xff, and source
    // bit 7 -- not the screen's -- picks the palette bank (hardware.md 5.2).
    // =========================================================================
    logic [15:0] bm_vaddr;
    always_ff @(posedge clk) if (cen_pix) bm_vaddr <= {v_p2, h_p2[7:0] + 8'd6};

    // Clear engine: 65536 writes at the system clock (1.6 ms) into the drawn
    // buffer's beam port, with the slave held while it runs so the clear is
    // atomic as MAME's memset is. It has to be: 35 of 36 clears are followed by
    // the slave drawing into that buffer in the same frame (measured).
    logic        clr_run;
    logic [15:0] clr_addr;
    always_ff @(posedge clk) begin
        if (reset) begin
            clr_run <= 1'b0; clr_addr <= '0;
        end else if (bm_clear && !clr_run) begin
            clr_run <= 1'b1; clr_addr <= '0;
        end else if (clr_run) begin
            clr_addr <= clr_addr + 16'd1;
            if (clr_addr == 16'hffff) clr_run <= 1'b0;
        end
    end
    assign bm_busy = clr_run;

    logic [3:0] bm0_q, bm1_q;
    wire        drawn0  = (bm_sel == 1'b0);     // bm_sel names the DRAWN buffer
    wire [15:0] b0_addr = (clr_run &&  drawn0) ? clr_addr : bm_vaddr;
    wire [15:0] b1_addr = (clr_run && !drawn0) ? clr_addr : bm_vaddr;
    tdpram #(.AW(16), .DW(4)) u_bmp0 (
        .clk(clk),
        .a_addr(bm_addr), .a_we(bm_we &&  drawn0 && !clr_run), .a_wdata(bm_wdata), .a_rdata(),
        .b_addr(b0_addr), .b_we(clr_run && drawn0),            .b_wdata(4'h0),     .b_rdata(bm0_q)
    );
    tdpram #(.AW(16), .DW(4)) u_bmp1 (
        .clk(clk),
        .a_addr(bm_addr), .a_we(bm_we && !drawn0 && !clr_run), .a_wdata(bm_wdata), .a_rdata(),
        .b_addr(b1_addr), .b_we(clr_run && !drawn0),           .b_wdata(4'h0),     .b_rdata(bm1_q)
    );
    // the displayed buffer is the one not being drawn into; graph_processor_r
    // reads it too
    wire [3:0] bm_disp_q = drawn0 ? bm1_q : bm0_q;
    assign bm_rdata = bm_disp_q;

    logic [3:0] bm_pen_cur;
    logic       bm_bank_cur;
    always_ff @(posedge clk) if (cen_pix) begin
        bm_pen_cur  <= bm_disp_q;
        bm_bank_cur <= bm_vaddr[7];
    end

    // =========================================================================
    // motion objects: 64 sprites of 8x16, built into a line buffer one line
    // ahead. The scan runs 63 -> 0 writing every non-zero pen over whatever is
    // there, which is exactly MAME's draw order and leaves sprite 0 on top.
    // =========================================================================
    logic [7:0] mo_vaddr;
    logic [7:0] mo_vq;
    tdpram #(.AW(8), .DW(8)) u_moram (
        .clk(clk),
        .a_addr(mo_addr),  .a_we(mo_we), .a_wdata(mo_wdata), .a_rdata(mo_rdata),
        .b_addr(mo_vaddr), .b_we(1'b0),  .b_wdata(8'h00),    .b_rdata(mo_vq)
    );

    logic [10:0] spr_raddr;
    logic [31:0] spr_q;
    gfxrom u_sprrom (
        .clk(clk),
        .we   (gfx_we && gfx_waddr[13]),
        .waddr({gfx_waddr[11:5], gfx_waddr[4:1]}),
        .wlane({~gfx_waddr[0], gfx_waddr[12]}),
        .wdata(gfx_wdata),
        .raddr(spr_raddr), .q(spr_q)
    );

    // two line buffers: the beam reads one while the engine fills the other
    logic       lb_build;
    logic [7:0] lb_waddr, lb_raddr;
    logic       lb_we;
    logic [3:0] lb_wdata;
    logic [3:0] lb0_q, lb1_q;
    sdpram_rw #(.AW(8), .DW(4)) u_lb0 (
        .clk(clk), .addr(lb_build ? lb_waddr : lb_raddr),
        .we(lb_build & lb_we), .wdata(lb_wdata), .q(lb0_q));
    sdpram_rw #(.AW(8), .DW(4)) u_lb1 (
        .clk(clk), .addr(lb_build ? lb_raddr : lb_waddr),
        .we(~lb_build & lb_we), .wdata(lb_wdata), .q(lb1_q));
    wire [3:0] lb_shown_q = lb_build ? lb1_q : lb0_q;

    always_ff @(posedge clk) if (cen_pix) lb_raddr <= h_p2[7:0];
    logic [3:0] mo_pen_cur;
    always_ff @(posedge clk) if (cen_pix) mo_pen_cur <= lb_shown_q;

    // ---- the build engine ---------------------------------------------------
    // Per line: 256 cycles to blank the buffer, then up to 64 sprites of 17
    // cycles -- 1,344 of the 2,560 system clocks in a line, worst case.
    localparam logic [1:0] M_CLEAR = 2'd0, M_SPRITE = 2'd1, M_DONE = 2'd2;
    logic  [1:0] smode;
    logic  [4:0] step;
    logic  [5:0] sn;
    logic  [7:0] clr_i;
    logic  [7:0] sy_lat, scode_lat, sx_lat;
    logic  [8:0] build_line;
    logic  [3:0] srow;
    logic        sflipx;
    logic signed [9:0] sx_r;
    logic [31:0] srow_px;

    wire signed [9:0] sy_calc  = flip ? $signed({2'b00, sy_lat})
                                      : (10'sd240 - $signed({2'b00, sy_lat}));
    wire signed [9:0] row_calc = $signed({1'b0, build_line}) - sy_calc;
    wire              row_ok   = (row_calc >= 0) && (row_calc <= 10'sd15);
    wire  [3:0] srow_use = flip ? (4'd15 - row_calc[3:0]) : row_calc[3:0];
    wire  [2:0] wpix     = step[2:0];
    wire  [2:0] wsrc     = sflipx ? (3'd7 - wpix) : wpix;
    wire  [3:0] wpen     = srow_px[31 - 4*wsrc -: 4];
    wire signed [9:0] wx = sx_r + $signed({7'd0, wpix});

    always_ff @(posedge clk) begin
        lb_we <= 1'b0;
        if (reset) begin
            smode <= M_DONE; lb_build <= 1'b0; build_line <= '0; step <= '0; sn <= '0;
        end else if (cen_pix && hcnt == HTOTAL - 1) begin
            // a new line begins on this edge: swap buffers and fill the other
            // one for the line after it
            lb_build   <= ~lb_build;
            build_line <= {1'b0, vcnt} + 9'd2;
            smode      <= M_CLEAR;
            clr_i      <= '0;
        end else begin
            case (smode)
                M_CLEAR: begin
                    lb_waddr <= clr_i;
                    lb_wdata <= 4'd0;
                    lb_we    <= 1'b1;
                    if (clr_i == 8'd255) begin
                        smode <= M_SPRITE; sn <= 6'd63; step <= 5'd0;
                    end else begin
                        clr_i <= clr_i + 8'd1;
                    end
                end
                M_SPRITE: begin
                    step <= step + 5'd1;
                    case (step)
                        5'd0: mo_vaddr <= {2'b00, sn};             // Y
                        5'd1: mo_vaddr <= {2'b01, sn};             // code / flip x
                        5'd2: begin sy_lat <= mo_vq; mo_vaddr <= {2'b11, sn}; end   // X
                        5'd3: scode_lat <= mo_vq;
                        5'd4: sx_lat    <= mo_vq;
                        5'd5: begin
                            srow      <= srow_use;
                            sflipx    <= flip ? ~scode_lat[7] : scode_lat[7];
                            sx_r      <= flip ? ($signed({2'b00, sx_lat}) - 10'sd9)
                                              : $signed({2'b00, sx_lat});
                            spr_raddr <= {scode_lat[6:0], srow_use};
                            if (!row_ok) step <= 5'd16;            // off this line
                        end
                        5'd6: ;                                    // sprite ROM read in flight
                        5'd7: srow_px <= spr_q;
                        5'd16: begin
                            if (sn == 6'd0) smode <= M_DONE;
                            else begin sn <= sn - 6'd1; step <= 5'd0; end
                        end
                        default: begin                             // 8..15: the eight pixels
                            lb_waddr <= wx[7:0];
                            lb_wdata <= wpen;
                            lb_we    <= (wpen != 4'd0) && (wx >= 0) && (wx <= 10'sd255);
                        end
                    endcase
                end
                default: ;                                         // M_DONE: idle until the next line
            endcase
        end
    end

    // =========================================================================
    // compositor and palette
    // =========================================================================
    logic [5:0] pix_index;
    always_comb begin
        if (mo_pen_cur != 4'd0)           pix_index = {2'b10, mo_pen_cur};
        else if (bm_pen_cur[2:0] != 3'd0) pix_index = {2'b01, bm_bank_cur, bm_pen_cur[2:0]};
        else                              pix_index = {2'b00, pf_pen};
    end

    logic [5:0] pal_raddr;
    logic [8:0] pal_q;
    tdpram #(.AW(6), .DW(9)) u_palram (
        .clk(clk),
        .a_addr(pal_addr[5:0]), .a_we(pal_we), .a_wdata({pal_addr[6], pal_wdata}), .a_rdata(),
        .b_addr(pal_raddr),     .b_we(1'b0),   .b_wdata(9'h000),                   .b_rdata(pal_q)
    );
    always_ff @(posedge clk) if (cen_pix) pal_raddr <= pix_index;

    // two dots of pipeline: pens -> palette -> colour ladder, syncs to match
    logic [2:0] de_pipe, hs_pipe, vs_pipe;
    wire        de_raw = !hblank && line_active;
    wire        hs_raw = (hcnt >= HS_START) && (hcnt < HS_END);
    always_ff @(posedge clk) if (cen_pix) begin
        de_pipe <= {de_pipe[1:0], de_raw};
        hs_pipe <= {hs_pipe[1:0], hs_raw};
        vs_pipe <= {vs_pipe[1:0], line_vsync};
        red     <= gun(~pal_q[8:6]);
        green   <= gun(~pal_q[5:3]);
        blue    <= gun(~pal_q[2:0]);
    end
    assign de    = de_pipe[1];
    assign hsync = hs_pipe[1];
    assign vsync = vs_pipe[1];

endmodule


//------------------------------------------------------------------------------
// True dual-port block RAM, registered reads on both ports.
//------------------------------------------------------------------------------
module tdpram #(parameter AW = 10, parameter DW = 8) (
    input  logic          clk,
    input  logic [AW-1:0] a_addr,
    input  logic          a_we,
    input  logic [DW-1:0] a_wdata,
    output logic [DW-1:0] a_rdata,
    input  logic [AW-1:0] b_addr,
    input  logic          b_we,
    input  logic [DW-1:0] b_wdata,
    output logic [DW-1:0] b_rdata
);
    (* ramstyle = "no_rw_check" *) logic [DW-1:0] mem [0:(1<<AW)-1] /* verilator public_flat_rw */;
    always_ff @(posedge clk) begin
        if (a_we) mem[a_addr] <= a_wdata;
        a_rdata <= mem[a_addr];
    end
    always_ff @(posedge clk) begin
        if (b_we) mem[b_addr] <= b_wdata;
        b_rdata <= mem[b_addr];
    end
endmodule


//------------------------------------------------------------------------------
// Single-port block RAM with a registered read.
//------------------------------------------------------------------------------
module sdpram_rw #(parameter AW = 8, parameter DW = 4) (
    input  logic          clk,
    input  logic [AW-1:0] addr,
    input  logic          we,
    input  logic [DW-1:0] wdata,
    output logic [DW-1:0] q
);
    (* ramstyle = "no_rw_check" *) logic [DW-1:0] mem [0:(1<<AW)-1] /* verilator public_flat_rw */;
    always_ff @(posedge clk) begin
        if (we) mem[addr] <= wdata;
        q <= mem[addr];
    end
endmodule


//------------------------------------------------------------------------------
// A graphics ROM held one tile row per 32-bit word: eight 4-bit pixels, the
// leftmost in bits 31:28. The image streams in as MAME's region, one byte at a
// time, and each byte carries two pixels into one lane of the word -- which is
// all the odd nibble order of MAME's gfx_layout amounts to (hardware.md 5.1).
//------------------------------------------------------------------------------
module gfxrom (
    input  logic        clk,
    input  logic        we,
    input  logic [10:0] waddr,
    input  logic  [1:0] wlane,
    input  logic  [7:0] wdata,
    input  logic [10:0] raddr,
    output logic [31:0] q
);
    (* ramstyle = "no_rw_check" *) logic [3:0][7:0] mem [0:2047] /* verilator public_flat_rw */;
    always_ff @(posedge clk) begin
        if (we) mem[waddr][wlane] <= wdata;
        q <= mem[raddr];
    end
endmodule

`default_nettype wire
