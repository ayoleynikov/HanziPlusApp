#!/usr/bin/env python3
from __future__ import annotations
import runpy
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent))
from sidecar_lib import apply_rows  # noqa: E402

rows = []
for name in ("_build_hsk3_part1.py", "_build_hsk3_part2.py", "_build_hsk3_part3.py"):
    part = runpy.run_path(str(HERE / name))
    print(name, len(part["ROWS"]))
    rows.extend(part["ROWS"])
print("hsk3 rows:", len(rows))
apply_rows("hsk3", rows)
