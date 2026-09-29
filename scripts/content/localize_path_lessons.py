#!/usr/bin/env python3
"""Convert plain Russian strings in Path course JSON to locale maps.

Reads lesson_*.json and course.json under Resources/PathCourse.
For ``translation``, ``translationTitle``, and vocabulary group ``title`` fields,
replaces plain strings with::

    {"ru": "<original>", "en": "...", "es": "...", "pt-BR": "..."}

Skips null values and strings starting with "TODO". Idempotent: already-localized
objects are left unchanged.

Translations load from ``path_ru_translations.json`` in this folder when present,
otherwise from the embedded ``EMBEDDED_TRANSLATIONS`` dict below.
"""

from __future__ import annotations

import json
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parents[1] / "HanziPlus"  # app source folder
PATH_COURSE = ROOT / "Resources" / "PathCourse"
TRANSLATIONS_FILE = SCRIPT_DIR / "path_ru_translations.json"

LOCALES = ("ru", "en", "es", "pt-BR")
TARGET_FIELDS = frozenset({"translation", "translationTitle"})


def _entry(en: str, es: str, pt_br: str) -> dict[str, str]:
    return {"en": en, "es": es, "pt-BR": pt_br}


# Fallback when path_ru_translations.json is missing (subset only).
EMBEDDED_TRANSLATIONS: dict[str, dict[str, str]] = {}


def load_translations() -> dict[str, dict[str, str]]:
    if TRANSLATIONS_FILE.exists():
        data = json.loads(TRANSLATIONS_FILE.read_text(encoding="utf-8"))
        if not isinstance(data, dict):
            raise SystemExit(f"{TRANSLATIONS_FILE.name} must be a JSON object.")
        return data
    return EMBEDDED_TRANSLATIONS


def is_plain_string(value: object) -> bool:
    if not isinstance(value, str):
        return False
    stripped = value.strip()
    if not stripped:
        return False
    return not stripped.upper().startswith("TODO")


def is_localized_object(value: object) -> bool:
    if not isinstance(value, dict):
        return False
    if "ru" not in value:
        return False
    return all(isinstance(v, str) for v in value.values())


def localize_string(ru: str, translations: dict[str, dict[str, str]]) -> dict[str, str]:
    entry = translations.get(ru)
    if entry is None:
        print(f"  WARNING: missing translation for {ru!r}", file=sys.stderr)
        return {"ru": ru, "en": ru, "es": ru, "pt-BR": ru}
    return {
        "ru": ru,
        "en": entry["en"],
        "es": entry["es"],
        "pt-BR": entry["pt-BR"],
    }


def maybe_localize(value: object, translations: dict[str, dict[str, str]]) -> tuple[object, bool]:
    if is_localized_object(value):
        return value, False
    if not is_plain_string(value):
        return value, False
    assert isinstance(value, str)
    return localize_string(value, translations), True


def process_node(node: object, translations: dict[str, dict[str, str]]) -> int:
    changed = 0

    if isinstance(node, dict):
        for key in TARGET_FIELDS:
            if key in node:
                new_value, did_change = maybe_localize(node[key], translations)
                if did_change:
                    node[key] = new_value
                    changed += 1

        if node.get("kind") == "vocabulary":
            vocabulary = node.get("vocabulary")
            if isinstance(vocabulary, dict) and "title" in vocabulary:
                new_value, did_change = maybe_localize(vocabulary["title"], translations)
                if did_change:
                    vocabulary["title"] = new_value
                    changed += 1

        for value in node.values():
            changed += process_node(value, translations)

    elif isinstance(node, list):
        for item in node:
            changed += process_node(item, translations)

    return changed


def write_json(path: Path, data: object) -> None:
    path.write_text(
        json.dumps(data, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )


def main() -> None:
    translations = load_translations()
    if not translations:
        raise SystemExit(
            "No translations found. Create path_ru_translations.json or add EMBEDDED_TRANSLATIONS."
        )

    files_modified = 0
    strings_localized = 0

    lesson_files = sorted(PATH_COURSE.glob("lesson_*.json"))
    course_file = PATH_COURSE / "course.json"
    targets = lesson_files + ([course_file] if course_file.exists() else [])

    for path in targets:
        data = json.loads(path.read_text(encoding="utf-8"))
        count = process_node(data, translations)
        if count:
            write_json(path, data)
            files_modified += 1
            strings_localized += count
            print(f"{path.name}: {count} field(s) localized")

    print(
        f"\nDone: {strings_localized} string(s) localized across {files_modified} file(s)."
    )
    print(f"Translation entries loaded: {len(translations)}")


if __name__ == "__main__":
    main()
