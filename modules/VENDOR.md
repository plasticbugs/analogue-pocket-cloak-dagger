# Vendored modules

These directories are third-party HDL cores vendored into the tree (no
submodules -- the whole point is a self-contained, reproducible build). Each was
copied from its upstream repository at the commit below; their own LICENSE files
are kept alongside the sources.

| module | upstream | commit |
|---|---|---|
| cpu-t65 | https://github.com/mist-devel/T65 (by way of the Punch-Out!!, S.T.U.N. Runner and Atari System 2 cores in this series) | vendored, unmodified |

Cloak & Dagger has **two** 6502s -- a master at 1.0 MHz and a slave at 1.25 MHz
that does nothing but draw into the bitmap -- and both are T65 instances
(`rtl/cloak_main.sv`, `rtl/cloak_slave.sv`). T65 is the 6502 these cores have
used throughout; it is a well-proven core and the integration pattern (a
registered copy of the bus one clock behind the Enable edge) carries over
unchanged from the Atari System 2 sound board.

`cpu-t65/gen/t65.v` is the GHDL conversion of the VHDL (`tools/gen_vhdl_cores.sh`);
that Verilog is what both Quartus and Verilator compile.

To update: re-copy from upstream at the new commit (do not add it as a
submodule) and record the commit here.

The POKEYs are not vendored. `rtl/pokey.sv` is written from MAME's
`pokey.cpp`, keeping its clock-by-clock order of operations, and came from the
Atari System 2 core in this series where it was checked against MAME's own
output.
