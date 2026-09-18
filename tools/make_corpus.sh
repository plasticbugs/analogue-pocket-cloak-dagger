#!/bin/sh
# Build the frozen-state corpus: MAME sessions that dump the video state and a
# PNG snapshot at the listed frames into artifacts/states/.
#   tools/make_corpus.sh [attract|play|all]      (default all)
#
# Cloak & Dagger has no menus: coin, then 1 Player Start, then play. The left
# stick moves and the right stick fires, so the play sequence works both at
# once to get characters, shots and the bitmap layer all moving.
#
# Each target frame is captured together with the NEIGHBOURS frames after it,
# and the first one the reference renderer reproduces pixel-for-pixel is the one
# kept (named for the frame it actually came from). About one frame in ten cannot be reproduced from an
# end-of-frame state at all, because MAME drew it in bands with older playfield
# contents (tools/dump_state.lua, docs/verification.md); those are the ones this
# skips. The corpus is therefore exactly the set of frames for which "load this
# state, draw one frame" is a well-posed question -- which is what the RTL
# bench asks.
set -e
cd "$(dirname "$0")/.."
OUT=artifacts/states
NEIGHBOURS=${NEIGHBOURS:-5}
mkdir -p "$OUT"
WHICH=${1:-all}

run() {  # tag, frames, inputs
    TAG=$1; FRAMES=$2; INPUTS=$3
    SCR=${SCRATCH_BASE:-/tmp/cloak-corpus}/$TAG
    rm -rf "$SCR"
    # expand each target into itself plus NEIGHBOURS following frames
    ALL=""
    for f in $(echo "$FRAMES" | tr , ' '); do
        i=0
        while [ $i -le "$NEIGHBOURS" ]; do ALL="$ALL,$((f+i))"; i=$((i+1)); done
    done
    ALL=${ALL#,}
    STOP=${ALL##*,}
    echo "== $TAG"
    mkdir -p "$SCR/states"
    SCRATCH=$SCR CLOAK_OUT=$SCR/states CLOAK_TAG=$TAG CLOAK_FRAMES=$ALL CLOAK_STOP=$STOP CLOAK_INPUTS="$INPUTS" \
        tools/mame_run.sh tools/dump_state.lua >"$SCR.log" 2>&1 || true
    # pair each dump with its snapshot, in dump order
    i=0
    for f in $(echo "$ALL" | tr , ' '); do
        src=$(printf "%s/snap/cloak/%04d.png" "$SCR" $i)
        [ -f "$src" ] && cp "$src" "$SCR/states/${TAG}_$(printf %05d $f).png"
        i=$((i+1))
    done
    # keep the first coherent frame of each group
    for f in $(echo "$FRAMES" | tr , ' '); do
        i=0; kept=
        while [ $i -le "$NEIGHBOURS" ]; do
            n=$(printf %05d $((f+i)))
            st="$SCR/states/${TAG}_$n.txt"
            if [ -f "$st" ] && [ -f "${st%.txt}.png" ] \
               && python3 tools/render_model.py "$st" --quiet >/dev/null 2>&1; then
                kept=$((f+i))
                tgt="$OUT/${TAG}_$n"          # named for the frame actually kept
                cp "$st" "$tgt.txt"; cp "${st%.txt}.bin" "$tgt.bin"; cp "${st%.txt}.png" "$tgt.png"
                break
            fi
            i=$((i+1))
        done
        if [ -n "$kept" ]; then
            [ "$kept" -eq "$f" ] && echo "  $f" || echo "  $f -> $kept (frame $f was drawn in bands)"
        else
            echo "  $f: NO coherent frame within $NEIGHBOURS -- skipped"
        fi
    done
}

if [ "$WHICH" = attract ] || [ "$WHICH" = all ]; then
    # boot self-test, then the attract loop: instructions, demo play, high scores
    run attract "120,300,600,900,1200,1500,1800,2100,2400,2700" ""
fi

if [ "$WHICH" = play ] || [ "$WHICH" = all ]; then
    # coin at 400, start at 500, then move and fire continuously
    P="900:P1 Left Stick/Right:120,1000:P1 Right Stick/Up:60,1100:P1 Left Stick/Down:120,\
1200:P1 Right Stick/Left:60,1300:P1 Left Stick/Left:120,1400:P1 Right Stick/Down:60,\
1500:P1 Left Stick/Up:120,1600:P1 Right Stick/Right:60,1700:P1 Button 1:20,\
1800:P1 Left Stick/Right:150,1900:P1 Right Stick/Up:90,2000:P1 Left Stick/Up:150,\
2100:P1 Right Stick/Right:90,2200:P1 Left Stick/Down:150,2300:P1 Right Stick/Down:90,\
2400:P1 Left Stick/Left:150,2500:P1 Right Stick/Left:90,2600:P1 Button 1:20,\
2700:P1 Left Stick/Right:180,2800:P1 Right Stick/Up:120,2900:P1 Left Stick/Up:180,\
3000:P1 Right Stick/Right:120,3100:P1 Left Stick/Down:180,3200:P1 Right Stick/Down:120"
    run play "700,1000,1300,1600,1900,2200,2500,2800,3100,3400" \
        "400:Coin 1:8,500:1 Player Start:8,$P"
fi
