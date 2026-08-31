#!/usr/bin/env python3
"""Offline validation for Guided Daily Lesson planner rules.

Mirrors DailyLessonPlanner sizing, uniqueness, and determinism.

Run from repo root:
  python3 scripts/validate_daily_lesson.py
"""

from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "HanziPlus" / "Resources" / "Data"

MINUTE_TO_WORDS = {5: 5, 10: 8, 15: 12}


def stable_seed(text: str) -> int:
    h = 5381
    for byte in text.encode("utf-8"):
        h = ((h << 5) + h + byte) & 0xFFFFFFFFFFFFFFFF
    return h or 1


def seeded_shuffle(items: list, seed: int) -> list:
    result = list(items)
    state = seed & 0xFFFFFFFFFFFFFFFF
    for i in range(len(result) - 1, 0, -1):
        state = (state * 6364136223846793005 + 1) & 0xFFFFFFFFFFFFFFFF
        j = state % (i + 1)
        result[i], result[j] = result[j], result[i]
    return result


def select_words(
    file_name: str,
    target_count: int,
    learned: set[str],
    date_key: str,
    all_hanzi: list[str],
) -> tuple[list[str], bool]:
    if not all_hanzi:
        return [], True

    unlearned = [h for h in all_hanzi if h not in learned]
    learned_list = [h for h in all_hanzi if h in learned]
    seed = stable_seed(f"{date_key}|{file_name}|{target_count}")

    if not unlearned:
        pool = learned_list or all_hanzi
        review = seeded_shuffle(pool, seed)
        return review[: min(target_count, len(review))], True

    selected: list[str] = []
    selected.extend(unlearned[:target_count])

    if len(selected) < target_count:
        for hanzi in seeded_shuffle(learned_list, (seed + 17) & 0xFFFFFFFFFFFFFFFF):
            if hanzi not in selected:
                selected.append(hanzi)
            if len(selected) == target_count:
                break

    if len(selected) < target_count:
        for hanzi in seeded_shuffle(all_hanzi, (seed + 31) & 0xFFFFFFFFFFFFFFFF):
            if hanzi not in selected:
                selected.append(hanzi)
            if len(selected) == target_count:
                break

    return selected, False


def unique_options(correct: str, candidates: list[str], seed: int, count: int = 4) -> list[str]:
    unique_candidates: list[str] = []
    seen: set[str] = set()
    for value in seeded_shuffle(candidates, seed):
        if value not in seen:
            seen.add(value)
            unique_candidates.append(value)
        if len(unique_candidates) >= max(0, count - 1):
            break

    options = unique_candidates + [correct]
    final: list[str] = []
    final_seen: set[str] = set()
    for value in seeded_shuffle(options, (seed + 99) & 0xFFFFFFFFFFFFFFFF):
        if value not in final_seen:
            final_seen.add(value)
            final.append(value)
    if correct not in final:
        final.append(correct)
    return final[:count]


def load_words(file_name: str) -> list[dict]:
    path = DATA / f"{file_name}.json"
    data = json.loads(path.read_text(encoding="utf-8"))
    assert isinstance(data, list)
    return data


def fail(msg: str) -> None:
    print(f"FAIL: {msg}")


def main() -> int:
    errors = 0
    words = load_words("hsk1")
    all_hanzi = [w["hanzi"] for w in words]
    english_by = {w["hanzi"]: w["english"] for w in words}

    print("== Lesson sizes ==")
    for minutes, expected in MINUTE_TO_WORDS.items():
        selected, _ = select_words("hsk1", expected, set(), "2026-08-22", all_hanzi)
        ok = len(selected) == expected
        print(f"  {minutes} min → {len(selected)} words (expected {expected}): {'OK' if ok else 'FAIL'}")
        if not ok:
            errors += 1

    print("== Determinism ==")
    a, _ = select_words("hsk1", 8, set(), "2026-08-22", all_hanzi)
    b, _ = select_words("hsk1", 8, set(), "2026-08-22", all_hanzi)
    c, _ = select_words("hsk1", 8, set(), "2026-08-23", all_hanzi)
    if a != b:
        fail("same day produced different word order")
        errors += 1
    else:
        print("  same dateKey → identical order: OK")
    expected_fresh = all_hanzi[:8]
    if a[: len(expected_fresh)] == expected_fresh:
        print("  fresh lesson starts with curriculum order: OK")
    else:
        fail(f"expected first words {expected_fresh}, got {a}")
        errors += 1
    if a == c:
        print("  WARN: adjacent days matched (rare but possible)")
    else:
        print("  different dateKey → different order: OK")

    print("== Review fill ==")
    learned = set(all_hanzi[: max(0, len(all_hanzi) - 3)])
    selected, is_review = select_words("hsk1", 8, learned, "2026-08-22", all_hanzi)
    if len(selected) != 8:
        fail(f"partial unlearned set did not reach target (got {len(selected)})")
        errors += 1
    else:
        print(f"  fill to 8 with review words: OK (reviewLesson={is_review})")

    print("== Full review lesson ==")
    selected, is_review = select_words("hsk1", 5, set(all_hanzi), "2026-08-22", all_hanzi)
    if not is_review or len(selected) != 5:
        fail(f"expected review lesson of 5, got review={is_review} count={len(selected)}")
        errors += 1
    else:
        print("  all learned → review lesson of 5: OK")

    print("== Unique distractors ==")
    for hanzi in selected[:5]:
        en = english_by[hanzi]
        en_opts = unique_options(
            en,
            [w["english"] for w in words if w["english"] != en],
            stable_seed(f"2026-08-22|en|{hanzi}"),
        )
        zh_opts = unique_options(
            hanzi,
            [h for h in all_hanzi if h != hanzi],
            stable_seed(f"2026-08-22|zh|{hanzi}"),
        )
        if len(en_opts) != len(set(en_opts)) or en not in en_opts:
            fail(f"english options invalid for {hanzi}: {en_opts}")
            errors += 1
        if len(zh_opts) != len(set(zh_opts)) or hanzi not in zh_opts:
            fail(f"hanzi options invalid for {hanzi}: {zh_opts}")
            errors += 1
    if errors == 0:
        print("  english + hanzi option sets unique and include correct: OK")

    if errors:
        print(f"\nRESULT: {errors} failure(s)")
        return 1

    print("\nRESULT: ALL CHECKS PASSED")
    return 0


if __name__ == "__main__":
    sys.exit(main())
