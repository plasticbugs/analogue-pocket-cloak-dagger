#!/bin/sh
# Verilator lint over the whole core (no bench): the cheap check before a build.
cd "$(dirname "$0")"
verilator --lint-only -Wall -Wno-fatal -Wno-DECLFILENAME +1364-2005ext+v waivers.vlt \
    --top-module cloak_core \
    ../rtl/cloak_pkg.sv ../rtl/cloak_core.sv ../rtl/cloak_video.sv ../rtl/cloak_main.sv \
    ../rtl/cloak_slave.sv ../rtl/cloak_audio.sv ../rtl/pokey.sv \
    ../modules/cpu-t65/gen/t65.v 2>&1 | grep -v "^ \|^%Warning-DECLFILENAME\|^$" | head -60

# The Analogizer wrapper, with the adapter's vendored module behind it and a
# stand-in for its one VHDL file (docs/analogizer.md).  The vendored files are
# kept as upstream wrote them, so their warnings are dropped by path; their
# errors are not, but for one: hq2x.sv (MiSTer's) assigns its output wire in
# an always block, which Quartus takes and Verilator calls an error.
A=../target/pocket/analogizer
verilator --lint-only -Wall -Wno-fatal -Wno-DECLFILENAME -Wno-UNUSEDSIGNAL -Wno-TIMESCALEMOD \
    -Wno-PROCASSWIRE -Wno-PINCONNECTEMPTY --top-module pocket_analogizer \
    ../target/pocket/pocket_analogizer.sv ../platform/pocket/helpers/synch_3.sv \
    $A/*.v $A/*.sv ps2_keyboard_stub.v 2>&1 \
    | grep -E '^%(Error|Warning)' | grep -v 'Exiting due to' \
    | grep -v -E '^%Warning[^ ]*: ([^ ]*/(target/pocket/analogizer|platform/pocket)/|ps2_keyboard_stub)' | head -40
