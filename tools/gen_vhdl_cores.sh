#!/bin/sh
# Convert the vendored T65 6502 from VHDL to Verilog with GHDL, so one source
# feeds both Quartus and Verilator. Run from the repo root; the output
# (modules/cpu-t65/gen/t65.v) is committed, so this is only needed when the
# vendored core is updated.
set -e
W=$(mktemp -d)
T=modules/cpu-t65
mkdir -p $T/gen
(cd $W && ghdl -a --std=08 -fsynopsys -frelaxed "$OLDPWD/$T/T65_Pack.vhd" "$OLDPWD/$T/T65_MCode.vhd" "$OLDPWD/$T/T65_ALU.vhd" "$OLDPWD/$T/T65.vhd" \
  && ghdl synth --std=08 -fsynopsys -frelaxed --latches --out=verilog T65 > "$OLDPWD/$T/gen/t65.v")
rm -rf $W
wc -l $T/gen/t65.v
