#!/bin/sh
# Unit bench for cloak_audio: the op-amp ladder, the decimator and the DC
# blocker, checked against the arithmetic rather than against a recording.
#   sim/run_audio_unit.sh
set -e
cd "$(dirname "$0")"
verilator --cc --exe --build -j 8 -O2 -Wno-fatal -Wno-DECLFILENAME waivers.vlt \
    --top-module cloak_audio -Mdir obj_audio_unit \
    ../rtl/cloak_audio.sv tb_audio.cpp > obj_audio_unit.log 2>&1 \
    || { tail -30 obj_audio_unit.log; exit 1; }
./obj_audio_unit/Vcloak_audio
