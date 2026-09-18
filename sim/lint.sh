#!/bin/sh
# Verilator lint over the whole core (no bench): the cheap check before a build.
cd "$(dirname "$0")"
verilator --lint-only -Wall -Wno-fatal -Wno-DECLFILENAME +1364-2005ext+v waivers.vlt \
    --top-module cloak_core \
    ../rtl/cloak_pkg.sv ../rtl/cloak_core.sv ../rtl/cloak_video.sv ../rtl/cloak_main.sv \
    ../rtl/cloak_slave.sv ../rtl/cloak_audio.sv ../rtl/pokey.sv \
    ../modules/cpu-t65/gen/t65.v 2>&1 | grep -v "^ \|^%Warning-DECLFILENAME\|^$" | head -60
