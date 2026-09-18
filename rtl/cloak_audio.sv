//------------------------------------------------------------------------------
// Cloak & Dagger audio output stage.
//
// Both POKEYs feed op-amp summing stages, not the linear mixer most POKEY games
// use: MAME configures them with set_output_opamp_low_pass(1k, C, 5V), and that
// path (pokey.cpp, OPAMP_LOW_PASS) is
//
//     rTot = voltab[out_raw]            // the four channels' ladders in parallel
//     V0   = (r_pullup / rTot) * v_ref / 5
//     out += (V0 - out) * mult          // one pole, once per chip clock
//
// with voltab built from per-channel resistors {90k, 26.5k, 8.05k, 3.4k} and an
// 8 Mohm "off" leakage. Because rTot is a parallel combination and V0 divides by
// it, the whole thing collapses to a sum of four conductances:
//
//     V0 = r_pullup * SUM over channels of 1/r_chan[volume]
//
// -- checked identical to MAME's expression on 2,000 random out_raw values. So
// the ladder is one 16-entry table, looked up four times and added. The levels
// are badly non-linear (0.0005, 0.0115, 0.0381, ... 0.4672); a linear sum of
// volume nibbles would be a different instrument entirely.
//
// The pole is at 1/(2*pi*1k*C): 3.39 kHz for POKEY 1 (0.047 uF) and 7.23 kHz for
// POKEY 2 (0.022 uF), stepped once per 1.25 MHz chip clock exactly as MAME steps
// it once per stream sample at the same rate.
//
// Two things here are deliberately better than the oracle:
//
//  * a boxcar of 26 chip clocks decimates 1.25 MHz to 48.08 kHz. Its nulls sit
//    on the output rate and its multiples, which is exactly where everything
//    that would alias lives. MAME resamples properly on the host; a core that
//    just picked every 26th sample would fold POKEY 2's content back at about
//    -10 dB.
//  * an optional DC blocker. MAME's model leaves in the standing offset of the
//    summing node (its own comment notes the board has a high-pass after this
//    stage that it does not model). Keeping it wastes headroom and thumps when
//    sound starts, so a one-pole high-pass at 24 Hz takes it out.
//------------------------------------------------------------------------------
`default_nettype none

module cloak_audio (
    input  logic        clk,
    input  logic        reset,
    input  logic        cen_pokey,      // 1.25 MHz, the POKEY chip clock
    input  logic [15:0] raw1,           // POKEY 1 m_out_raw
    input  logic [15:0] raw2,           // POKEY 2 m_out_raw
    input  logic        dcblock_en,
    output logic signed [15:0] audio,
    output logic        audio_valid     // one clock per 48.08 kHz sample
);
    // ---- the channel ladder, 1000/r_chan[v] in units of 2^-20 --------------
    function automatic logic [19:0] gcond(input logic [3:0] v);
        case (v)
            4'd0:  gcond = 20'd524;      4'd1:  gcond = 20'd12044;
            4'd2:  gcond = 20'd39962;    4'd3:  gcond = 20'd51482;
            4'd4:  gcond = 20'd130651;   4'd5:  gcond = 20'd142171;
            4'd6:  gcond = 20'd170089;   4'd7:  gcond = 20'd181609;
            4'd8:  gcond = 20'd308798;   4'd9:  gcond = 20'd320318;
            4'd10: gcond = 20'd348236;   4'd11: gcond = 20'd359756;
            4'd12: gcond = 20'd438925;   4'd13: gcond = 20'd450445;
            4'd14: gcond = 20'd478363;   default: gcond = 20'd489882;
        endcase
    endfunction

    function automatic logic [21:0] v0_of(input logic [15:0] raw);
        v0_of = {2'b00, gcond(raw[3:0])}  + {2'b00, gcond(raw[7:4])}
              + {2'b00, gcond(raw[11:8])} + {2'b00, gcond(raw[15:12])};
    endfunction

    // 1 - exp(-1/(C*1k) / 1.25 MHz), as Q0.16
    localparam logic [11:0] MULT1 = 12'd1106;   // 0.047 uF
    localparam logic [11:0] MULT2 = 12'd2340;   // 0.022 uF
    localparam logic  [4:0] DECIM = 5'd26;
    localparam logic [11:0] INV26 = 12'd2521;   // round(65536 / 26)

    logic signed [23:0] acc1, acc2;
    wire  signed [23:0] v0_1  = $signed({2'b00, v0_of(raw1)});
    wire  signed [23:0] v0_2  = $signed({2'b00, v0_of(raw2)});
    wire  signed [39:0] step1 = $signed(v0_1 - acc1) * $signed({1'b0, MULT1});
    wire  signed [39:0] step2 = $signed(v0_2 - acc2) * $signed({1'b0, MULT2});

    // MAME's mono bus: each POKEY routed at 0.50, the sum taken as a stream
    // sample where 1.0 is full scale
    wire signed [25:0] mono = $signed({{2{acc1[23]}}, acc1}) + $signed({{2{acc2[23]}}, acc2});

    // ---- boxcar decimation to 1.25 MHz / 26 = 48.08 kHz --------------------
    logic signed [31:0] box;
    logic         [4:0] boxn;
    wire  signed [31:0] box_tot = box + $signed({{6{mono[25]}}, mono});
    wire  signed [47:0] box_avg = ($signed(box_tot) * $signed({1'b0, INV26})) >>> 16;

    logic signed [25:0] dec_sample;
    logic               dec_valid;

    always_ff @(posedge clk) begin
        dec_valid <= 1'b0;
        if (reset) begin
            acc1 <= '0; acc2 <= '0; box <= '0; boxn <= '0; dec_sample <= '0;
        end else if (cen_pokey) begin
            acc1 <= acc1 + $signed(step1[39:16]);
            acc2 <= acc2 + $signed(step2[39:16]);
            box  <= box_tot;
            if (boxn == DECIM - 5'd1) begin
                boxn       <= '0;
                box        <= '0;
                dec_sample <= box_avg[25:0];
                dec_valid  <= 1'b1;
            end else begin
                boxn <= boxn + 5'd1;
            end
        end
    end

    // ---- DC blocker: y = x - x1 + y1 - y1/8192 (a pole at 24 Hz) -----------
    logic signed [25:0] hp_x1;
    logic signed [31:0] hp_y;
    wire  signed [31:0] dec_ext = $signed({{6{dec_sample[25]}}, dec_sample});
    wire  signed [31:0] hp_x1_e = $signed({{6{hp_x1[25]}}, hp_x1});
    wire  signed [31:0] hp_next = dec_ext - hp_x1_e + hp_y - (hp_y >>> 13);

    always_ff @(posedge clk) begin
        if (reset) begin
            hp_x1 <= '0; hp_y <= '0;
        end else if (dec_valid) begin
            hp_y  <= hp_next;
            hp_x1 <= dec_sample;
        end
    end

    // ---- to the 16-bit bus: full scale is 32767 and each POKEY is at 0.50, so
    //      sample = (acc1 + acc2) * 32767 / 2^21. Clip as MAME's conversion does.
    wire signed [31:0] src  = dcblock_en ? hp_y : dec_ext;
    wire signed [47:0] scal = ($signed(src) * 48'sd32767) >>> 21;

    always_ff @(posedge clk) begin
        if (reset) begin
            audio <= '0; audio_valid <= 1'b0;
        end else begin
            audio_valid <= dec_valid;
            if (scal >  48'sd32767) audio <=  16'sd32767;
            else if (scal < -48'sd32768) audio <= -16'sd32768;
            else audio <= scal[15:0];
        end
    end

endmodule

`default_nettype wire
