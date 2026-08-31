#!/usr/bin/env python3
"""Fill null dialogue/example translations in Path course lessons from sidecar."""

from __future__ import annotations

import json
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent
PATH_COURSE = ROOT / "Resources" / "PathCourse"
SIDECAR = SCRIPT_DIR / "path_phrase_translations.json"

LOCALES = ("ru", "en", "es", "pt-BR")


def has_translation(value: object) -> bool:
    if value is None:
        return False
    if isinstance(value, str):
        stripped = value.strip()
        return bool(stripped) and not stripped.upper().startswith("TODO")
    if isinstance(value, dict):
        return any(
            isinstance(v, str) and v.strip() and not v.strip().upper().startswith("TODO")
            for v in value.values()
        )
    return False


def load_sidecar() -> dict[str, dict[str, str]]:
    if not SIDECAR.exists():
        raise SystemExit(f"Missing sidecar: {SIDECAR}")
    data = json.loads(SIDECAR.read_text(encoding="utf-8"))
    if not isinstance(data, dict):
        raise SystemExit(f"{SIDECAR.name} must be a JSON object keyed by hanzi.")
    return data


def validate_entry(hanzi: str, entry: object) -> dict[str, str]:
    if not isinstance(entry, dict):
        raise SystemExit(f"Invalid entry for {hanzi!r}: expected object.")
    missing = [locale for locale in LOCALES if not str(entry.get(locale, "")).strip()]
    if missing:
        raise SystemExit(f"Entry for {hanzi!r} missing locales: {missing}")
    return {locale: str(entry[locale]).strip() for locale in LOCALES}


def fill_node(node: object, sidecar: dict[str, dict[str, str]], stats: dict[str, int]) -> None:
    if isinstance(node, dict):
        if "hanzi" in node and "translation" in node and not has_translation(node.get("translation")):
            hanzi = node["hanzi"]
            if hanzi in sidecar:
                node["translation"] = validate_entry(hanzi, sidecar[hanzi])
                stats["filled"] += 1
            else:
                stats["missing"] += 1
                print(f"  WARNING: no sidecar entry for {hanzi!r}", file=sys.stderr)
        for value in node.values():
            fill_node(value, sidecar, stats)
    elif isinstance(node, list):
        for item in node:
            fill_node(item, sidecar, stats)


def write_json(path: Path, data: object) -> None:
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def main() -> None:
    sidecar = load_sidecar()
    total_filled = 0
    total_missing = 0

    for path in sorted(PATH_COURSE.glob("lesson_*.json")):
        data = json.loads(path.read_text(encoding="utf-8"))
        stats = {"filled": 0, "missing": 0}
        fill_node(data, sidecar, stats)
        if stats["filled"] or stats["missing"]:
            write_json(path, data)
            print(f"{path.name}: filled {stats['filled']}, still missing {stats['missing']}")
            total_filled += stats["filled"]
            total_missing += stats["missing"]

    print(f"\nDone: filled {total_filled}, still missing {total_missing}.")
    if total_missing:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
