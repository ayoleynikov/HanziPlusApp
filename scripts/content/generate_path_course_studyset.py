#!/usr/bin/env python3
"""Generate path_course.json — dedicated Smart Review vocabulary for Path Course.

Extracts unique lesson vocabulary from Path course JSON files.
Run: python3 scripts/content/generate_path_course_studyset.py
"""

from __future__ import annotations

import json
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
PATH_COURSE = SCRIPT_DIR.parents[1] / "HanziPlus" / "Resources" / "PathCourse"
OUTPUT = SCRIPT_DIR.parents[1] / "HanziPlus" / "Resources" / "Data" / "path_course.json"


def iter_vocab_items(data: dict):
    for chapter in data.get("chapters") or []:
        for section in chapter.get("sections") or []:
            if section.get("kind") != "vocabulary":
                continue
            for item in (section.get("vocabulary") or {}).get("items") or []:
                yield item

    for section in data.get("sections") or []:
        if section.get("kind") != "vocabulary":
            continue
        for item in (section.get("vocabulary") or {}).get("items") or []:
            yield item


def to_word(item: dict) -> dict:
    translation = item.get("translation") or {}
    english = translation.get("en") or item.get("hanzi", "")
    return {
        "hanzi": item["hanzi"],
        "pinyin": item.get("pinyin", ""),
        "english": english,
        "translations": {
            "en": translation.get("en", english),
            "ru": translation.get("ru", english),
            "es": translation.get("es", english),
            "pt-BR": translation.get("pt-BR", english),
        },
        "examples": [],
    }


def main() -> None:
    words: dict[str, dict] = {}

    for path in sorted(PATH_COURSE.glob("lesson_*.json")):
        data = json.loads(path.read_text(encoding="utf-8"))
        for item in iter_vocab_items(data):
            if item.get("countsInLessonTotal") is False:
                continue
            hanzi = (item.get("hanzi") or "").strip()
            if not hanzi:
                continue
            if hanzi not in words:
                words[hanzi] = to_word(item)

    ordered = sorted(words.values(), key=lambda word: word["hanzi"])
    OUTPUT.write_text(json.dumps(ordered, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"Wrote {len(ordered)} words to {OUTPUT.name}")


if __name__ == "__main__":
    main()
