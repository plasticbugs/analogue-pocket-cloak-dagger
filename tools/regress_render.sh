#!/bin/sh
# Every frozen state in artifacts/states/ through the reference renderer,
# requiring zero differing pixels against MAME's own snapshot.
#   tools/regress_render.sh [state-glob]
cd "$(dirname "$0")/.."
fail=0; n=0
for st in artifacts/states/${1:-*}.txt; do
    [ -f "$st" ] || continue
    [ -f "${st%.txt}.png" ] || continue
    n=$((n+1))
    if out=$(python3 tools/render_model.py "$st" --quiet 2>&1); then
        echo "PASS $(basename "$st" .txt)"
    else
        fail=$((fail+1)); echo "FAIL $(basename "$st" .txt)"; echo "$out" | head -4
    fi
done
echo "$n states, $fail failed"
[ "$fail" -eq 0 ]
