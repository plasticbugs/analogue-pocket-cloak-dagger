#!/bin/sh
# Convert the vendored VHDL cores (T65 6502, TMS5220 speech) to Verilog with
# GHDL so a single source feeds both Quartus and Verilator. Run from the repo
# root; the outputs (modules/*/gen/*.v) are committed.
set -e
W=$(mktemp -d)
T=modules/cpu-t65
mkdir -p $T/gen
(cd $W && ghdl -a --std=08 -fsynopsys -frelaxed "$OLDPWD/$T/T65_Pack.vhd" "$OLDPWD/$T/T65_MCode.vhd" "$OLDPWD/$T/T65_ALU.vhd" "$OLDPWD/$T/T65.vhd" \
  && ghdl synth --std=08 -fsynopsys -frelaxed --latches --out=verilog T65 > "$OLDPWD/$T/gen/t65.v")
S=modules/sound-tms5220
mkdir -p $S/gen
(cd $W && ghdl -a --std=08 -fsynopsys -frelaxed "$OLDPWD/$S/TMS5220.vhd" \
  && ghdl synth --std=08 -fsynopsys -frelaxed --latches --out=verilog TMS5220 > "$OLDPWD/$S/gen/tms5220.v")
rm -rf $W
wc -l $T/gen/t65.v $S/gen/tms5220.v
