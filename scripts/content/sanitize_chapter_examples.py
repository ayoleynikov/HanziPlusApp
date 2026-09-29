#!/usr/bin/env python3
"""Remove group: additional from in-chapter examples (reference-only belongs at lesson level).

Run: python3 scripts/content/sanitize_chapter_examples.py
"""

from __future__ import annotations

import json
from copy import deepcopy
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
PATH_COURSE = SCRIPT_DIR.parents[1] / "HanziPlus" / "Resources" / "PathCourse"


def sanitize_lesson(path: Path) -> bool:
    data = json.loads(path.read_text(encoding="utf-8"))
    changed = False

    for chapter in data.get("chapters") or []:
        for section in chapter.get("sections") or []:
            if section.get("kind") != "examples":
                continue
            cleaned_items = []
            for item in section.get("items") or []:
                cleaned = deepcopy(item)
                if cleaned.pop("group", None) == "additional":
                    changed = True
                cleaned_items.append(cleaned)
            if cleaned_items != section.get("items"):
                section["items"] = cleaned_items
                changed = True

    if changed:
        path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return changed


def main() -> None:
    changed = 0
    for index in range(1, 16):
        path = PATH_COURSE / f"lesson_{index:02d}.json"
        if not path.exists():
            continue
        if sanitize_lesson(path):
            print(f"OK   {path.name}")
            changed += 1
        else:
            print(f"SKIP {path.name}")
    print(f"\nSanitized {changed} lesson(s).")


if __name__ == "__main__":
    main()
