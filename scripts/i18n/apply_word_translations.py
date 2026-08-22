#!/usr/bin/env python3
"""Apply sidecar translations onto a study-set JSON without changing identity fields.

Usage:
  python3 scripts/i18n/apply_word_translations.py hsk1
"""

from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
DATA = ROOT / "HanziPlus" / "Resources" / "Data"
SIDECARS = ROOT / "scripts" / "i18n" / "sidecars"


def apply(name: str) -> None:
    src = DATA / f"{name}.json"
    side = SIDECARS / f"{name}.json"
    words = json.loads(src.read_text(encoding="utf-8"))
    sidecar_raw = json.loads(side.read_text(encoding="utf-8"))
    if isinstance(sidecar_raw, list):
        sidecar = {item["hanzi"]: item for item in sidecar_raw}
    else:
        sidecar = sidecar_raw

    missing = []
    for index, word in enumerate(words):
        hanzi = word["hanzi"]
        entry = sidecar.get(hanzi)
        if not entry:
            missing.append(f"{index}:{hanzi}")
            continue
        word["translations"] = {
            "en": word["english"],
            "ru": entry["ru"],
            "es": entry["es"],
            "pt-BR": entry["pt-BR"],
        }
        examples = word.get("examples") or []
        side_ex = entry.get("examples") or []
        if len(side_ex) != len(examples):
            missing.append(f"{hanzi}: example count {len(side_ex)} != {len(examples)}")
            continue
        new_examples = []
        for example, tr in zip(examples, side_ex):
            if isinstance(example, str):
                new_examples.append(example)
                continue
            example = dict(example)
            if example.get("english"):
                example["translations"] = {
                    "en": example["english"],
                    "ru": tr["ru"],
                    "es": tr["es"],
                    "pt-BR": tr["pt-BR"],
                }
            new_examples.append(example)
        word["examples"] = new_examples

    if missing:
        raise SystemExit(f"{name}: missing sidecar entries:\n" + "\n".join(missing[:40]))

    src.write_text(json.dumps(words, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"applied translations to {name}.json ({len(words)} words)")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        raise SystemExit("usage: apply_word_translations.py <file-stem>")
    apply(sys.argv[1])
