#!/bin/sh
# Audio bench: run the machine from power-on through a coin and a start, record
# every sample the core produces, and compare it against MAME's recording of
# the same sequence. Aligned on the first sound rather than on time zero,
# because the two run at different frame rates (docs/verification.md 6.1).
#   sim/run_audio.sh [frames]        (default 1500)
# tools/capture_audio.sh writes the MAME side.
set -e
cd "$(dirname "$0")"
FRAMES=${1:-1500}
verilator --cc --exe --build -j 8 -O2 -Wno-fatal -Wno-DECLFILENAME +1364-2005ext+v waivers.vlt \
    --top-module cloak_core -Mdir obj_audio \
    ../rtl/cloak_pkg.sv ../rtl/cloak_core.sv ../rtl/cloak_video.sv ../rtl/cloak_main.sv \
    ../rtl/cloak_slave.sv ../rtl/cloak_audio.sv ../rtl/pokey.sv ../modules/cpu-t65/gen/t65.v \
    tb_system.cpp > obj_audio.log 2>&1 || { tail -40 obj_audio.log; exit 1; }
mkdir -p ../artifacts/audio
[ -f ../artifacts/audio/mame_play.wav ] || { echo "run tools/capture_audio.sh first"; exit 1; }
./obj_audio/Vcloak_core ${ROM:-../build/cloak.rom} ../artifacts/audio "$FRAMES" "" \
    "120:coin1:8,200:start1:8" ../artifacts/audio/rtl_play.wav
python3 ../tools/compare_audio.py ../artifacts/audio/mame_play.wav ../artifacts/audio/rtl_play.wav \
    --onset --skip 0.05 --window 1.0
