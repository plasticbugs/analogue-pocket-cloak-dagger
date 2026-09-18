#!/bin/sh
# Unit bench for cloak_reverb: the comb delays, the decay, the wet level and the
# pass-through, against what the module claims rather than against a recording.
#   sim/run_reverb.sh
set -e
cd "$(dirname "$0")"
verilator --cc --exe --build -j 8 -O2 -Wno-fatal -Wno-DECLFILENAME waivers.vlt \
    --top-module cloak_reverb -Mdir obj_reverb \
    ../rtl/cloak_reverb.sv tb_reverb.cpp > obj_reverb.log 2>&1 \
    || { tail -30 obj_reverb.log; exit 1; }
./obj_reverb/Vcloak_reverb
