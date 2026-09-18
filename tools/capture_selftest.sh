#!/bin/sh
# Capture MAME's power-on self-test screens into artifacts/selftest/, which
# sim/run_selftest.sh diffs the RTL against.
#   tools/capture_selftest.sh [frame,frame,...]
set -e
cd "$(dirname "$0")/.."
FRAMES=${1:-100,140,160,200,250,300,350,400}
STOP=${FRAMES##*,}
SCR=/tmp/cloak-selftest
rm -rf "$SCR"; mkdir -p "$SCR/cfg" artifacts/selftest
# The self-test switch is sampled once at power-on. MAME's Lua cannot change a
# DIPSWITCH field before the first frame, so hand it the cfg a player's F2
# would have produced.
cat > "$SCR/cfg/cloak.cfg" <<'XML'
<?xml version="1.0"?>
<mameconfig version="10">
    <system name="cloak">
        <input>
            <port tag=":SYSTEM" type="DIPSWITCH" mask="2" defvalue="2" value="0" />
        </input>
    </system>
</mameconfig>
XML
SCRATCH=$SCR CLOAK_FRAMES=$FRAMES CLOAK_STOP=$STOP SECONDS_TO_RUN=30 \
    tools/mame_run.sh tools/capture_selftest.lua 2>&1 | grep -E "SYSTEM|snap|rror"
i=0
for f in $(echo "$FRAMES" | tr , ' '); do
    cp "$SCR/snap/cloak/$(printf %04d $i).png" "artifacts/selftest/$(printf %05d $f).png"
    i=$((i+1))
done
echo "wrote $(ls artifacts/selftest/*.png | wc -l | tr -d ' ') reference frames"
