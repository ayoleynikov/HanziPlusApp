#!/usr/bin/env python3
"""Validate localized study JSON and travel phrases.

Run from repo root:
  python3 scripts/i18n/validate_localization.py
"""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
DATA = ROOT / "HanziPlus" / "Resources" / "Data"
SNAPSHOT = ROOT / "scripts" / "i18n" / "content_snapshot.json"
XCSTRINGS = ROOT / "HanziPlus" / "Localizable.xcstrings"

LANGS = ("en", "ru", "es", "pt-BR")
WORD_FILES = (
    "hsk1",
    "hsk2",
    "hsk3",
    "travel",
    "food",
    "daily_life",
    "business",
    "culture",
    "technology",
)
KNOWN_CATEGORIES = {
    "essentials",
    "airport",
    "transport",
    "hotel",
    "food",
    "shopping",
    "internet",
    "emergency",
}
PLACEHOLDERS = re.compile(
    r"(?i)(?<![\w])(TODO:|TBD:|FIXME:|\bTBD\b|\bFIXME\b|xxx{2,}|\[translation\]|null translation)"
)
# Identical cross-language strings that are acceptable (brands, loanwords).
ALLOWED_IDENTICAL = {
    "alipay",
    "wechat",
    "wifi",
    "wi-fi",
    "sim",
    "esim",
    "qr",
    "hsk",
    "hsk 1",
    "hsk 2",
    "hsk 3",
    "ok",
    "wifi",
}

errors: list[str] = []


def fail(msg: str) -> None:
    errors.append(msg)
    print(f"FAIL: {msg}")


def load_json(path: Path):
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        fail(f"invalid JSON {path}: {exc}")
        return None


def identity(word: dict) -> tuple:
    return (
        word.get("hanzi"),
        word.get("pinyin"),
        word.get("section"),
        word.get("english"),
    )


def check_text(value: str, where: str) -> None:
    if not isinstance(value, str) or not value.strip():
        fail(f"{where}: empty translation")
        return
    if PLACEHOLDERS.search(value):
        fail(f"{where}: placeholder in '{value}'")


def check_translations(trans: dict | None, english: str, where: str) -> None:
    if not isinstance(trans, dict):
        fail(f"{where}: missing translations object")
        return
    for lang in LANGS:
        if lang not in trans:
            fail(f"{where}: missing {lang}")
            continue
        check_text(trans[lang], f"{where}.{lang}")
    values = [trans.get(lang, "").strip() for lang in LANGS if trans.get(lang)]
    unique = set(v.lower() for v in values)
    # Flag if all four languages accidentally share the same non-allowed string.
    if len(values) >= 3 and len(unique) == 1:
        token = values[0].lower()
        if token not in ALLOWED_IDENTICAL and not token.isascii() or False:
            pass
        if token not in ALLOWED_IDENTICAL and any(c.isalpha() for c in token):
            # English matching ru/es/pt is only OK for brands.
            non_en = {trans.get("ru", ""), trans.get("es", ""), trans.get("pt-BR", "")}
            if len({v.strip().lower() for v in non_en if v}) == 1:
                shared = next(iter(non_en)).strip()
                if shared.lower() not in ALLOWED_IDENTICAL and shared.lower() != english.strip().lower():
                    # ru/es/pt identical to each other (not just matching English brand)
                    if shared.lower() not in ALLOWED_IDENTICAL:
                        fail(f"{where}: ru/es/pt-BR unexpectedly identical ('{shared}')")


def snapshot_words() -> dict:
    snap = {}
    for name in WORD_FILES:
        path = DATA / f"{name}.json"
        data = load_json(path) or []
        snap[name] = {
            "count": len(data),
            "identity": [
                {
                    "hanzi": w.get("hanzi"),
                    "pinyin": w.get("pinyin"),
                    "section": w.get("section"),
                    "english": w.get("english"),
                    "example_hanzi": [
                        (ex if isinstance(ex, str) else ex.get("hanzi"))
                        for ex in (w.get("examples") or [])
                    ],
                }
                for w in data
            ],
        }
    phrases = load_json(DATA / "travel_phrases.json") or []
    snap["travel_phrases"] = {
        "count": len(phrases),
        "ids": [p.get("id") for p in phrases],
        "categoryIDs": [p.get("categoryID") for p in phrases],
        "chinese": [p.get("simplifiedChinese") for p in phrases],
        "pinyin": [p.get("pinyin") for p in phrases],
    }
    return snap


def write_snapshot_if_missing() -> dict:
    if SNAPSHOT.exists():
        return json.loads(SNAPSHOT.read_text(encoding="utf-8"))
    snap = snapshot_words()
    SNAPSHOT.parent.mkdir(parents=True, exist_ok=True)
    SNAPSHOT.write_text(json.dumps(snap, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"wrote baseline snapshot {SNAPSHOT}")
    return snap


def validate_words(snap: dict, only: str | None = None) -> tuple[int, int]:
    words_n = 0
    examples_n = 0
    files = WORD_FILES if not only else (only,)
    if only == "travel_phrases":
        return 0, 0
    for name in files:
        path = DATA / f"{name}.json"
        data = load_json(path)
        if data is None:
            continue
        expected = snap[name]
        if len(data) != expected["count"]:
            fail(f"{name}: count {len(data)} != {expected['count']}")
        for index, word in enumerate(data):
            exp = expected["identity"][index]
            if word.get("hanzi") != exp["hanzi"]:
                fail(f"{name}[{index}]: hanzi changed")
            if word.get("pinyin") != exp["pinyin"]:
                fail(f"{name}[{index}]: pinyin changed")
            if word.get("section") != exp["section"]:
                fail(f"{name}[{index}]: section changed")
            words_n += 1
            check_translations(word.get("translations"), word.get("english", ""), f"{name}[{index}].{word.get('hanzi')}")
            examples = word.get("examples") or []
            exp_ex = exp.get("example_hanzi") or []
            if len(examples) != len(exp_ex):
                fail(f"{name}[{index}]: example count changed")
            for ei, example in enumerate(examples):
                examples_n += 1
                if isinstance(example, str):
                    continue
                if example.get("hanzi") != exp_ex[ei]:
                    fail(f"{name}[{index}].example[{ei}]: hanzi changed")
                if example.get("english"):
                    check_translations(
                        example.get("translations"),
                        example.get("english", ""),
                        f"{name}[{index}].example[{ei}]",
                    )
    return words_n, examples_n


def validate_phrases(snap: dict) -> int:
    path = DATA / "travel_phrases.json"
    data = load_json(path)
    if data is None:
        return 0
    expected = snap["travel_phrases"]
    if len(data) != expected["count"]:
        fail(f"travel_phrases: count {len(data)} != {expected['count']}")
    if [p.get("id") for p in data] != expected["ids"]:
        fail("travel_phrases: IDs or order changed")
    for index, phrase in enumerate(data):
        if phrase.get("categoryID") not in KNOWN_CATEGORIES:
            fail(f"travel_phrases[{index}]: unknown category {phrase.get('categoryID')}")
        if phrase.get("simplifiedChinese") != expected["chinese"][index]:
            fail(f"travel_phrases[{index}]: Chinese changed")
        if phrase.get("pinyin") != expected["pinyin"][index]:
            fail(f"travel_phrases[{index}]: pinyin changed")
        check_translations(phrase.get("translations"), phrase.get("english", ""), f"phrase {phrase.get('id')}")
        if phrase.get("usageNote"):
            check_translations(
                phrase.get("usageNoteTranslations"),
                phrase.get("usageNote", ""),
                f"phrase {phrase.get('id')} usageNote",
            )
        if phrase.get("tags"):
            tags = phrase.get("tagTranslations") or {}
            for lang in LANGS:
                if lang not in tags or not tags[lang]:
                    fail(f"phrase {phrase.get('id')}: missing tagTranslations.{lang}")
        for ri, reply in enumerate(phrase.get("possibleReplies") or []):
            check_translations(reply.get("translations"), reply.get("english", ""), f"phrase {phrase.get('id')} reply[{ri}]")
    return len(data)


def validate_xcstrings() -> int:
    data = load_json(XCSTRINGS)
    if not data:
        return 0
    strings = data.get("strings") or {}
    missing_lang = 0
    for key, entry in strings.items():
        locs = (entry or {}).get("localizations") or {}
        # Skip plural-only inspection of empty keys
        for lang in LANGS:
            if lang not in locs:
                fail(f"xcstrings '{key}': missing {lang}")
                missing_lang += 1
    return len(strings)


def main() -> int:
    only = None
    if len(sys.argv) > 1:
        if sys.argv[1] in {"--only", "-o"} and len(sys.argv) > 2:
            only = sys.argv[2]
        elif sys.argv[1] == "--ui":
            only = "ui"
        else:
            only = sys.argv[1]

    snap = write_snapshot_if_missing()
    words_n, examples_n, phrases_n, ui_n = 0, 0, 0, 0
    if only in (None, "words") or (only in WORD_FILES):
        target = None if only in (None, "words") else only
        words_n, examples_n = validate_words(snap, only=target)
    if only in (None, "travel_phrases"):
        phrases_n = validate_phrases(snap)
    if only in (None, "ui"):
        ui_n = validate_xcstrings()

    print("\n== Report ==")
    print(f"  words: {words_n}")
    print(f"  examples: {examples_n}")
    print(f"  TravelPhrase: {phrases_n}")
    print(f"  UI keys: {ui_n}")
    print(f"  locales: {', '.join(LANGS)}")

    if errors:
        print(f"\nRESULT: {len(errors)} failure(s)")
        return 1
    print("\nRESULT: ALL CHECKS PASSED")
    return 0


if __name__ == "__main__":
    sys.exit(main())
