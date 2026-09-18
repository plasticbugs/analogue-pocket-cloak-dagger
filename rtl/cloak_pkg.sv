//------------------------------------------------------------------------------
// Constants shared across the Cloak & Dagger core (docs/hardware.md).
//------------------------------------------------------------------------------
`ifndef CLOAK_PKG_SV
`define CLOAK_PKG_SV

package cloak_pkg;

    // ---- video timing (docs/hardware.md section 2) ---------------------------
    // 320 dot clocks per line at 5 MHz, 256 lines per frame. The vertical
    // timing PROM 136023-116 says which lines are active and which carry
    // VSYNC; the counter here is MAME's screen row, which is the PROM's index
    // plus one, so every PROM lookup uses vcnt-1.
    localparam logic [8:0] HTOTAL   = 9'd320;
    localparam logic [8:0] HACTIVE  = 9'd256;   // dots 0..255
    localparam logic [8:0] HS_START = 9'd272;   // 16 dots of front porch
    localparam logic [8:0] HS_END   = 9'd304;   // 32 dots of sync, 16 of back porch
    localparam int         VTOTAL   = 256;
    localparam int         VACTIVE0 = 24;       // first active row (PROM index 23)
    localparam int         VACTIVE1 = 255;      // last  active row (PROM index 254)
    localparam int         VIS_W    = 256;
    localparam int         VIS_H    = 232;

    // ---- palette index allocation (cloak.cpp's comment) ---------------------
    localparam logic [5:0] PAL_PF  = 6'h00;   // 0-15  playfield
    localparam logic [5:0] PAL_BMP = 6'h10;   // 16-31 bitmap, 128H picks the bank
    localparam logic [5:0] PAL_MO  = 6'h20;   // 32-47 motion objects

    // The three colour guns are 3-bit ladders of 10k / 4.7k / 2.2k pulled up
    // through 1k. These are MAME's compute_resistor_weights outputs, rounded
    // the way combine_weights rounds them; index bit 0 is the 10k leg. The
    // ladder is nowhere near linear -- do not replace this with a shift.
    function automatic logic [7:0] gun(input logic [2:0] v);
        case (v)
            3'd0: gun = 8'd0;
            3'd1: gun = 8'd74;
            3'd2: gun = 8'd82;
            3'd3: gun = 8'd157;
            3'd4: gun = 8'd98;
            3'd5: gun = 8'd173;
            3'd6: gun = 8'd181;
            default: gun = 8'd255;
        endcase
    endfunction

endpackage

`endif
