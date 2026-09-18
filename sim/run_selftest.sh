#!/bin/sh
# Whole-machine gate: run the real game from power-on with the self-test switch
# on and require every captured frame to match MAME's snapshot exactly. This
# exercises both 6502s, the whole memory map, the inter-CPU communication RAM
# and the video path together -- the game's own diagnostic is the test.
#   sim/run_selftest.sh [frame,frame,...]
#
# The default frames are the settled pages of the test. Frames in the first
# ~90, and past ~450, are not comparable: the test prints its lines and turns
# its pages at a rate set by how many CPU cycles fit in a frame, and this core
# gives the master 16,384 per frame against MAME's 16,666 because it runs the
# board's own 61.04 Hz rather than MAME's round 60 (docs/hardware.md 2). The
# pages themselves, which is what the test is for, match to the pixel.
set -e
cd "$(dirname "$0")"
FRAMES=${1:-100,140,160,200,250,300,350,400}
STOP=${FRAMES##*,}
[ -f ../artifacts/selftest/00100.png ] || { echo "run tools/capture_selftest.sh first"; exit 1; }
verilator --cc --exe --build -j 8 -O2 -Wno-fatal -Wno-DECLFILENAME +1364-2005ext+v waivers.vlt \
    --top-module cloak_core -Mdir obj_system \
    ../rtl/cloak_pkg.sv ../rtl/cloak_core.sv ../rtl/cloak_video.sv ../rtl/cloak_main.sv \
    ../rtl/cloak_slave.sv ../rtl/cloak_audio.sv ../rtl/pokey.sv ../modules/cpu-t65/gen/t65.v \
    tb_system.cpp > obj_system.log 2>&1 || { tail -40 obj_system.log; exit 1; }
mkdir -p ../artifacts/selftest_rtl
./obj_system/Vcloak_core ${ROM:-../build/cloak.rom} ../artifacts/selftest_rtl "$STOP" "$FRAMES" "1:test:100000" \
    > ../artifacts/selftest_rtl/run.log 2>&1 || { tail -20 ../artifacts/selftest_rtl/run.log; exit 1; }
fail=0
for f in $(echo "$FRAMES" | tr , ' '); do
    n=$(printf %05d $f)
    out=$(python3 ../tools/diff_frames.py ../artifacts/selftest_rtl/frame_$n.ppm ../artifacts/selftest/$n.png 2>&1 | head -1)
    case "$out" in
        diff\ 0/*) echo "PASS frame $f" ;;
        *) echo "FAIL frame $f: $out"; fail=1 ;;
    esac
done
[ $fail = 0 ] && echo PASS || { echo FAIL; exit 1; }
