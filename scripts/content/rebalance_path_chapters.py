#!/usr/bin/env python3
"""Rebalance baked Path course chapters.

- Remove quiz sections from chapters without vocabulary
- Split example sections larger than MAX_EXAMPLES_PER_CHAPTER into follow-up chapters
- Re-number chapters sequentially

Run: python3 scripts/content/rebalance_path_chapters.py
"""

from __future__ import annotations

import json
from copy import deepcopy
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
PATH_COURSE = SCRIPT_DIR.parents[1] / "HanziPlus" / "Resources" / "PathCourse"

MAX_EXAMPLES_PER_CHAPTER = 8
QUIZ_KINDS = {"quizChineseToTranslation", "quizTranslationToChinese"}


def count_vocab(sections: list[dict]) -> int:
    total = 0
    for section in sections:
        if section.get("kind") != "vocabulary":
            continue
        vocab = section.get("vocabulary") or {}
        for item in vocab.get("items") or []:
            if item.get("countsInLessonTotal", True):
                total += 1
    return total


def strip_orphan_quizzes(sections: list[dict]) -> list[dict]:
    if count_vocab(sections) > 0:
        return sections
    return [section for section in sections if section.get("kind") not in QUIZ_KINDS]


def split_examples(sections: list[dict]) -> list[list[dict]]:
    """Return one or more section lists; may emit extra lists for example overflow."""
    result: list[list[dict]] = []
    current: list[dict] = []

    for section in sections:
        if section.get("kind") != "examples":
            current.append(section)
            continue

        items = section.get("items") or []
        if len(items) <= MAX_EXAMPLES_PER_CHAPTER:
            current.append(section)
            continue

        chunks = [
            items[index : index + MAX_EXAMPLES_PER_CHAPTER]
            for index in range(0, len(items), MAX_EXAMPLES_PER_CHAPTER)
        ]
        first = deepcopy(section)
        first["items"] = chunks[0]
        current.append(first)
        result.append(current)
        current = []

        for chunk in chunks[1:]:
            overflow = [{"kind": "examples", "items": chunk}, {"kind": "completion"}]
            result.append(overflow)

    if current:
        result.append(current)

    return result or [sections]


def rebalance_chapter_sections(sections: list[dict]) -> list[list[dict]]:
    cleaned = strip_orphan_quizzes(sections)
    return split_examples(cleaned)


def rebalance_lesson(data: dict) -> bool:
    lesson_id = data.get("id", "lesson")
    lesson_number = int(data.get("number", 0))
    chapters = data.get("chapters")
    if not isinstance(chapters, list) or not chapters:
        return False

    expanded: list[dict] = []
    for chapter in chapters:
        sections = chapter.get("sections") or []
        for section_group in rebalance_chapter_sections(sections):
            expanded.append(
                {
                    "title": chapter.get("title"),
                    "goal": chapter.get("goal"),
                    "estimatedMinutes": chapter.get("estimatedMinutes"),
                    "toneGuide": chapter.get("toneGuide"),
                    "grammarCard": chapter.get("grammarCard"),
                    "sections": section_group,
                    "activities": chapter.get("activities") or [],
                }
            )

    rebuilt: list[dict] = []
    for index, chapter in enumerate(expanded, start=1):
        rebuilt.append(
            {
                "id": f"{lesson_id}_ch{index:02d}",
                "number": index,
                "title": chapter["title"],
                "goal": chapter["goal"],
                "estimatedMinutes": chapter["estimatedMinutes"],
                "toneGuide": chapter["toneGuide"],
                "grammarCard": chapter["grammarCard"],
                "sections": chapter["sections"],
                "activities": [],
            }
        )

    if rebuilt == chapters:
        return False

    data["chapters"] = rebuilt
    return True


def main() -> None:
    changed = 0
    for index in range(1, 16):
        path = PATH_COURSE / f"lesson_{index:02d}.json"
        if not path.exists():
            continue
        data = json.loads(path.read_text(encoding="utf-8"))
        if rebalance_lesson(data):
            path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
            print(f"OK   {path.name}: {len(data['chapters'])} chapters")
            changed += 1
        else:
            print(f"SKIP {path.name}")
    print(f"\nRebalanced {changed} lesson(s).")


if __name__ == "__main__":
    main()
