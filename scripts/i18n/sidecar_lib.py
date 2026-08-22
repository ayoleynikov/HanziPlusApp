#!/usr/bin/env python3
"""Build and apply a sidecar from ordered rows matching a study JSON."""
from __future__ import annotations
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
DATA = ROOT / "HanziPlus/Resources/Data"
SIDECARS = ROOT / "scripts/i18n/sidecars"


def apply_rows(name: str, rows: list) -> None:
    src = json.loads((DATA / f"{name}.json").read_text(encoding="utf-8"))
    if len(rows) != len(src):
        raise SystemExit(f"{name}: rows {len(rows)} != src {len(src)}")
    sidecar = {}
    for word, row in zip(src, rows):
        ru, es, pt, examples = row
        src_ex = word.get("examples") or []
        if len(examples) != len(src_ex):
            raise SystemExit(f"{name} {word['hanzi']}: examples {len(examples)} != {len(src_ex)}")
        sidecar[word["hanzi"]] = {
            "ru": ru,
            "es": es,
            "pt-BR": pt,
            "examples": [{"ru": a, "es": b, "pt-BR": c} for a, b, c in examples],
        }
    SIDECARS.mkdir(parents=True, exist_ok=True)
    (SIDECARS / f"{name}.json").write_text(
        json.dumps(sidecar, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    print(f"wrote sidecar {name} ({len(sidecar)})")
