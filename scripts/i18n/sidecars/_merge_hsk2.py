#!/usr/bin/env python3
"""Merge HSK 2 sidecar parts and apply translations."""
from __future__ import annotations

import runpy
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent))
from sidecar_lib import apply_rows  # noqa: E402

p1 = runpy.run_path(str(HERE / "_build_hsk2_part1.py"))
p2 = runpy.run_path(str(HERE / "_build_hsk2_part2.py"))
rows = p1["ROWS"] + p2["ROWS"]
print(f"hsk2 rows: {len(rows)}")
apply_rows("hsk2", rows)
