#!/usr/bin/env python3
"""Count the differing pixels between two PNGs of the same size (a bench
frame against a MAME snapshot), optionally writing a diff image.

    diff_png.py <a.png> <b.png> [diff.png]
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from render_model import read_png, write_png, unrotate

a, b = unrotate(read_png(sys.argv[1])), unrotate(read_png(sys.argv[2]))
h, w = min(len(a), len(b)), min(len(a[0]), len(b[0]))
n, img = 0, []
for y in range(h):
    row = []
    for x in range(w):
        if a[y][x] != b[y][x]: n += 1; row.append((255, 0, 255))
        else: row.append(tuple(c // 3 for c in a[y][x]))
    img.append(row)
print(f"{os.path.basename(sys.argv[1])} vs {os.path.basename(sys.argv[2])}: {n} of {w*h} pixels differ")
if len(sys.argv) > 3: write_png(sys.argv[3], img)
sys.exit(1 if n else 0)
