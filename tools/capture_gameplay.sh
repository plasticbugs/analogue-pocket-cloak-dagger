#!/bin/sh
# Capture MAME's frames through a coin, a start and the opening of a game into
# artifacts/gameplay/, for sim/run_gameplay.sh to diff the core against.
#   tools/capture_gameplay.sh [frame,frame,...]
set -e
cd "$(dirname "$0")/.."
FRAMES=${1:-$(python3 -c "print(','.join(str(f) for f in range(240, 1501, 30)))")}
STOP=${FRAMES##*,}
SCR=/tmp/cloak-gameplay
rm -rf "$SCR"; mkdir -p "$SCR/cfg" "$SCR/nvram" artifacts/gameplay
rm -f artifacts/gameplay/*.png
SCRATCH=$SCR CLOAK_FRAMES=$FRAMES CLOAK_STOP=$STOP \
  CLOAK_INPUTS="120:Coin 1:8,200:1 Player Start:8" SECONDS_TO_RUN=40 \
  tools/mame_run.sh tools/capture_gameplay.lua 2>&1 | grep -E "Average|rror" || true
i=0
for f in $(echo "$FRAMES" | tr , ' '); do
    cp "$SCR/snap/cloak/$(printf %04d $i).png" "artifacts/gameplay/$(printf %05d $f).png"
    i=$((i+1))
done
echo "captured $(ls artifacts/gameplay/*.png | wc -l | tr -d ' ') MAME frames"
