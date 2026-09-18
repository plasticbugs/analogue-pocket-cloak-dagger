//------------------------------------------------------------------------------
// Atari POKEY (C012294), the audio generator and the two register reads the
// System 2 sound program uses (ALLPOT for the DIP switches, RANDOM).
// Written from MAME's pokey.cpp (ref/mame), keeping its clock-by-clock
// order of operations so the RTL's output is the emulator's: the four
// channel counters, the 4/5/9/17-bit polynomial counters, the 28- and
// 114-clock prescalers, 16-bit joining, 1.79 MHz clocking, the high-pass
// filters and the volume-only mode. The serial port, keyboard scan, pot
// scan and interrupts are not modelled beyond their register reads.
//
// `cen` is the chip clock (1.25 MHz on this board). Two outputs: `sum` is the
// sum of the four channels' volume nibbles (0-60), which is what MAME's
// LEGACY_LINEAR output uses, and `out_raw` is MAME's m_out_raw -- the four
// volumes packed four bits each, which is what every other output type indexes
// its resistance table with. Cloak & Dagger takes the second one; see
// rtl/cloak_audio.sv.
//------------------------------------------------------------------------------
`default_nettype none

module pokey (
    input  logic       clk,
    input  logic       reset,
    input  logic       cen,
    input  logic [3:0] addr,
    input  logic       we,
    input  logic [7:0] wdata,
    output logic [7:0] rdata,           // combinational for the current addr
    input  logic [7:0] allpot,          // the ALLPOT input port (DIP switches)
    output logic [5:0] sum,
    output logic [15:0] out_raw         // MAME's m_out_raw: volume per channel, 4 bits each
);
    // register / state
    logic [7:0] audf [4];
    logic [7:0] audc [4];
    logic [7:0] audctl, skctl;
    logic [7:0] counter [4];
    logic [3:0] borrow [4];
    logic       outp [4];
    logic       fsamp [4];
    logic [4:0] cnt28;
    logic [6:0] cnt114;
    logic [3:0]  lfsr4;
    logic [4:0]  lfsr5;
    logic [8:0]  lfsr9;
    logic [16:0] lfsr17;

    // polynomial steps (poly_init_4_5 / poly_init_9_17)
    function automatic logic [3:0]  n4(input logic [3:0] l);  n4 = {l[2:0], ~(l[2] ^ l[3])}; endfunction
    function automatic logic [4:0]  n5(input logic [4:0] l);  n5 = {l[3:0], ~(l[2] ^ l[4])}; endfunction
    function automatic logic [8:0]  n9(input logic [8:0] l);  n9 = {l[0] ^ l[5], l[8:1]}; endfunction
    function automatic logic [16:0] n17(input logic [16:0] l);
        // in8 = bit8 ^ bit13, in = bit0; lfsr >>= 1; bit 7 <- in8; bit 16 <- in
        logic [16:0] t;
        t = {1'b0, l[16:1]};
        t[7] = l[8] ^ l[13];
        t[16] = l[0];
        n17 = t;
    endfunction
    // MAME's tables hold the state after one step from the seed (0 for 4/5,
    // all ones for 9/17) at index 0 and pre-increment the index before use,
    // so at reset the registers hold table[0] and every clock advances first
    localparam logic [3:0]  P4_0  = 4'b0001;    // n4(0)
    localparam logic [4:0]  P5_0  = 5'b00001;   // n5(0)

    wire sk_reset = (skctl[1:0] != 2'b00);

    // ---- reads ---------------------------------------------------------------
    always_comb begin
        case (addr)
            4'h8: rdata = sk_reset ? allpot : 8'h00;                 // ALLPOT
            4'h9: rdata = 8'h09;                                      // KBCODE (no keyboard)
            4'ha: rdata = audctl[7] ? lfsr9[7:0] : lfsr17[15:8];      // RANDOM
            4'he: rdata = 8'hf7;                                      // IRQST: only SEROC set (active low)
            4'hf: rdata = 8'hff;                                      // SKSTAT
            default: rdata = 8'h00;                                   // POTx, SERIN
        endcase
    end

    // ---- the chip clock ----------------------------------------------------------
    always_ff @(posedge clk) begin
        if (reset) begin
            for (int i = 0; i < 4; i++) begin audf[i] <= 8'h00; audc[i] <= 8'hb0; counter[i] <= 8'h00; borrow[i] <= 4'd0; outp[i] <= 1'b0; fsamp[i] <= 1'b0; end
            audctl <= 8'h00; skctl <= 8'h00; cnt28 <= '0; cnt114 <= '0;
            lfsr4 <= P4_0; lfsr5 <= P5_0; lfsr9 <= n9(9'h1ff); lfsr17 <= n17(17'h1ffff);
            sum <= 6'd0; out_raw <= 16'd0;
        end else begin
            // -------- register writes (write_internal) --------
            if (we) case (addr)
                4'h0: audf[0] <= wdata;  4'h1: audc[0] <= wdata;
                4'h2: audf[1] <= wdata;  4'h3: audc[1] <= wdata;
                4'h4: audf[2] <= wdata;  4'h5: audc[2] <= wdata;
                4'h6: audf[3] <= wdata;  4'h7: audc[3] <= wdata;
                4'h8: audctl <= wdata;
                4'h9: begin                                   // STIMER: reset all counters
                    for (int i = 0; i < 4; i++) begin
                        counter[i] <= audf[i] ^ 8'hff; borrow[i] <= 4'd0; outp[i] <= 1'b0; fsamp[i] <= (i < 2);
                    end
                end
                4'hf: begin                                   // SKCTL
                    if (wdata != skctl) begin
                        skctl <= wdata;
                        if (wdata[1:0] == 2'b00) begin
                            // reset and hold the polynomial counters and prescalers
                            lfsr4 <= P4_0; lfsr5 <= P5_0; lfsr9 <= n9(9'h1ff); lfsr17 <= n17(17'h1ffff);
                            cnt28 <= '0; cnt114 <= '0;
                        end
                    end
                end
                default: ;                                    // SKREST, POTGO, SEROUT, IRQEN: no effect here
            endcase

            // -------- step_one_clock --------
            // (a STIMER or SKCTL write in the same clock takes precedence over the step)
            if (cen && !(we && (addr == 4'h9 || addr == 4'hf))) begin
                // working copies, updated in MAME's order with blocking assignments
                automatic logic [7:0] c [4];
                automatic logic [3:0] bw [4];
                automatic logic       o [4];
                automatic logic       fs [4];
                automatic logic [3:0]  l4;
                automatic logic [4:0]  l5;
                automatic logic [8:0]  l9;
                automatic logic [16:0] l17;
                automatic logic trig28, trig114, trig1, trigbase;
                automatic logic [4:0] c28;
                automatic logic [6:0] c114;
                automatic logic b3, b4, b1, b2;
                automatic logic [5:0]  s;
                automatic logic [15:0] raw;
                for (int i = 0; i < 4; i++) begin c[i] = counter[i]; bw[i] = borrow[i]; o[i] = outp[i]; fs[i] = fsamp[i]; end
                l4 = lfsr4; l5 = lfsr5; l9 = lfsr9; l17 = lfsr17; c28 = cnt28; c114 = cnt114;
                trig28 = 1'b0; trig114 = 1'b0; trig1 = 1'b1; trigbase = 1'b0;

                if (sk_reset) begin
                    l4 = n4(l4); l5 = n5(l5); l9 = n9(l9); l17 = n17(l17);
                    if (c28 == 5'd27) begin c28 = 5'd0; trig28 = 1'b1; end else c28 = c28 + 5'd1;
                    if (c114 == 7'd113) begin c114 = 7'd0; trig114 = 1'b1; end else c114 = c114 + 7'd1;
                    trigbase = audctl[0] ? trig114 : trig28;

                    // channel 1: 1.79 MHz clock, else the base clock
                    if (audctl[6] && trig1) begin
                        c[0] = c[0] + 8'd1;
                        if (c[0] == 8'h00 && bw[0] == 4'd0) bw[0] = audctl[4] ? 4'd7 : 4'd4;
                    end
                    if (!audctl[6] && trigbase) begin
                        c[0] = c[0] + 8'd1;
                        if (c[0] == 8'h00 && bw[0] == 4'd0) bw[0] = 4'd1;
                    end
                    // channel 3
                    if (audctl[5] && trig1) begin
                        c[2] = c[2] + 8'd1;
                        if (c[2] == 8'h00 && bw[2] == 4'd0) bw[2] = audctl[3] ? 4'd7 : 4'd4;
                    end
                    if (!audctl[5] && trigbase) begin
                        c[2] = c[2] + 8'd1;
                        if (c[2] == 8'h00 && bw[2] == 4'd0) bw[2] = 4'd1;
                    end
                    // channels 2 and 4 on the base clock unless joined
                    if (trigbase) begin
                        if (!audctl[4]) begin
                            c[1] = c[1] + 8'd1;
                            if (c[1] == 8'h00 && bw[1] == 4'd0) bw[1] = 4'd1;
                        end
                        if (!audctl[3]) begin
                            c[3] = c[3] + 8'd1;
                            if (c[3] == 8'h00 && bw[3] == 4'd0) bw[3] = 4'd1;
                        end
                    end
                end

                // borrows, in MAME's order: 3, 4, 1, 2
                b3 = 1'b0; if (bw[2] != 4'd0) begin bw[2] = bw[2] - 4'd1; b3 = (bw[2] == 4'd0); end
                if (b3) begin
                    if (audctl[3]) begin
                        c[3] = c[3] + 8'd1;
                        if (c[3] == 8'h00 && bw[3] == 4'd0) bw[3] = 4'd1;
                    end else begin
                        c[2] = audf[2] ^ 8'hff; bw[2] = 4'd0;
                    end
                    // process_channel(3)
                    if (audc[2][7] || l5[0]) begin
                        if (audc[2][5]) o[2] = ~o[2];
                        else if (audc[2][6]) o[2] = l4[0];
                        else if (audctl[7]) o[2] = l9[0];
                        else o[2] = l17[0];
                    end
                    if (audctl[2]) fs[0] = o[0]; else fs[0] = 1'b1;
                end
                b4 = 1'b0; if (bw[3] != 4'd0) begin bw[3] = bw[3] - 4'd1; b4 = (bw[3] == 4'd0); end
                if (b4) begin
                    if (audctl[3]) begin c[2] = audf[2] ^ 8'hff; bw[2] = 4'd0; end
                    c[3] = audf[3] ^ 8'hff; bw[3] = 4'd0;
                    if (audc[3][7] || l5[0]) begin
                        if (audc[3][5]) o[3] = ~o[3];
                        else if (audc[3][6]) o[3] = l4[0];
                        else if (audctl[7]) o[3] = l9[0];
                        else o[3] = l17[0];
                    end
                    if (audctl[1]) fs[1] = o[1]; else fs[1] = 1'b1;
                end
                b1 = 1'b0; if (bw[0] != 4'd0) begin bw[0] = bw[0] - 4'd1; b1 = (bw[0] == 4'd0); end
                if (b1) begin
                    if (audctl[4]) begin
                        c[1] = c[1] + 8'd1;
                        if (c[1] == 8'h00 && bw[1] == 4'd0) bw[1] = 4'd1;
                    end else begin
                        c[0] = audf[0] ^ 8'hff; bw[0] = 4'd0;
                    end
                    if (audc[0][7] || l5[0]) begin
                        if (audc[0][5]) o[0] = ~o[0];
                        else if (audc[0][6]) o[0] = l4[0];
                        else if (audctl[7]) o[0] = l9[0];
                        else o[0] = l17[0];
                    end
                end
                b2 = 1'b0; if (bw[1] != 4'd0) begin bw[1] = bw[1] - 4'd1; b2 = (bw[1] == 4'd0); end
                if (b2) begin
                    if (audctl[4]) begin c[0] = audf[0] ^ 8'hff; bw[0] = 4'd0; end
                    c[1] = audf[1] ^ 8'hff; bw[1] = 4'd0;
                    if (audc[1][7] || l5[0]) begin
                        if (audc[1][5]) o[1] = ~o[1];
                        else if (audc[1][6]) o[1] = l4[0];
                        else if (audctl[7]) o[1] = l9[0];
                        else o[1] = l17[0];
                    end
                end

                // output: volume of every channel whose (output ^ filter) is set or is volume-only
                s = 6'd0; raw = 16'd0;
                for (int i = 0; i < 4; i++)
                    if ((o[i] ^ fs[i]) || audc[i][4]) begin
                        s = s + {2'b00, audc[i][3:0]};
                        raw[4*i +: 4] = audc[i][3:0];
                    end

                for (int i = 0; i < 4; i++) begin counter[i] <= c[i]; borrow[i] <= bw[i]; outp[i] <= o[i]; fsamp[i] <= fs[i]; end
                lfsr4 <= l4; lfsr5 <= l5; lfsr9 <= l9; lfsr17 <= l17; cnt28 <= c28; cnt114 <= c114;
                sum <= s; out_raw <= raw;
            end
        end
    end
endmodule

`default_nettype wire
