#!/usr/bin/env python3
"""Rebuild hsk1.json with the official HSK 2.0 level-1 word list (150 words)."""

from __future__ import annotations

import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA_DIR = ROOT / "HanziPlus" / "Resources" / "Data"
HSK1_PATH = DATA_DIR / "hsk1.json"
REFERENCE = ROOT / "scripts" / "i18n" / "hsk1_official_reference.txt"

# Official HSK 1 order (150 words, HSK 2.0).
OFFICIAL_ORDER = """
爱 八 爸爸 杯子 北京 本 不客气 不 菜 茶 吃 出租车 打电话 大 的 点 电脑 电视 电影 东西 都 读 对不起 多 多少 儿子 二 饭店 飞机 分钟 高兴 个 工作 狗 汉语 好 号 喝 和 很 后面 回 会 几 家 叫 今天 九 开 看 看见 块 来 老师 了 冷 里 六 妈妈 吗 买 猫 没关系 没有 米饭 名字 明天 哪 哪儿 那 呢 能 你 年 女儿 朋友 漂亮 苹果 七 前面 钱 请 去 热 人 认识 三 商店 上 上午 少 谁 什么 十 时候 是 书 水 水果 睡觉 说 四 岁 他 她 太 天气 听 同学 喂 我 我们 五 喜欢 下 下午 下雨 先生 现在 想 小 小姐 些 写 谢谢 星期 学生 学习 学校 一 一点儿 医生 医院 衣服 椅子 有 月 再见 在 怎么 怎么样 这 中国 中午 住 桌子 字 昨天 做 坐
""".split()

PREFERENCE = [
    "hsk1.json",
    "daily_life.json",
    "travel.json",
    "food.json",
    "culture.json",
    "business.json",
    "technology.json",
    "hsk2.json",
    "hsk3.json",
]


def load_catalog() -> dict[str, dict]:
    catalog: dict[str, dict] = {}
    for fname in PREFERENCE:
        path = DATA_DIR / fname
        if not path.exists():
            continue
        for word in json.loads(path.read_text(encoding="utf-8")):
            hanzi = word.get("hanzi")
            if hanzi and hanzi not in catalog:
                catalog[hanzi] = word
    return catalog


def parse_reference() -> dict[str, dict]:
    if not REFERENCE.exists():
        return {}
    text = REFERENCE.read_text(encoding="utf-8")
    entries: dict[str, dict] = {}
    row_re = re.compile(
        r"^\|\s*\d+\s*\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|\s*(.+?)\s*\|\s*Play",
        re.MULTILINE,
    )
    for match in row_re.finditer(text):
        hanzi_raw, pinyin_raw, rest = match.groups()
        hanzi = hanzi_raw.strip().split()[0]
        pinyin = pinyin_raw.strip()

        example_match = re.search(
            r"([\u4e00-\u9fff][^。！？]*[。！？])\s+(.+?)\s+—\s+(.+)$",
            rest.strip(),
        )
        if example_match:
            ex_h, ex_p, ex_e = example_match.groups()
            english = rest.split(ex_h, 1)[0].strip().rstrip(";").split(";")[0].strip()
            examples = [
                {"hanzi": ex_h.strip(), "pinyin": ex_p.strip(), "english": ex_e.strip()}
            ]
        else:
            english = rest.strip().split(";")[0].strip()
            examples = []

        entries[hanzi] = {
            "hanzi": hanzi,
            "pinyin": pinyin,
            "english": english,
            "examples": examples,
        }
    return entries


def strip_section(word: dict) -> dict:
    cleaned = {k: v for k, v in word.items() if k != "section"}
    if "examples" in cleaned:
        cleaned["examples"] = cleaned["examples"][:2]
    return cleaned


def main() -> None:
    catalog = load_catalog()
    reference = parse_reference()
    rebuilt: list[dict] = []
    missing: list[str] = []

    for hanzi in OFFICIAL_ORDER:
        catalog_word = catalog.get(hanzi)
        reference_word = reference.get(hanzi)

        if catalog_word and catalog_word.get("examples"):
            rebuilt.append(strip_section(catalog_word))
        elif reference_word:
            rebuilt.append(reference_word)
        elif catalog_word:
            rebuilt.append(strip_section(catalog_word))
        else:
            missing.append(hanzi)

    if missing:
        raise SystemExit(f"Missing {len(missing)} HSK1 words: {missing}")

    if len(rebuilt) != 150:
        raise SystemExit(f"Expected 150 words, got {len(rebuilt)}")

    HSK1_PATH.write_text(
        json.dumps(rebuilt, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(f"Wrote {HSK1_PATH} ({len(rebuilt)} words)")
    print("First 10:", [w["hanzi"] for w in rebuilt[:10]])
    print("Removed non-HSK1 from old file:",
          [w["hanzi"] for w in json.loads((DATA_DIR / "hsk1.json").read_text()) if w["hanzi"] not in OFFICIAL_ORDER][:5], "...")


if __name__ == "__main__":
    main()
