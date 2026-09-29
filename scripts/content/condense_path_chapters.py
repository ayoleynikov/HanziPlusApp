#!/usr/bin/env python3
"""Condense Path course chapters to 2–4 substantive chapters per lesson.

- Re-bakes chapters from top-level `sections` (skips lesson 01 with hand-crafted chapters)
- Keeps at most MAX_CORE_EXAMPLES in-flow examples per lesson; overflow → group "additional"
- Places quizzes in the last chapter that has vocabulary
- Removes empty completion-only chapters
- Caps at MAX_CHAPTERS per lesson

Run: python3 scripts/content/condense_path_chapters.py
"""

from __future__ import annotations

import json
from copy import deepcopy
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
PATH_COURSE = SCRIPT_DIR.parents[1] / "HanziPlus" / "Resources" / "PathCourse"

MAX_NEW_WORDS = 12
TARGET_NEW_WORDS = 8
MAX_CHAPTERS = 4
MAX_CORE_EXAMPLES = 8
QUIZ_KINDS = {"quizChineseToTranslation", "quizTranslationToChinese"}
SKIP_LESSON_NUMBERS = {1}

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
    counted = [item for item in items if item.get("countsInLessonTotal", True)]
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


def estimated_minutes(sections: list[dict]) -> int:
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
        elif kind in QUIZ_KINDS:
            minutes += 2
    return min(12, max(7, minutes))


def finalize_sections(sections: list[dict]) -> list[dict]:
    result = [section for section in sections if section.get("kind") != "completion"]
    if not any(section.get("kind") == "completion" for section in result):
        result.append({"kind": "completion"})
    return result


def is_substantive(sections: list[dict]) -> bool:
    substantive_kinds = {
        "dialogue",
        "vocabulary",
        "vocabularySummary",
        "dialogueRepeat",
        "examples",
        "toneGuide",
        "grammar",
        "quizChineseToTranslation",
        "quizTranslationToChinese",
    }
    return any(section.get("kind") in substantive_kinds for section in sections)


def collect_examples_from_chapters(chapters: list[dict]) -> list[dict]:
    collected: list[dict] = []
    for chapter in chapters:
        for section in chapter.get("sections") or []:
            if section.get("kind") == "examples":
                collected.extend(section.get("items") or [])
    return collected


def trim_lesson_examples(sections: list[dict], chapters: list[dict] | None = None) -> tuple[list[dict], list[dict]]:
    """Return (flow_sections, additional_examples)."""
    flow: list[dict] = []
    collected: list[dict] = []
    quiz_sections: list[dict] = []

    for section in sections:
        kind = section.get("kind")
        if kind in QUIZ_KINDS:
            quiz_sections.append(section)
            continue
        if kind == "examples":
            if section.get("id") == "reference_additional":
                continue
            collected.extend(section.get("items") or [])
            continue
        flow.append(section)

    if chapters and not collected:
        collected = collect_examples_from_chapters(chapters)

    primary = [item for item in collected if item.get("group") != "additional"]
    if not primary:
        primary = collected
    already_additional = [item for item in collected if item.get("group") == "additional"]
    core: list[dict] = []
    for item in primary[:MAX_CORE_EXAMPLES]:
        cleaned = deepcopy(item)
        cleaned.pop("group", None)
        core.append(cleaned)
    overflow = primary[MAX_CORE_EXAMPLES:]

    additional: list[dict] = already_additional
    for item in overflow:
        marked = deepcopy(item)
        marked["group"] = "additional"
        additional.append(marked)

    if core:
        flow.append({"kind": "examples", "items": core})

    return flow, additional


def split_sections(lesson_id: str, lesson_number: int, sections: list[dict]) -> list[dict]:
    if not sections:
        return []

    chapters: list[dict] = []
    buffer: list[dict] = []
    pending_examples: list[dict] = []
    vocab_count = 0
    chapter_number = 0

    def flush(title_key: str, attach_examples: bool = False) -> None:
        nonlocal buffer, vocab_count, chapter_number, pending_examples
        if not buffer and not (attach_examples and pending_examples):
            return

        sections_to_write = list(buffer)
        if attach_examples and pending_examples:
            sections_to_write.append({"kind": "examples", "items": pending_examples})
            pending_examples = []

        if not is_substantive(sections_to_write):
            buffer = []
            vocab_count = 0
            return

        chapter_number += 1
        finalized = finalize_sections(sections_to_write)
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
            flush("wrap_up", attach_examples=True)
            continue

        if kind == "examples":
            pending_examples.extend(section.get("items") or [])
            continue

        if kind == "vocabulary":
            working = section
            while count_vocab(working) > MAX_NEW_WORDS:
                first, rest = split_vocab_group(working, MAX_NEW_WORDS)
                assert first is not None
                if vocab_count > 0:
                    flush("vocabulary")
                buffer.append(first)
                vocab_count += count_vocab(first)
                if vocab_count >= TARGET_NEW_WORDS:
                    flush("practice")
                working = rest
                assert working is not None

            item_count = count_vocab(working)
            if vocab_count > 0 and vocab_count + item_count > MAX_NEW_WORDS:
                flush("vocabulary")
            buffer.append(working)
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

    if buffer or pending_examples:
        flush("continue", attach_examples=True)

    return chapters


def chapter_vocab_count(chapter: dict) -> int:
    return sum(count_vocab(section) for section in chapter.get("sections") or [])


def ensure_quizzes(chapters: list[dict]) -> None:
    target = None
    for chapter in reversed(chapters):
        if chapter_vocab_count(chapter) > 0:
            target = chapter
            break
    if target is None:
        return

    sections = target["sections"]
    kinds = {section.get("kind") for section in sections}
    if not kinds.intersection(QUIZ_KINDS):
        insert_at = len(sections)
        for index, section in enumerate(sections):
            if section.get("kind") == "completion":
                insert_at = index
                break
        sections[insert_at:insert_at] = [
            {"kind": "quizChineseToTranslation"},
            {"kind": "quizTranslationToChinese"},
        ]


def remove_empty_chapters(chapters: list[dict]) -> list[dict]:
    return [chapter for chapter in chapters if is_substantive(chapter.get("sections") or [])]


def merge_to_max_chapters(chapters: list[dict], lesson_id: str) -> list[dict]:
    while len(chapters) > MAX_CHAPTERS:
        tail = chapters.pop()
        prev = chapters[-1]
        prev_sections = prev["sections"]
        tail_sections = [section for section in tail.get("sections") or [] if section.get("kind") != "completion"]
        completion = next((section for section in prev_sections if section.get("kind") == "completion"), None)
        prev["sections"] = [section for section in prev_sections if section.get("kind") != "completion"]
        prev["sections"].extend(tail_sections)
        if completion:
            prev["sections"].append(completion)
        prev["estimatedMinutes"] = estimated_minutes(prev["sections"])

    for index, chapter in enumerate(chapters, start=1):
        chapter["number"] = index
        chapter["id"] = f"{lesson_id}_ch{index:02d}"
    return chapters


def sanitize_chapter_examples(chapters: list[dict]) -> None:
    for chapter in chapters:
        for section in chapter.get("sections") or []:
            if section.get("kind") != "examples":
                continue
            cleaned: list[dict] = []
            for item in section.get("items") or []:
                copy = deepcopy(item)
                copy.pop("group", None)
                cleaned.append(copy)
            section["items"] = cleaned


def condense_lesson(path: Path) -> bool:
    data = json.loads(path.read_text(encoding="utf-8"))
    lesson_number = int(data.get("number", 0))
    if lesson_number in SKIP_LESSON_NUMBERS:
        print(f"SKIP {path.name}: hand-crafted chapters")
        return False

    sections = data.get("sections")
    if not isinstance(sections, list) or not sections:
        print(f"WARN {path.name}: no top-level sections")
        return False

    lesson_id = data.get("id", path.stem)
    flow_sections, additional_examples = trim_lesson_examples(sections, data.get("chapters"))
    baked = split_sections(lesson_id, lesson_number, flow_sections)
    baked = remove_empty_chapters(baked)
    ensure_quizzes(baked)
    baked = merge_to_max_chapters(baked, lesson_id)
    sanitize_chapter_examples(baked)

    if additional_examples:
        data["sections"] = [
            section
            for section in (data.get("sections") or [])
            if not (section.get("kind") == "examples" and section.get("id") == "reference_additional")
        ]
        data["sections"].append(
            {
                "kind": "examples",
                "id": "reference_additional",
                "items": additional_examples,
            }
        )

    data["chapters"] = baked
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"OK   {path.name}: {len(baked)} chapters")
    return True


def main() -> None:
    changed = 0
    total = 0
    for index in range(1, 16):
        path = PATH_COURSE / f"lesson_{index:02d}.json"
        if not path.exists():
            continue
        data = json.loads(path.read_text(encoding="utf-8"))
        total += len(data.get("chapters") or [])
        if condense_lesson(path):
            changed += 1

    new_total = sum(
        len(json.loads((PATH_COURSE / f"lesson_{index:02d}.json").read_text(encoding="utf-8")).get("chapters") or [])
        for index in range(1, 16)
        if (PATH_COURSE / f"lesson_{index:02d}.json").exists()
    )
    print(f"\nCondensed {changed} lesson(s). Chapters: {total} → {new_total}")


if __name__ == "__main__":
    main()
