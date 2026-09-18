#!/bin/sh
# Frozen-state video gate: every state listed (default: the whole corpus) is
# rendered by cloak_video and diffed against the reference renderer's frame,
# which is itself pixel-identical to MAME's snapshot. Zero differing pixels on
# every state is the pass condition.
#   sim/run_video.sh [state-name ...]
set -e
cd "$(dirname "$0")"
verilator --cc --exe --build -j 8 -O2 -Wno-fatal -Wno-DECLFILENAME \
    --top-module cloak_video -Mdir obj_video \
    ../rtl/cloak_pkg.sv ../rtl/cloak_video.sv tb_video.cpp > obj_video.log 2>&1 \
    || { tail -40 obj_video.log; exit 1; }
mkdir -p ../artifacts/diff
ROM=${ROM:-../build/cloak.rom}
if [ $# -gt 0 ]; then names="$@"; else
    names=$(cd ../artifacts/states && ls *.txt 2>/dev/null | sed 's/\.txt$//')
fi
fail=0; n=0
for s in $names; do
    st=../artifacts/states/$s.txt
    [ -f "$st" ] || { echo "$s: no such state"; fail=1; continue; }
    n=$((n+1))
    if ! ./obj_video/Vcloak_video "$st" "$ROM" ../artifacts/diff/$s.ppm >../artifacts/diff/$s.log 2>&1; then
        echo "FAIL $s (bench)"; tail -3 ../artifacts/diff/$s.log; fail=1; continue
    fi
    if out=$(python3 ../tools/diff_frames.py ../artifacts/diff/$s.ppm ../artifacts/states/$s.png ../artifacts/diff/${s}_diff.png 2>&1); then
        case "$out" in
            diff\ 0/*) echo "PASS $s" ;;
            *) echo "FAIL $s"; echo "$out" | head -6; fail=1 ;;
        esac
    else
        echo "FAIL $s (diff)"; echo "$out" | head -6; fail=1
    fi
done
echo "$n states, $([ $fail = 0 ] && echo 0 || echo some) failed"
[ $fail = 0 ] && echo PASS || { echo FAIL; exit 1; }
