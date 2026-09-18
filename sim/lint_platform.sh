#!/bin/sh
# Verilator over the whole thing the Pocket builds -- apf_top, core_top, the
# platform framework and the core -- so an integration error costs a second
# instead of a twenty-minute Quartus run (METHODOLOGY section 8).
# The PLL and the megafunctions have no simulation model here, so they are
# stubbed; this checks connectivity, widths and declarations, not behaviour.
cd "$(dirname "$0")"
mkdir -p obj_platform/stubs
cat > obj_platform/stubs/core_pll.v <<'STUB'
module core_pll (input wire refclk, input wire rst,
                 output wire outclk_0, output wire outclk_1, output wire outclk_2,
                 output wire outclk_3, output wire outclk_4, output wire locked);
    assign {outclk_0, outclk_1, outclk_2, outclk_3, outclk_4, locked} = 6'b0;
endmodule
STUB
cat > obj_platform/stubs/megafunctions.v <<'STUB'
// Quartus IP with no simulation source in the tree: enough of each to let the
// linter resolve connectivity.
module dcfifo #(parameter clocks_are_synchronized="FALSE", parameter intended_device_family="",
                parameter lpm_numwords=4, parameter lpm_showahead="OFF", parameter lpm_type="",
                parameter lpm_width=32, parameter lpm_widthu=2, parameter overflow_checking="OFF",
                parameter rdsync_delaypipe=5, parameter underflow_checking="OFF",
                parameter use_eab="OFF", parameter wrsync_delaypipe=5)
    (input wire [lpm_width-1:0] data, input wire rdclk, input wire rdreq,
     input wire wrclk, input wire wrreq, output wire [lpm_width-1:0] q,
     output wire rdempty);
    assign q = {lpm_width{1'b0}};
    assign rdempty = 1'b1;
endmodule
module mf_datatable (input wire [9:0] address_a, input wire [9:0] address_b,
                     input wire clock_a, input wire clock_b,
                     input wire [31:0] data_a, input wire [31:0] data_b,
                     input wire wren_a, input wire wren_b,
                     output wire [31:0] q_a, output wire [31:0] q_b);
    assign q_a = 32'd0; assign q_b = 32'd0;
endmodule
module mf_ddio_bidir_12 (input wire oe, input wire [11:0] datain_h, input wire [11:0] datain_l,
                         input wire outclock, output wire [11:0] padio);
    assign padio = 12'd0;
endmodule
STUB
cat > obj_platform/stubs/mf_audio_pll.v <<'STUB'
module mf_audio_pll (input wire refclk, input wire rst,
                     output wire outclk_0, output wire outclk_1, output wire locked);
    assign {outclk_0, outclk_1, locked} = 3'b0;
endmodule
STUB
FILES=$(grep -E "SYSTEMVERILOG_FILE|VERILOG_FILE" ../projects/cloak_pocket.qsf \
        | sed 's/.*FILE //' | sed 's|^\.\./|../|' \
        | grep -v "mf_audio_pll" )
verilator --lint-only -Wno-fatal -Wno-DECLFILENAME -Wno-WIDTHEXPAND -Wno-WIDTHTRUNC \
    -Wno-UNUSEDSIGNAL -Wno-UNDRIVEN -Wno-UNOPTFLAT -Wno-CASEINCOMPLETE -Wno-SYNCASYNCNET \
    -Wno-MULTIDRIVEN -Wno-LATCH -Wno-PINMISSING -Wno-PINCONNECTEMPTY -Wno-TIMESCALEMOD -Wno-REALCVT -Wno-CONTASSREG -Wno-BLKSEQ -Wno-IMPLICITSTATIC -Wno-ASCRANGE \
    +1364-2005ext+v waivers.vlt --top-module apf_top \
    -I../platform/pocket/interface -I../platform/pocket/memory \
    obj_platform/stubs/core_pll.v obj_platform/stubs/mf_audio_pll.v obj_platform/stubs/megafunctions.v \
    $FILES ../target/pocket/core_top.sv \
    ../rtl/cloak_pkg.sv ../rtl/cloak_core.sv ../rtl/cloak_video.sv ../rtl/cloak_main.sv \
    ../rtl/cloak_slave.sv ../rtl/cloak_audio.sv ../rtl/cloak_reverb.sv ../rtl/pokey.sv \
    ../modules/cpu-t65/gen/t65.v 2>&1 | grep -v "^ \|^$" | head -40
