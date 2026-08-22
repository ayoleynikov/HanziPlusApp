#!/usr/bin/env python3
"""Validate travel_phrases.json for HanziPlus Travel Toolkit.

Run from repo root:
  python3 Scripts/validate_travel_phrases.py
"""

from __future__ import annotations

import json
import sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
JSON_PATH = ROOT / "HanziPlus" / "Resources" / "Data" / "travel_phrases.json"

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

REQUIRED_FIELDS = (
    "id",
    "categoryID",
    "simplifiedChinese",
    "pinyin",
    "english",
    "tags",
    "isEmergency",
)


def fail(message: str) -> None:
    print(f"FAIL: {message}")


def main() -> int:
    if not JSON_PATH.exists():
        fail(f"missing file: {JSON_PATH}")
        return 1

    try:
        data = json.loads(JSON_PATH.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        fail(f"invalid JSON: {exc}")
        return 1

    errors = 0

    if not isinstance(data, list):
        fail("root value must be an array")
        return 1

    if len(data) < 60:
        fail(f"expected at least 60 phrases, found {len(data)}")
        errors += 1

    ids: list[str] = []
    chinese: list[str] = []

    for index, item in enumerate(data):
        prefix = f"item[{index}]"

        if not isinstance(item, dict):
            fail(f"{prefix}: must be an object")
            errors += 1
            continue

        for field in REQUIRED_FIELDS:
            if field not in item:
                fail(f"{prefix}: missing field '{field}'")
                errors += 1

        phrase_id = item.get("id")
        if not isinstance(phrase_id, str) or not phrase_id.strip():
            fail(f"{prefix}: id must be a non-empty string")
            errors += 1
        else:
            ids.append(phrase_id)

        category = item.get("categoryID")
        if category not in KNOWN_CATEGORIES:
            fail(f"{prefix}: unknown categoryID '{category}'")
            errors += 1

        for text_field in ("simplifiedChinese", "pinyin", "english"):
            value = item.get(text_field)
            if not isinstance(value, str) or not value.strip():
                fail(f"{prefix}: '{text_field}' must be a non-empty string")
                errors += 1

        zh = item.get("simplifiedChinese")
        if isinstance(zh, str) and zh.strip():
            chinese.append(zh.strip())

        tags = item.get("tags")
        if not isinstance(tags, list) or not tags or not all(isinstance(t, str) and t.strip() for t in tags):
            fail(f"{prefix}: tags must be a non-empty string array")
            errors += 1

        if not isinstance(item.get("isEmergency"), bool):
            fail(f"{prefix}: isEmergency must be a boolean")
            errors += 1

        usage = item.get("usageNote", None)
        if usage is not None and not isinstance(usage, str):
            fail(f"{prefix}: usageNote must be string or null")
            errors += 1

        replies = item.get("possibleReplies", [])
        if replies is None:
            replies = []
        if not isinstance(replies, list):
            fail(f"{prefix}: possibleReplies must be an array or null")
            errors += 1
        else:
            for r_index, reply in enumerate(replies):
                r_prefix = f"{prefix}.possibleReplies[{r_index}]"
                if not isinstance(reply, dict):
                    fail(f"{r_prefix}: must be an object")
                    errors += 1
                    continue
                for key in ("chinese", "pinyin", "english"):
                    value = reply.get(key)
                    if not isinstance(value, str) or not value.strip():
                        fail(f"{r_prefix}: '{key}' must be a non-empty string")
                        errors += 1

    id_counts = Counter(ids)
    for phrase_id, count in id_counts.items():
        if count > 1:
            fail(f"duplicate id '{phrase_id}' ({count})")
            errors += 1

    zh_counts = Counter(chinese)
    for text, count in zh_counts.items():
        if count > 1:
            fail(f"duplicate Chinese '{text}' ({count})")
            errors += 1

    print(f"Checked {len(data)} phrases in {JSON_PATH.relative_to(ROOT)}")
    if errors:
        print(f"Validation failed with {errors} error(s).")
        return 1

    print("Validation passed.")
    print("Counts by category:")
    for category, count in sorted(Counter(item.get("categoryID") for item in data).items()):
        print(f"  {category}: {count}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
