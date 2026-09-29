#!/usr/bin/env python3
"""Offline validation for Hanzi+ Path course JSON (15 lessons).

Run from repo root:
  python3 scripts/content/validate_path_course.py
"""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path
from typing import Any

SCRIPT_DIR = Path(__file__).resolve().parent
PATH_COURSE = SCRIPT_DIR.parents[1] / "HanziPlus" / "Resources" / "PathCourse"

REQUIRED_LANGS = ("ru", "en", "es", "pt-BR")
MAX_NEW_WORDS_PER_CHAPTER = 12
MAX_EXAMPLES_PER_CHAPTER = 8
MIN_CHAPTERS_PER_LESSON = 2
MAX_CHAPTERS_PER_LESSON = 4
MAX_FLOW_EXAMPLES_PER_LESSON = 12
QUIZ_KINDS = {"quizChineseToTranslation", "quizTranslationToChinese"}
EXPECTED_LESSON_COUNT = 15
FORBIDDEN_START_RE = re.compile(r"^TODO[:,\s]", re.IGNORECASE)
FORBIDDEN_INLINE_RE = re.compile(r"\b(TBD|FIXME)\b", re.IGNORECASE)


def has_forbidden_marker(text: str) -> bool:
    stripped = text.strip()
    if not stripped:
        return False
    if FORBIDDEN_START_RE.match(stripped):
        return True
    return bool(FORBIDDEN_INLINE_RE.search(stripped))

SECTION_KINDS = {
    "dialogue",
    "vocabulary",
    "transition",
    "vocabularySummary",
    "dialogueRepeat",
    "toneGuide",
    "grammar",
    "sentenceBuilder",
    "fillBlank",
    "dialogueOrder",
    "quizChineseToTranslation",
    "quizTranslationToChinese",
    "examples",
    "mistakeReview",
    "chapterComplete",
    "completion",
}

ACTIVITY_KINDS = {"sentenceBuilder", "fillBlank", "dialogueOrder"}


class ValidationError(Exception):
    pass


def fail(path: str, message: str) -> None:
    raise ValidationError(f"{path}: {message}")


def load_json(path: Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        fail(str(path), f"invalid JSON: {exc}")


def walk(node: Any) -> list[Any]:
    items: list[Any] = []
    if isinstance(node, dict):
        items.append(node)
        for value in node.values():
            items.extend(walk(value))
    elif isinstance(node, list):
        for item in node:
            items.extend(walk(item))
    return items


def check_forbidden_markers(data: Any, context: str) -> None:
    for node in walk(data):
        if isinstance(node, str) and has_forbidden_marker(node):
            fail(context, f"forbidden marker in text: {node[:80]!r}")


def is_localized_map(value: Any) -> bool:
    return isinstance(value, dict) and all(isinstance(k, str) and isinstance(v, str) for k, v in value.items())


def validate_localized_text(value: Any, path: str, allow_null: bool = False) -> None:
    if value is None:
        if allow_null:
            return
        fail(path, "translation is null")
    if isinstance(value, str):
        stripped = value.strip()
        if not stripped:
            fail(path, "translation string is empty")
        if has_forbidden_marker(stripped):
            fail(path, f"forbidden marker in translation: {stripped[:80]!r}")
        return
    if not is_localized_map(value):
        fail(path, "translation must be a string or locale map")
    for lang in REQUIRED_LANGS:
        text = value.get(lang)
        if not isinstance(text, str) or not text.strip():
            fail(path, f"missing or empty translation for {lang}")
        if has_forbidden_marker(text):
            fail(path, f"forbidden marker in {lang} translation")


def collect_vocabulary_ids(sections: list[dict[str, Any]]) -> set[str]:
    ids: set[str] = set()
    for section in sections:
        if section.get("kind") != "vocabulary":
            continue
        vocab = section.get("vocabulary")
        if not isinstance(vocab, dict):
            continue
        for item in vocab.get("items", []):
            if isinstance(item, dict) and isinstance(item.get("id"), str):
                ids.add(item["id"])
    return ids


def count_new_words_in_sections(sections: list[dict[str, Any]]) -> int:
    total = 0
    for section in sections:
        if section.get("kind") != "vocabulary":
            continue
        vocab = section.get("vocabulary")
        if not isinstance(vocab, dict):
            continue
        for item in vocab.get("items", []):
            if not isinstance(item, dict):
                continue
            if item.get("countsInLessonTotal", True):
                total += 1
    return total


def validate_tone_guide(guide: dict[str, Any], path: str) -> None:
    validate_localized_text(guide.get("title"), f"{path}.title")
    validate_localized_text(guide.get("introduction"), f"{path}.introduction")
    tones = guide.get("tones")
    if not isinstance(tones, list) or not tones:
        fail(path, "toneGuide.tones must be a non-empty list")
    for index, tone in enumerate(tones):
        tone_path = f"{path}.tones[{index}]"
        if not isinstance(tone, dict):
            fail(tone_path, "tone entry must be an object")
        if not isinstance(tone.get("pinyin"), str) or not tone["pinyin"].strip():
            fail(tone_path, "missing pinyin")
        tone_number = tone.get("toneNumber")
        if not isinstance(tone_number, int) or tone_number < 1 or tone_number > 4:
            fail(tone_path, "toneNumber must be 1–4")
        validate_localized_text(tone.get("meaning"), f"{tone_path}.meaning")
        validate_localized_text(tone.get("contourDescription"), f"{tone_path}.contourDescription")
    neutral = guide.get("neutralToneNote")
    if neutral is not None:
        validate_localized_text(neutral, f"{path}.neutralToneNote")
    mark = guide.get("toneMarkNote")
    if mark is not None:
        validate_localized_text(mark, f"{path}.toneMarkNote")


def validate_grammar_card(card: dict[str, Any], path: str) -> None:
    validate_localized_text(card.get("title"), f"{path}.title")
    validate_localized_text(card.get("explanation"), f"{path}.explanation")
    formula = card.get("formula")
    if formula is not None:
        validate_localized_text(formula, f"{path}.formula")
    positive = card.get("positiveExample")
    if not isinstance(positive, dict):
        fail(path, "grammarCard.positiveExample is required")
    validate_localized_text(positive.get("translation"), f"{path}.positiveExample.translation")
    for key in ("questionExample", "negativeExample"):
        example = card.get(key)
        if example is not None:
            if not isinstance(example, dict):
                fail(path, f"grammarCard.{key} must be an object")
            validate_localized_text(example.get("translation"), f"{path}.{key}.translation")
    practice = card.get("practicePrompt")
    if practice is not None:
        validate_localized_text(practice, f"{path}.practicePrompt")


def validate_activity(activity: dict[str, Any], path: str, vocab_ids: set[str]) -> None:
    kind = activity.get("kind")
    if kind not in ACTIVITY_KINDS:
        fail(path, f"unknown activity kind: {kind!r}")
    activity_id = activity.get("id")
    if not isinstance(activity_id, str) or not activity_id.strip():
        fail(path, "activity id is required")

    validate_localized_text(activity.get("prompt"), f"{path}.prompt")

    if kind == "sentenceBuilder":
        tokens = activity.get("tokens")
        correct_order = activity.get("correctOrder")
        if not isinstance(tokens, list) or not tokens:
            fail(path, "sentenceBuilder.tokens must be a non-empty list")
        if not isinstance(correct_order, list) or not correct_order:
            fail(path, "sentenceBuilder.correctOrder must be a non-empty list")
        if sorted(tokens) != sorted(correct_order):
            fail(path, "sentenceBuilder tokens and correctOrder must contain the same elements")
        if not isinstance(activity.get("resultHanzi"), str) or not activity["resultHanzi"].strip():
            fail(path, "sentenceBuilder.resultHanzi is required")
        validate_localized_text(activity.get("resultTranslation"), f"{path}.resultTranslation")
        explanation = activity.get("explanation")
        if explanation is not None:
            validate_localized_text(explanation, f"{path}.explanation")

    elif kind == "fillBlank":
        template = activity.get("template")
        blank = activity.get("blankToken")
        options = activity.get("options")
        correct = activity.get("correctOption")
        if not isinstance(template, str) or blank not in template:
            fail(path, "fillBlank.template must include blankToken")
        if not isinstance(options, list) or len(options) < 2:
            fail(path, "fillBlank.options must list at least two choices")
        if not isinstance(correct, str) or correct not in options:
            fail(path, "fillBlank.correctOption must be one of options")
        if not isinstance(activity.get("resultHanzi"), str) or not activity["resultHanzi"].strip():
            fail(path, "fillBlank.resultHanzi is required")
        validate_localized_text(activity.get("resultTranslation"), f"{path}.resultTranslation")
        related = activity.get("relatedVocabularyID")
        if related is not None and related not in vocab_ids:
            fail(path, f"fillBlank.relatedVocabularyID {related!r} not found in chapter vocabulary")
        explanation = activity.get("explanation")
        if explanation is not None:
            validate_localized_text(explanation, f"{path}.explanation")

    elif kind == "dialogueOrder":
        lines = activity.get("lines")
        correct_order = activity.get("correctOrder")
        if not isinstance(lines, list) or len(lines) < 2:
            fail(path, "dialogueOrder.lines must contain at least two lines")
        line_ids: list[str] = []
        for index, line in enumerate(lines):
            line_path = f"{path}.lines[{index}]"
            if not isinstance(line, dict):
                fail(line_path, "line must be an object")
            line_id = line.get("id")
            if not isinstance(line_id, str) or not line_id.strip():
                fail(line_path, "line id is required")
            line_ids.append(line_id)
            if not isinstance(line.get("hanzi"), str) or not line["hanzi"].strip():
                fail(line_path, "hanzi is required")
            translation = line.get("translation")
            if translation is not None:
                validate_localized_text(translation, f"{line_path}.translation", allow_null=True)
        if not isinstance(correct_order, list) or not correct_order:
            fail(path, "dialogueOrder.correctOrder must be a non-empty list")
        if set(correct_order) != set(line_ids):
            fail(path, "dialogueOrder.correctOrder must list every line id exactly once")
        if len(correct_order) != len(line_ids):
            fail(path, "dialogueOrder.correctOrder has duplicate ids")


def validate_section(section: dict[str, Any], path: str) -> None:
    kind = section.get("kind")
    if kind not in SECTION_KINDS:
        fail(path, f"unknown section kind: {kind!r}")

    if kind == "dialogue":
        dialogue = section.get("dialogue")
        if not isinstance(dialogue, dict):
            fail(path, "dialogue section missing dialogue object")
        lines = dialogue.get("lines")
        if not isinstance(lines, list) or not lines:
            fail(path, "dialogue.lines must be a non-empty list")
        for index, line in enumerate(lines):
            line_path = f"{path}.lines[{index}]"
            if not isinstance(line, dict):
                fail(line_path, "line must be an object")
            validate_localized_text(line.get("translation"), f"{line_path}.translation", allow_null=True)

    elif kind == "vocabulary":
        vocab = section.get("vocabulary")
        if not isinstance(vocab, dict):
            fail(path, "vocabulary section missing vocabulary object")
        validate_localized_text(vocab.get("title"), f"{path}.vocabulary.title")
        items = vocab.get("items")
        if not isinstance(items, list) or not items:
            fail(path, "vocabulary.items must be a non-empty list")
        seen_ids: set[str] = set()
        for index, item in enumerate(items):
            item_path = f"{path}.vocabulary.items[{index}]"
            if not isinstance(item, dict):
                fail(item_path, "vocabulary item must be an object")
            item_id = item.get("id")
            if not isinstance(item_id, str) or not item_id.strip():
                fail(item_path, "vocabulary item id is required")
            if item_id in seen_ids:
                fail(item_path, f"duplicate vocabulary id {item_id!r}")
            seen_ids.add(item_id)
            validate_localized_text(item.get("translation"), f"{item_path}.translation")

    elif kind == "dialogueRepeat":
        dialogue = section.get("dialogue")
        if not isinstance(dialogue, dict):
            fail(path, "dialogueRepeat missing dialogue object")
        lines = dialogue.get("lines")
        if not isinstance(lines, list) or not lines:
            fail(path, "dialogueRepeat.lines must be a non-empty list")
        for index, line in enumerate(lines):
            validate_localized_text(
                line.get("translation"),
                f"{path}.lines[{index}].translation",
                allow_null=True,
            )

    elif kind == "examples":
        items = section.get("items")
        if not isinstance(items, list) or not items:
            fail(path, "examples.items must be a non-empty list")
        for index, item in enumerate(items):
            item_path = f"{path}.items[{index}]"
            if not isinstance(item, dict):
                fail(item_path, "example must be an object")
            example_id = item.get("id")
            if not isinstance(example_id, str) or not example_id.strip():
                fail(item_path, "example id is required")
            validate_localized_text(item.get("translation"), f"{item_path}.translation", allow_null=True)

    elif kind == "vocabularySummary":
        groups = section.get("groups")
        if not isinstance(groups, list) or not groups:
            fail(path, "vocabularySummary.groups must be a non-empty list")
        for index, group in enumerate(groups):
            group_path = f"{path}.groups[{index}]"
            if not isinstance(group, dict):
                fail(group_path, "summary group must be an object")
            validate_localized_text(group.get("title"), f"{group_path}.title")


def validate_chapter(chapter: dict[str, Any], lesson_id: str, path_prefix: str) -> None:
    chapter_id = chapter.get("id")
    if not isinstance(chapter_id, str) or not chapter_id.strip():
        fail(path_prefix, "chapter id is required")
    number = chapter.get("number")
    if not isinstance(number, int) or number < 1:
        fail(path_prefix, "chapter.number must be a positive integer")
    validate_localized_text(chapter.get("title"), f"{path_prefix}.title")
    goal = chapter.get("goal")
    if goal is not None:
        validate_localized_text(goal, f"{path_prefix}.goal")
    minutes = chapter.get("estimatedMinutes")
    if not isinstance(minutes, int) or minutes < 1:
        fail(path_prefix, "estimatedMinutes must be a positive integer")

    tone_guide = chapter.get("toneGuide")
    if tone_guide is not None:
        if not isinstance(tone_guide, dict):
            fail(path_prefix, "toneGuide must be an object")
        validate_tone_guide(tone_guide, f"{path_prefix}.toneGuide")

    grammar = chapter.get("grammarCard")
    if grammar is not None:
        if not isinstance(grammar, dict):
            fail(path_prefix, "grammarCard must be an object")
        validate_grammar_card(grammar, f"{path_prefix}.grammarCard")

    sections = chapter.get("sections")
    if not isinstance(sections, list):
        fail(path_prefix, "sections must be a list")

    section_ids: set[str] = set()
    for index, section in enumerate(sections):
        section_path = f"{path_prefix}.sections[{index}]"
        if not isinstance(section, dict):
            fail(section_path, "section must be an object")
        validate_section(section, section_path)
        kind = section.get("kind")
        if kind == "dialogue":
            dialogue = section.get("dialogue", {})
            if isinstance(dialogue, dict) and isinstance(dialogue.get("id"), str):
                dialogue_id = dialogue["id"]
                if dialogue_id in section_ids:
                    fail(section_path, f"duplicate dialogue id {dialogue_id!r}")
                section_ids.add(dialogue_id)

    new_words = count_new_words_in_sections(sections)
    if new_words > MAX_NEW_WORDS_PER_CHAPTER:
        fail(path_prefix, f"chapter has {new_words} new words (max {MAX_NEW_WORDS_PER_CHAPTER})")

    example_count = sum(
        len(section.get("items") or [])
        for section in sections
        if section.get("kind") == "examples"
    )
    if example_count > MAX_EXAMPLES_PER_CHAPTER:
        fail(path_prefix, f"chapter has {example_count} examples (max {MAX_EXAMPLES_PER_CHAPTER})")

    for section in sections:
        if section.get("kind") != "examples":
            continue
        items = section.get("items") or []
        visible = [item for item in items if item.get("group") != "additional"]
        if items and not visible:
            fail(path_prefix, "chapter examples are all marked 'additional' and hidden at runtime")
        for item_index, item in enumerate(items):
            if item.get("group") == "additional":
                fail(
                    f"{path_prefix}.sections examples[{item_index}]",
                    "chapter examples must not use group 'additional' (keep those in lesson reference_additional only)",
                )

    has_quiz = any(section.get("kind") in {"quizChineseToTranslation", "quizTranslationToChinese"} for section in sections)
    if has_quiz and new_words == 0:
        fail(path_prefix, "chapter has quiz sections but no vocabulary items")

    vocab_ids = collect_vocabulary_ids(sections)

    activities = chapter.get("activities")
    if not isinstance(activities, list):
        fail(path_prefix, "activities must be a list")
    activity_ids: set[str] = set()
    for index, activity in enumerate(activities):
        activity_path = f"{path_prefix}.activities[{index}]"
        if not isinstance(activity, dict):
            fail(activity_path, "activity must be an object")
        activity_id = activity.get("id")
        if isinstance(activity_id, str) and activity_id in activity_ids:
            fail(activity_path, f"duplicate activity id {activity_id!r}")
        if isinstance(activity_id, str):
            activity_ids.add(activity_id)
        validate_activity(activity, activity_path, vocab_ids)


def lesson_has_completion(lesson: dict[str, Any]) -> bool:
    chapters = lesson.get("chapters")
    if isinstance(chapters, list) and chapters:
        return True
    sections = lesson.get("sections")
    if isinstance(sections, list):
        return any(section.get("kind") == "completion" for section in sections if isinstance(section, dict))
    return False


def validate_lesson(data: dict[str, Any], file_name: str) -> tuple[int, int]:
    lesson_path = file_name
    lesson_id = data.get("id")
    if not isinstance(lesson_id, str) or not lesson_id.strip():
        fail(lesson_path, "lesson id is required")
    number = data.get("number")
    if not isinstance(number, int) or number < 1:
        fail(lesson_path, "lesson.number must be a positive integer")

    translation_title = data.get("translationTitle")
    if translation_title is not None:
        validate_localized_text(translation_title, f"{lesson_path}.translationTitle", allow_null=True)

    chapters = data.get("chapters")
    sections = data.get("sections")
    chapter_count = 0

    if isinstance(chapters, list) and chapters:
        chapter_count = len(chapters)
        chapter_numbers: set[int] = set()
        chapter_ids: set[str] = set()
        for index, chapter in enumerate(chapters):
            chapter_path = f"{lesson_path}.chapters[{index}]"
            if not isinstance(chapter, dict):
                fail(chapter_path, "chapter must be an object")
            chapter_id = chapter.get("id")
            if isinstance(chapter_id, str):
                if chapter_id in chapter_ids:
                    fail(chapter_path, f"duplicate chapter id {chapter_id!r}")
                chapter_ids.add(chapter_id)
            chapter_number = chapter.get("number")
            if isinstance(chapter_number, int):
                if chapter_number in chapter_numbers:
                    fail(chapter_path, f"duplicate chapter number {chapter_number}")
                chapter_numbers.add(chapter_number)
            validate_chapter(chapter, lesson_id, chapter_path)

        if chapter_count < MIN_CHAPTERS_PER_LESSON or chapter_count > MAX_CHAPTERS_PER_LESSON:
            fail(
                lesson_path,
                f"lesson has {chapter_count} chapters (expected {MIN_CHAPTERS_PER_LESSON}-{MAX_CHAPTERS_PER_LESSON})",
            )

        flow_examples = 0
        has_vocab_quiz = False
        for index, chapter in enumerate(chapters):
            chapter_path = f"{lesson_path}.chapters[{index}]"
            sections_in_chapter = chapter.get("sections") or []
            substantive = chapter.get("toneGuide") is not None or any(
                section.get("kind") not in {"completion"} for section in sections_in_chapter
            )
            if not substantive:
                fail(chapter_path, "chapter is completion-only")

            vocab_count = count_new_words_in_sections(sections_in_chapter)
            has_quiz = any(section.get("kind") in QUIZ_KINDS for section in sections_in_chapter)
            if has_quiz and vocab_count > 0:
                has_vocab_quiz = True

            for section in sections_in_chapter:
                if section.get("kind") != "examples":
                    continue
                items = section.get("items") or []
                flow_examples += sum(1 for item in items if item.get("group") != "additional")

        if flow_examples > MAX_FLOW_EXAMPLES_PER_LESSON:
            fail(lesson_path, f"lesson has {flow_examples} in-flow examples (max {MAX_FLOW_EXAMPLES_PER_LESSON})")

        if number > 1 and not has_vocab_quiz:
            fail(lesson_path, "lesson must include quiz sections in a vocabulary chapter")
    elif isinstance(sections, list) and sections:
        new_words = count_new_words_in_sections(sections)
        if new_words > MAX_NEW_WORDS_PER_CHAPTER:
            print(
                f"WARN: {lesson_path} legacy sections have {new_words} counted words "
                f"(>{MAX_NEW_WORDS_PER_CHAPTER}); chapter split recommended"
            )
        for index, section in enumerate(sections):
            section_path = f"{lesson_path}.sections[{index}]"
            if not isinstance(section, dict):
                fail(section_path, "section must be an object")
            validate_section(section, section_path)
    else:
        fail(lesson_path, "lesson must have chapters or sections")

    if not lesson_has_completion(data):
        fail(lesson_path, "lesson must end with completion (explicit section or final chapter flow)")

    return chapter_count, count_new_words_in_sections(sections if isinstance(sections, list) else [])


def validate_course(course: dict[str, Any], lesson_files: list[Path]) -> None:
    lessons = course.get("lessons")
    if not isinstance(lessons, list):
        fail("course.json", "lessons must be a list")
    if len(lessons) != EXPECTED_LESSON_COUNT:
        fail("course.json", f"expected {EXPECTED_LESSON_COUNT} lessons, found {len(lessons)}")

    seen_numbers: set[int] = set()
    seen_ids: set[str] = set()
    for index, lesson in enumerate(lessons):
        lesson_path = f"course.json.lessons[{index}]"
        if not isinstance(lesson, dict):
            fail(lesson_path, "lesson summary must be an object")
        lesson_id = lesson.get("id")
        if not isinstance(lesson_id, str) or not lesson_id.strip():
            fail(lesson_path, "lesson id is required")
        if lesson_id in seen_ids:
            fail(lesson_path, f"duplicate lesson id {lesson_id!r}")
        seen_ids.add(lesson_id)

        number = lesson.get("number")
        if not isinstance(number, int):
            fail(lesson_path, "lesson number must be an integer")
        if number in seen_numbers:
            fail(lesson_path, f"duplicate lesson number {number}")
        seen_numbers.add(number)

        content_file = lesson.get("contentFile")
        expected_stem = f"lesson_{number:02d}"
        if content_file != expected_stem:
            fail(lesson_path, f"contentFile must be {expected_stem!r}, got {content_file!r}")

        expected_path = PATH_COURSE / f"{expected_stem}.json"
        if not expected_path.exists():
            fail(lesson_path, f"missing content file {expected_stem}.json")

        vocab_count = lesson.get("vocabularyCount")
        if not isinstance(vocab_count, int) or vocab_count < 0:
            fail(lesson_path, "vocabularyCount must be a non-negative integer")

        is_available = lesson.get("isAvailable")
        if not isinstance(is_available, bool):
            fail(lesson_path, "isAvailable must be a boolean")

    file_stems = {path.stem for path in lesson_files}
    for lesson in lessons:
        if isinstance(lesson, dict) and lesson.get("contentFile") not in file_stems:
            fail("course.json", f"content file {lesson.get('contentFile')!r} not found on disk")

    if seen_numbers != set(range(1, EXPECTED_LESSON_COUNT + 1)):
        fail("course.json", "lesson numbers must be 1..15 without gaps")


def main() -> int:
    if not PATH_COURSE.is_dir():
        print(f"FAIL: PathCourse directory not found: {PATH_COURSE}", file=sys.stderr)
        return 1

    errors: list[str] = []
    lesson_files = sorted(PATH_COURSE.glob("lesson_*.json"))
    if len(lesson_files) != EXPECTED_LESSON_COUNT:
        errors.append(
            f"expected {EXPECTED_LESSON_COUNT} lesson_*.json files, found {len(lesson_files)}"
        )

    course_path = PATH_COURSE / "course.json"
    if not course_path.exists():
        errors.append("missing course.json")
    else:
        try:
            course = load_json(course_path)
            check_forbidden_markers(course, "course.json")
            validate_course(course, lesson_files)
        except ValidationError as exc:
            errors.append(str(exc))

    chapter_lessons = 0
    for path in lesson_files:
        try:
            data = load_json(path)
            check_forbidden_markers(data, path.name)
            chapters, _ = validate_lesson(data, path.name)
            if chapters:
                chapter_lessons += 1
            print(f"OK  {path.name} ({chapters} chapters)")
        except ValidationError as exc:
            errors.append(str(exc))
            print(f"FAIL {path.name}: {exc}")

    print()
    if errors:
        print(f"Path course validation failed with {len(errors)} error(s):", file=sys.stderr)
        for error in errors:
            print(f"  - {error}", file=sys.stderr)
        return 1

    print(
        f"Path course validation passed: {EXPECTED_LESSON_COUNT} lessons, "
        f"{chapter_lessons} with explicit chapters."
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
