#!/usr/bin/env python3
"""Assemble an Analogue Pocket SD-card package from the compiled bitstream.

The Pocket loads a bit-reversed RBF (each byte's bits swapped) named per
core.json ("bitstream.rbf_r"). Output goes to release/pocket/ ready to copy
onto the SD card root.

Never ships a ROM: the copy step excludes them and there is a final sweep that
fails the package if one slipped through anyway.
"""
import os, shutil, sys

ROOT = os.path.dirname(os.path.abspath(__file__))
RBF = os.path.join(ROOT, "projects", "output_files", "cloak_pocket.rbf")
PKG = os.path.join(ROOT, "pkg", "pocket")
OUT = os.path.join(ROOT, "release", "pocket")
CORE_ID = "plasticbugs.cloak"
PLATFORM_ID = "cloak"

if not os.path.exists(RBF):
    sys.exit(f"missing {RBF} - run the Quartus compile first "
             "(and make sure the project generates a compressed RBF)")

REV = bytes(int(f"{b:08b}"[::-1], 2) for b in range(256))
reversed_rbf = bytes(REV[b] for b in open(RBF, "rb").read())

if os.path.exists(OUT):
    shutil.rmtree(OUT)
# ROMs may sit in pkg/pocket/Assets locally (gitignored); never package them.
shutil.copytree(PKG, OUT, ignore=shutil.ignore_patterns('.DS_Store', '*.rom', '*.zip'))

core_dir = os.path.join(OUT, "Cores", CORE_ID)
with open(os.path.join(core_dir, "bitstream.rbf_r"), "wb") as f:
    f.write(reversed_rbf)

# Ship the ROM recipe and its builder alongside the core, so a downloaded
# release contains everything needed to produce cloak.rom.
for extra in ("cloak.mra", "README.md", os.path.join("tools", "mra_build.py")):
    src = os.path.join(ROOT, extra)
    if os.path.exists(src):
        shutil.copy(src, os.path.join(OUT, os.path.basename(extra)))

# Backstop: the Pocket refuses a core whose interact.json has more than 16
# entries or a name (variable or option) longer than 23 characters -- it
# reports "error in interact" at load. Check here rather than on the device.
import json
with open(os.path.join(core_dir, "interact.json")) as f:
    variables = json.load(f)["interact"]["variables"]
problems = []
if len(variables) > 16:
    problems.append(f"{len(variables)} entries (limit 16)")
for v in variables:
    if len(v["name"]) > 23:
        problems.append(f'name too long: "{v["name"]}"')
    for o in v.get("options", []):
        if len(o["name"]) > 23:
            problems.append(f'option too long: "{o["name"]}" in "{v["name"]}"')
    if len(v.get("options", [])) > 16:
        problems.append(f'{len(v["options"])} options in "{v["name"]}" (limit 16)')
if problems:
    sys.exit("refusing to package, interact.json:\n  " + "\n  ".join(problems))
# The Pocket also reads interact.json through two fixed buffers, measured
# on the device: about 8 KB for the file (a 7,849-byte pretty-printed file
# loaded, a 9,462-byte one gave "error in interact") and about 5 KB for one
# line (minified to a single line, 5,119 characters loaded and 5,232 did
# not). The packaged copy is compact with one menu entry per line -- every
# line short, the file small -- and both are capped here; pkg/ keeps the
# readable source.
with open(os.path.join(core_dir, "interact.json")) as f:
    interact_full = json.load(f)
head = {k: v for k, v in interact_full["interact"].items() if k != "variables"}
lines = ['{"interact":{' + ",".join(json.dumps(k, separators=(",", ":")) + ":" + json.dumps(v, separators=(",", ":")) for k, v in head.items()) + ',"variables":[']
vars_ = interact_full["interact"]["variables"]
for i, v in enumerate(vars_):
    lines.append(json.dumps(v, separators=(",", ":")) + ("," if i < len(vars_) - 1 else ""))
lines.append("]}}")
compact = "\n".join(lines) + "\n"
json.loads(compact)   # must still be the same document
assert json.loads(compact) == interact_full
longest = max(len(l) for l in lines)
if len(compact) > 7000 or longest > 3000:
    sys.exit(f"refusing to package, interact.json is {len(compact)} bytes with a {longest}-character line (the Pocket's limits are about 8 KB and 5 KB)")
with open(os.path.join(core_dir, "interact.json"), "w") as f:
    f.write(compact)

# Backstop: the Pocket auto-loads the single ROM slot by the filename in
# data.json, so there are no instance JSONs here -- but the Assets directory
# still has to exist or the Pocket has nowhere to look for cloak.rom.
inst_dir = os.path.join(OUT, "Assets", PLATFORM_ID, "common")
os.makedirs(inst_dir, exist_ok=True)

# Backstop: the previews make_images.py writes are for looking at, not shipping.
for dp, _, fs in os.walk(OUT):
    for f in fs:
        if f.endswith("_preview.png"):
            os.remove(os.path.join(dp, f))

# Backstop: a gitignored test ROM in the package tree must never reach a release.
strays = [os.path.join(dp, f) for dp, _, fs in os.walk(OUT) for f in fs
          if f.lower().endswith(('.rom', '.zip'))]
if strays:
    sys.exit("refusing to package, ROM files present:\n  " + "\n  ".join(strays))

print(f"packaged -> {OUT}")
print("copy Cores/, Platforms/ and Assets/ from that folder onto the SD card root")
print(f"the ROM image goes in Assets/{PLATFORM_ID}/common/cloak.rom")
print("build it with:  python3 mra_build.py cloak.mra cloak.zip")
