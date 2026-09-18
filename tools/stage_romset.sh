#!/bin/sh
# Stage the user's loose MAME romset (cloak_mame/) as build/roms/cloak.zip and
# verify it with MAME, so every tool below has one rompath to point at.
set -e
cd "$(dirname "$0")/.."
SRC=${1:-cloak_mame}
mkdir -p build/roms
rm -f build/roms/cloak.zip
(cd "$SRC" && zip -q -j "$OLDPWD/build/roms/cloak.zip" *.bin *.3n)
mame cloak -rompath "$PWD/build/roms" -verifyroms
