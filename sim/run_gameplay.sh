#!/bin/sh
# Free-running gameplay gate: put the core and MAME through the same coin and
# start from power-on and diff every captured frame.
#
# This is the one comparison the other gates do not make. The frozen-state
# benches load a state and draw one frame; the self-test gate is free-running
# but its screens are static. This runs the actual game, with its own logic
# driving what appears, and asks whether the two machines are still showing the
# same thing twenty seconds in.
#
#   sim/run_gameplay.sh [frame,frame,...]
set -e
cd "$(dirname "$0")"
FRAMES=${1:-$(python3 -c "print(','.join(str(f) for f in range(240, 1501, 30)))")}
STOP=${FRAMES##*,}
REF=${REF:-../artifacts/gameplay}
INPUTS=${INPUTS:-"120:coin1:8,200:start1:8"}
OUT=${OUT:-../artifacts/gameplay_rtl}
[ -d "$REF" ] || { echo "run tools/capture_gameplay.sh first"; exit 1; }
verilator --cc --exe --build -j 8 -O2 -Wno-fatal -Wno-DECLFILENAME +1364-2005ext+v waivers.vlt \
    --top-module cloak_core -Mdir obj_system \
    ../rtl/cloak_pkg.sv ../rtl/cloak_core.sv ../rtl/cloak_video.sv ../rtl/cloak_main.sv \
    ../rtl/cloak_slave.sv ../rtl/cloak_audio.sv ../rtl/pokey.sv ../modules/cpu-t65/gen/t65.v \
    tb_system.cpp > obj_system.log 2>&1 || { tail -40 obj_system.log; exit 1; }
mkdir -p "$OUT"
rm -f "$OUT"/*.ppm 2>/dev/null || true
./obj_system/Vcloak_core ${ROM:-../build/cloak.rom} "$OUT" "$STOP" "$FRAMES" \
    "$INPUTS" > "$OUT/run.log" 2>&1 || { tail -20 "$OUT/run.log"; exit 1; }
REF=$REF OUT=$OUT python3 - "$FRAMES" <<'PY'
import sys, os, subprocess, re
frames = [int(f) for f in sys.argv[1].split(',')]
REF, OUT = os.environ['REF'], os.environ['OUT']
worst = 0.0
rows = []
for f in frames:
    n = '%05d' % f
    out = subprocess.run(['python3', '../tools/diff_frames.py',
                          f'{OUT}/frame_{n}.ppm',
                          f'{REF}/{n}.png'],
                         capture_output=True, text=True).stdout
    m = re.search(r'diff (\d+)/(\d+) \(([\d.]+)%\)', out)
    if not m:
        print(f'frame {f}: no diff output'); sys.exit(1)
    pct = float(m.group(3))
    worst = max(worst, pct)
    rows.append((f, int(m.group(1)), pct))
for f, n, pct in rows:
    bar = '#' * int(pct / 2)
    print(f'  frame {f:5d}  {n:6d} px  {pct:6.2f}%  {bar}')
print(f'\n{len(rows)} frames, worst {worst:.2f}%, '
      f'{sum(1 for _, n, _ in rows if n == 0)} identical')
PY
