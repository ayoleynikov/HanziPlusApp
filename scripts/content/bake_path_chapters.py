#!/usr/bin/env python3
"""Bake explicit chapters into Path course lessons from legacy flat sections.

Mirrors PathLessonChapterSplitter logic. Keeps original `sections` for compatibility.
Run: python3 scripts/content/bake_path_chapters.py
"""

from __future__ import annotations

import json
from copy import deepcopy
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
PATH_COURSE = SCRIPT_DIR.parents[1] / "HanziPlus" / "Resources" / "PathCourse"

MAX_NEW_WORDS = 12
TARGET_NEW_WORDS = 8

TITLE_LABELS = {
    "main": ("Основная часть", "Main part", "Parte principal", "Parte principal"),
    "dialogue": ("Диалог", "Dialogue", "Diálogo", "Diálogo"),
    "vocabulary": ("Новые слова", "New words", "Palabras nuevas", "Palavras novas"),
    "practice": ("Практика", "Practice", "Práctica", "Prática"),
    "wrap_up": ("Итог", "Wrap-up", "Resumen", "Encerramento"),
    "continue": ("Продолжение", "Continue", "Continuación", "Continuação"),
}


def localized(ru: str, en: str, es: str, pt: str) -> dict[str, str]:
    return {"ru": ru, "en": en, "es": es, "pt-BR": pt}


def chapter_title(lesson_number: int, chapter_number: int, key: str) -> dict[str, str]:
    label = TITLE_LABELS.get(key)
    if label:
        return localized(*label)
    return localized(
        f"Глава {chapter_number}",
        f"Chapter {chapter_number}",
        f"Capítulo {chapter_number}",
        f"Capítulo {chapter_number}",
    )


def count_vocab(section: dict) -> int:
    if section.get("kind") != "vocabulary":
        return 0
    vocab = section.get("vocabulary") or {}
    items = vocab.get("items") or []
    return sum(1 for item in items if item.get("countsInLessonTotal", True))


def split_vocab_group(section: dict, max_items: int) -> tuple[dict | None, dict | None]:
    vocab = deepcopy(section["vocabulary"])
    items = vocab.get("items") or []
    counted = [i for i, item in enumerate(items) if item.get("countsInLessonTotal", True)]
    if len(counted) <= max_items:
        return section, None

    split_at = max_items
    first_items = items[:split_at]
    rest_items = items[split_at:]
    first = deepcopy(section)
    first["vocabulary"] = {**vocab, "items": first_items}
    rest = deepcopy(section)
    rest_id = vocab.get("id", "vocab") + "_part2"
    rest["vocabulary"] = {**vocab, "id": rest_id, "items": rest_items}
    return first, rest


def estimated_minutes(sections: list[dict], activity_count: int = 0) -> int:
    minutes = 4
    for section in sections:
        kind = section.get("kind")
        if kind == "dialogue":
            lines = (section.get("dialogue") or {}).get("lines") or []
            minutes += max(2, len(lines) // 3)
        elif kind == "vocabulary":
            items = (section.get("vocabulary") or {}).get("items") or []
            minutes += max(2, len(items))
        elif kind == "examples":
            items = section.get("items") or []
            minutes += min(4, max(1, len(items) // 4))
        elif kind in ("quizChineseToTranslation", "quizTranslationToChinese"):
            minutes += 2
    minutes += activity_count
    return min(12, max(7, minutes))


def finalize_sections(sections: list[dict]) -> list[dict]:
    result = list(sections)
    if not any(s.get("kind") == "completion" for s in result):
        result.append({"kind": "completion"})
    return result


def split_sections(lesson_id: str, lesson_number: int, sections: list[dict]) -> list[dict]:
    if not sections:
        return []

    chapters: list[dict] = []
    buffer: list[dict] = []
    vocab_count = 0
    chapter_number = 0

    def flush(title_key: str) -> None:
        nonlocal buffer, vocab_count, chapter_number
        if not buffer:
            return
        chapter_number += 1
        finalized = finalize_sections(buffer)
        chapters.append(
            {
                "id": f"{lesson_id}_ch{chapter_number:02d}",
                "number": chapter_number,
                "title": chapter_title(lesson_number, chapter_number, title_key),
                "goal": None,
                "estimatedMinutes": estimated_minutes(finalized),
                "toneGuide": None,
                "grammarCard": None,
                "sections": finalized,
                "activities": [],
            }
        )
        buffer = []
        vocab_count = 0

    for section in sections:
        kind = section.get("kind")

        if kind == "completion":
            flush("wrap_up")
            if chapters:
                last = chapters.pop()
                last["sections"] = finalize_sections(last["sections"])
                chapters.append(last)
            continue

        if kind == "vocabulary":
            while count_vocab(section) > MAX_NEW_WORDS:
                first, rest = split_vocab_group(section, MAX_NEW_WORDS)
                assert first is not None
                if vocab_count > 0:
                    flush("vocabulary")
                buffer.append(first)
                vocab_count += count_vocab(first)
                if vocab_count >= TARGET_NEW_WORDS:
                    flush("practice")
                section = rest
                assert section is not None

            item_count = count_vocab(section)
            if vocab_count > 0 and vocab_count + item_count > MAX_NEW_WORDS:
                flush("vocabulary")
            buffer.append(section)
            vocab_count += item_count
            if vocab_count >= TARGET_NEW_WORDS:
                flush("practice")
            continue

        if kind in ("dialogue", "dialogueRepeat", "transition"):
            if vocab_count >= TARGET_NEW_WORDS:
                flush("dialogue")
            buffer.append(section)
            continue

        buffer.append(section)

    if buffer:
        flush("continue")

    return chapters


def bake_lesson(path: Path) -> bool:
    data = json.loads(path.read_text(encoding="utf-8"))
    chapters = data.get("chapters")
    if isinstance(chapters, list) and len(chapters) > 0:
        print(f"SKIP {path.name}: already has {len(chapters)} chapters")
        return False

    sections = data.get("sections")
    if not isinstance(sections, list) or not sections:
        print(f"WARN {path.name}: no sections to split")
        return False

    lesson_id = data.get("id", path.stem)
    lesson_number = int(data.get("number", 0))
    baked = split_sections(lesson_id, lesson_number, sections)
    if not baked:
        print(f"WARN {path.name}: split produced no chapters")
        return False

    data["chapters"] = baked
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"OK   {path.name}: {len(baked)} chapters")
    return True


def main() -> None:
    baked_count = 0
    for index in range(1, 16):
        path = PATH_COURSE / f"lesson_{index:02d}.json"
        if not path.exists():
            print(f"MISSING {path.name}")
            continue
        if bake_lesson(path):
            baked_count += 1
    print(f"\nBaked chapters for {baked_count} lesson(s).")


if __name__ == "__main__":
    main()
