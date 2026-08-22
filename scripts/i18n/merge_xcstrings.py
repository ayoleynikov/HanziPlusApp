#!/usr/bin/env python3
"""Merge extra UI strings into Localizable.xcstrings.

Usage:
  python3 scripts/i18n/merge_xcstrings.py
"""
from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
XCSTRINGS = ROOT / "HanziPlus" / "Localizable.xcstrings"
LANGS = ("en", "ru", "es", "pt-BR")


def unit(value: str) -> dict:
    return {"stringUnit": {"state": "translated", "value": value}}


def entry(values: dict[str, str]) -> dict:
    missing = [lang for lang in LANGS if lang not in values]
    if missing:
        raise SystemExit(f"missing langs {missing} in {values.get('en', values)}")
    return {
        "extractionState": "manual",
        "localizations": {lang: unit(values[lang]) for lang in LANGS},
    }


def merge(strings: dict[str, dict[str, str]]) -> int:
    catalog = json.loads(XCSTRINGS.read_text(encoding="utf-8"))
    store = catalog.setdefault("strings", {})
    added = 0
    for key, values in strings.items():
        if key not in store:
            added += 1
        store[key] = entry(values)
    XCSTRINGS.write_text(json.dumps(catalog, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return added


if __name__ == "__main__":
    raise SystemExit("import merge() from remaining_ui_keys.py")
