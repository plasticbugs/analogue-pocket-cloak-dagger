#!/bin/sh
# Whole-machine bench: the real game running in cloak_core.
#   sim/run_system.sh [frames] [frame,frame,...] [inputs]
set -e
cd "$(dirname "$0")"
verilator --cc --exe --build -j 8 -O2 -Wno-fatal -Wno-DECLFILENAME +1364-2005ext+v waivers.vlt \
    --top-module cloak_core -Mdir obj_system \
    ../rtl/cloak_pkg.sv ../rtl/cloak_core.sv ../rtl/cloak_video.sv ../rtl/cloak_main.sv \
    ../rtl/cloak_slave.sv ../rtl/cloak_audio.sv ../rtl/pokey.sv ../modules/cpu-t65/gen/t65.v \
    tb_system.cpp > obj_system.log 2>&1 || { tail -40 obj_system.log; exit 1; }
mkdir -p ../artifacts/system
./obj_system/Vcloak_core ${ROM:-../build/cloak.rom} ../artifacts/system "${1:-600}" "${2:-}" "${3:-}"
