#!/usr/bin/env python3
"""Generate Path Course lesson JSON files 6–10 and update course.json."""

from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
OUTPUT_DIR = ROOT / "Resources" / "PathCourse"
COURSE_JSON = OUTPUT_DIR / "course.json"


def slugify(text: str) -> str:
    text = re.sub(r"[，。！？、：；…（）\s/·]+", "_", text)
    text = re.sub(r"[^\w]+", "", text, flags=re.UNICODE)
    if not text:
        text = "item"
    return text[:48].strip("_").lower() or "item"


def vocab_item(
    hanzi: str,
    pinyin: str,
    translation: str,
    *,
    item_id: str | None = None,
) -> dict[str, Any]:
    return {
        "id": item_id or slugify(hanzi),
        "hanzi": hanzi,
        "pinyin": pinyin,
        "translation": translation,
        "audioKey": None,
        "countsInLessonTotal": True,
        "isPhraseExample": False,
    }


def dialogue_line(hanzi: str, pinyin: str, speaker: str) -> dict[str, Any]:
    return {
        "speaker": speaker,
        "hanzi": hanzi,
        "pinyin": pinyin,
        "translation": None,
        "audioKey": None,
    }


def lines_with_speakers(pairs: list[tuple[str, str]]) -> list[dict[str, Any]]:
    speakers = ("A", "B")
    return [
        dialogue_line(hanzi, pinyin, speakers[i % 2])
        for i, (hanzi, pinyin) in enumerate(pairs)
    ]


def example_item(
    hanzi: str,
    pinyin: str,
    *,
    group: str | None = None,
    item_id: str | None = None,
) -> dict[str, Any]:
    item: dict[str, Any] = {
        "id": item_id or f"ex_{slugify(hanzi)}",
        "hanzi": hanzi,
        "pinyin": pinyin,
        "translation": None,
    }
    if group is not None:
        item["group"] = group
    return item


def vocabulary_section(group_id: str, title: str, items: list[dict[str, Any]]) -> dict[str, Any]:
    return {
        "kind": "vocabulary",
        "vocabulary": {
            "id": group_id,
            "title": title,
            "items": items,
        },
    }


def dialogue_section(
    dialogue_id: str,
    lines: list[dict[str, Any]],
    *,
    continue_title: str = "Изучить новые слова",
    show_header: bool = True,
    title: str | None = None,
) -> dict[str, Any]:
    return {
        "kind": "dialogue",
        "continueButtonTitle": continue_title,
        "showLessonHeader": show_header,
        "dialogue": {
            "id": dialogue_id,
            "title": title,
            "lines": lines,
        },
    }


def dialogue_repeat_section(
    dialogue_id: str,
    lines: list[dict[str, Any]],
    *,
    title: str = "Прочитай диалог ещё раз",
    dialogue_title: str | None = None,
) -> dict[str, Any]:
    return {
        "kind": "dialogueRepeat",
        "title": title,
        "dialogue": {
            "id": dialogue_id,
            "title": dialogue_title,
            "lines": lines,
        },
    }


def build_lesson(
    number: int,
    chinese_title: str,
    pinyin_title: str,
    dialogues: list[dict[str, Any]],
    vocab_groups: list[tuple[str, str, list[dict[str, Any]]]],
    examples: list[dict[str, Any]],
    *,
    repeat_titles: list[str] | None = None,
) -> dict[str, Any]:
    lesson_id = f"lesson_{number:02d}"
    sections: list[dict[str, Any]] = []

    for index, dialogue in enumerate(dialogues):
        sections.append(
            dialogue_section(
                dialogue["id"],
                dialogue["lines"],
                continue_title="Изучить новые слова" if index == 0 else "Дальше",
                show_header=index == 0,
                title=dialogue.get("title"),
            )
        )

    for group_id, title, items in vocab_groups:
        sections.append(vocabulary_section(group_id, title, items))

    sections.append(
        {
            "kind": "vocabularySummary",
            "groups": [
                {"id": group_id, "title": title, "items": []}
                for group_id, title, _ in vocab_groups
            ],
        }
    )

    default_repeat_titles = ["Прочитай диалог ещё раз"] + ["Дальше"] * (len(dialogues) - 1)
    repeat_titles = repeat_titles or default_repeat_titles
    for dialogue, repeat_title in zip(dialogues, repeat_titles):
        sections.append(
            dialogue_repeat_section(
                dialogue["id"],
                dialogue["lines"],
                title=repeat_title,
                dialogue_title=dialogue.get("title"),
            )
        )

    sections.extend(
        [
            {"kind": "quizChineseToTranslation"},
            {"kind": "quizTranslationToChinese"},
            {"kind": "examples", "items": examples},
            {"kind": "completion"},
        ]
    )

    return {
        "id": lesson_id,
        "number": number,
        "sourceLessonNumbers": [number],
        "chineseTitle": chinese_title,
        "chineseSubtitle": None,
        "pinyinTitle": pinyin_title,
        "translationTitle": None,
        "sections": sections,
    }


# ---------------------------------------------------------------------------
# Lesson 6
# ---------------------------------------------------------------------------

LESSON_06_DIALOGUE_1 = lines_with_speakers(
    [
        ("请问，你贵姓？", "Qǐngwèn, nǐ guìxìng?"),
        ("我姓张。", "Wǒ xìng Zhāng."),
        ("你叫什么名字？", "Nǐ jiào shénme míngzi?"),
        ("我叫张东。", "Wǒ jiào Zhāng Dōng."),
        ("你是哪国人？", "Nǐ shì nǎ guó rén?"),
        ("我是中国人。你是哪国人？", "Wǒ shì Zhōngguó rén. Nǐ shì nǎ guó rén?"),
        ("我是俄国人。", "Wǒ shì Éguó rén."),
        ("你学习什么？", "Nǐ xuéxí shénme?"),
        ("我学习汉语。", "Wǒ xuéxí Hànyǔ."),
        ("汉语难吗？", "Hànyǔ nán ma?"),
        ("汉字很难，发音不太难。", "Hànzì hěn nán, fāyīn bú tài nán."),
    ]
)

LESSON_06_DIALOGUE_2 = lines_with_speakers(
    [
        ("这是什么？", "Zhè shì shénme?"),
        ("这是书。", "Zhè shì shū."),
        ("这是什么书？", "Zhè shì shénme shū?"),
        ("这是中文书。", "Zhè shì Zhōngwén shū."),
        ("这是谁的书？", "Zhè shì shéi de shū?"),
        ("这是老师的书。", "Zhè shì lǎoshī de shū."),
        ("那是什么？", "Nà shì shénme?"),
        ("那是杂志。", "Nà shì zázhì."),
        ("那是什么杂志？", "Nà shì shénme zázhì?"),
        ("那是俄文杂志。", "Nà shì Éwén zázhì."),
        ("那是谁的杂志？", "Nà shì shéi de zázhì?"),
        ("那是我朋友的杂志。", "Nà shì wǒ péngyou de zázhì."),
    ]
)

LESSON_06_VOCAB_COUNTRIES = [
    vocab_item("中国", "Zhōngguó", "Китай"),
    vocab_item("德国", "Déguó", "Германия"),
    vocab_item("俄国", "Éguó", "Россия"),
    vocab_item("法国", "Fǎguó", "Франция"),
    vocab_item("韩国", "Hánguó", "Республика Корея"),
    vocab_item("美国", "Měiguó", "США"),
    vocab_item("日本", "Rìběn", "Япония"),
    vocab_item("英国", "Yīngguó", "Англия"),
    vocab_item("国", "guó", "страна / государство"),
    vocab_item("人", "rén", "человек"),
]

LESSON_06_VOCAB_LANGUAGES = [
    vocab_item("俄文", "Éwén", "русский язык / русский текст"),
    vocab_item("中文", "Zhōngwén", "китайский язык"),
    vocab_item("阿拉伯文", "Ālābówén", "арабский язык"),
    vocab_item("德文", "Déwén", "немецкий язык"),
    vocab_item("法文", "Fǎwén", "французский язык"),
    vocab_item("韩文", "Hánwén", "корейский язык"),
    vocab_item("日文", "Rìwén", "японский язык"),
    vocab_item("西班牙文", "Xībānyáwén", "испанский язык"),
    vocab_item("英文", "Yīngwén", "английский язык"),
    vocab_item("……文", "…wén", "язык / письменный язык", item_id="wen_suffix"),
]

LESSON_06_VOCAB_MAIN = [
    vocab_item("请问", "qǐngwèn", "позвольте спросить"),
    vocab_item("问", "wèn", "спросить"),
    vocab_item("贵姓", "guìxìng", "ваша фамилия / как ваша фамилия"),
    vocab_item("姓", "xìng", "фамилия"),
    vocab_item("叫", "jiào", "звать"),
    vocab_item("名字", "míngzi", "имя"),
    vocab_item("哪", "nǎ", "который / какой"),
    vocab_item("学习", "xuéxí", "учиться / изучать"),
    vocab_item("汉字", "Hànzì", "китайский иероглиф"),
    vocab_item("发音", "fāyīn", "произношение"),
    vocab_item("什么", "shénme", "что"),
    vocab_item("书", "shū", "книга"),
    vocab_item("谁", "shéi", "кто", item_id="shei"),
    vocab_item("的", "de", "структурная частица принадлежности"),
    vocab_item("那", "nà", "тот"),
    vocab_item("杂志", "zázhì", "журнал"),
    vocab_item("朋友", "péngyou", "друг"),
    vocab_item("萨沙", "Sàshā", "Саша"),
    vocab_item("张东", "Zhāng Dōng", "Чжан Дун"),
]

LESSON_06_EXAMPLES = [
    example_item("请问，你贵姓？", "Qǐngwèn, nǐ guìxìng?", group="dialogue"),
    example_item("我姓张。", "Wǒ xìng Zhāng.", group="dialogue"),
    example_item("你叫什么名字？", "Nǐ jiào shénme míngzi?", group="dialogue"),
    example_item("我叫张东。", "Wǒ jiào Zhāng Dōng.", group="dialogue"),
    example_item("你是哪国人？", "Nǐ shì nǎ guó rén?", group="dialogue"),
    example_item("我是中国人。", "Wǒ shì Zhōngguó rén.", group="dialogue"),
    example_item("你学习什么？", "Nǐ xuéxí shénme?", group="dialogue"),
    example_item("我学习汉语。", "Wǒ xuéxí Hànyǔ.", group="dialogue"),
    example_item("汉语难吗？", "Hànyǔ nán ma?", group="dialogue"),
    example_item("汉字很难，发音不太难。", "Hànzì hěn nán, fāyīn bú tài nán.", group="dialogue"),
    example_item("这是什么？", "Zhè shì shénme?", group="dialogue"),
    example_item("这是书。", "Zhè shì shū.", group="dialogue"),
    example_item("这是什么书？", "Zhè shì shénme shū?", group="dialogue"),
    example_item("这是中文书。", "Zhè shì Zhōngwén shū.", group="dialogue"),
    example_item("这是谁的书？", "Zhè shì shéi de shū?", group="dialogue"),
    example_item("这是老师的书。", "Zhè shì lǎoshī de shū.", group="dialogue"),
    example_item("那是什么？", "Nà shì shénme?", group="dialogue"),
    example_item("那是杂志。", "Nà shì zázhì.", group="dialogue"),
    example_item("那是什么杂志？", "Nà shì shénme zázhì?", group="dialogue"),
    example_item("那是俄文杂志。", "Nà shì Éwén zázhì.", group="dialogue"),
    example_item("那是谁的杂志？", "Nà shì shéi de zázhì?", group="dialogue"),
    example_item("那是我朋友的杂志。", "Nà shì wǒ péngyou de zázhì.", group="dialogue"),
    example_item("你叫什么名字？", "Nǐ jiào shénme míngzi?", group="additional", item_id="ex_add_mingzi"),
    example_item("你是哪国人？", "Nǐ shì nǎ guó rén?", group="additional", item_id="ex_add_guoren"),
    example_item("你学习什么？", "Nǐ xuéxí shénme?", group="additional", item_id="ex_add_xuexi"),
    example_item("汉语难吗？", "Hànyǔ nán ma?", group="additional", item_id="ex_add_nama"),
    example_item("我是中国人。", "Wǒ shì Zhōngguó rén.", group="additional", item_id="ex_add_zhongguo"),
    example_item("我学习汉语。", "Wǒ xuéxí Hànyǔ.", group="additional", item_id="ex_add_hanyu"),
    example_item("这是什么书？", "Zhè shì shénme shū?", group="additional", item_id="ex_add_shenmeshu"),
    example_item("这是俄文杂志。", "Zhè shì Éwén zázhì.", group="additional"),
    example_item("那是谁的书？", "Nà shì shéi de shū?", group="additional", item_id="ex_add_shuide"),
    example_item("那是王老师的书。", "Nà shì Wáng lǎoshī de shū.", group="additional"),
]

# ---------------------------------------------------------------------------
# Lesson 7
# ---------------------------------------------------------------------------

LESSON_07_DIALOGUE = lines_with_speakers(
    [
        ("中午你去哪儿吃饭？", "Zhōngwǔ nǐ qù nǎr chī fàn?"),
        ("我去食堂。", "Wǒ qù shítáng."),
        ("你吃什么？", "Nǐ chī shénme?"),
        ("我吃馒头。", "Wǒ chī mántou."),
        ("你要几个？", "Nǐ yào jǐ ge?"),
        ("一个。你吃吗？", "Yí ge. Nǐ chī ma?"),
        ("不吃，我吃米饭。你喝什么？", "Bù chī, wǒ chī mǐfàn. Nǐ hē shénme?"),
        ("我要一碗鸡蛋汤。你喝吗？", "Wǒ yào yì wǎn jīdàn tāng. Nǐ hē ma?"),
        ("不喝，我喝啤酒。", "Bù hē, wǒ hē píjiǔ."),
        ("这些是什么？", "Zhèxiē shì shénme?"),
        ("这是饺子，这是包子，那是面条儿。", "Zhè shì jiǎozi, zhè shì bāozi, nà shì miàntiáor."),
    ]
)

LESSON_07_VOCAB_FOOD = [
    vocab_item("中午", "zhōngwǔ", "полдень"),
    vocab_item("吃", "chī", "есть / кушать"),
    vocab_item("饭", "fàn", "еда"),
    vocab_item("食堂", "shítáng", "столовая"),
    vocab_item("馒头", "mántou", "маньтоу"),
    vocab_item("米饭", "mǐfàn", "варёный рис"),
    vocab_item("米", "mǐ", "рис"),
    vocab_item("饺子", "jiǎozi", "пельмени"),
    vocab_item("包子", "bāozi", "баоцзы / пирожок"),
    vocab_item("面条儿", "miàntiáor", "лапша"),
]

LESSON_07_VOCAB_DRINKS = [
    vocab_item("要", "yào", "хотеть / желать"),
    vocab_item("碗", "wǎn", "чаша"),
    vocab_item("鸡蛋", "jīdàn", "яйцо"),
    vocab_item("鸡", "jī", "курица / петух"),
    vocab_item("蛋", "dàn", "яйцо"),
    vocab_item("汤", "tāng", "суп"),
    vocab_item("啤酒", "píjiǔ", "пиво"),
    vocab_item("酒", "jiǔ", "алкогольный напиток"),
]

LESSON_07_VOCAB_OTHER = [
    vocab_item("这些", "zhèxiē", "эти"),
    vocab_item("些", "xiē", "несколько"),
    vocab_item("一些", "yìxiē", "немного / несколько"),
    vocab_item("那些", "nàxiē", "те"),
    vocab_item("个", "ge", "универсальное счётное слово"),
]

LESSON_07_EXAMPLES = [
    example_item("中午你去哪儿吃饭？", "Zhōngwǔ nǐ qù nǎr chī fàn?", group="dialogue"),
    example_item("我去食堂。", "Wǒ qù shítáng.", group="dialogue"),
    example_item("你吃什么？", "Nǐ chī shénme?", group="dialogue"),
    example_item("我吃馒头。", "Wǒ chī mántou.", group="dialogue"),
    example_item("你要几个？", "Nǐ yào jǐ ge?", group="dialogue"),
    example_item("一个。你吃吗？", "Yí ge. Nǐ chī ma?", group="dialogue"),
    example_item("不吃，我吃米饭。你喝什么？", "Bù chī, wǒ chī mǐfàn. Nǐ hē shénme?", group="dialogue"),
    example_item("我要一碗鸡蛋汤。你喝吗？", "Wǒ yào yì wǎn jīdàn tāng. Nǐ hē ma?", group="dialogue"),
    example_item("不喝，我喝啤酒。", "Bù hē, wǒ hē píjiǔ.", group="dialogue"),
    example_item("这些是什么？", "Zhèxiē shì shénme?", group="dialogue"),
    example_item("这是饺子，这是包子，那是面条儿。", "Zhè shì jiǎozi, zhè shì bāozi, nà shì miàntiáor.", group="dialogue"),
    example_item("吃馒头", "chī mántou", group="compounds"),
    example_item("吃包子", "chī bāozi", group="compounds"),
    example_item("吃米饭", "chī mǐfàn", group="compounds"),
    example_item("吃面条儿", "chī miàntiáor", group="compounds"),
    example_item("吃饺子", "chī jiǎozi", group="compounds"),
    example_item("喝什么", "hē shénme", group="compounds"),
    example_item("喝汤", "hē tāng", group="compounds"),
    example_item("喝茶", "hē chá", group="compounds"),
    example_item("喝啤酒", "hē píjiǔ", group="compounds"),
    example_item("什么汤", "shénme tāng", group="compounds"),
    example_item("什么书", "shénme shū", group="compounds"),
    example_item("什么人", "shénme rén", group="compounds"),
    example_item("什么酒", "shénme jiǔ", group="compounds"),
    example_item("什么名字", "shénme míngzi", group="compounds"),
    example_item("你中午吃什么？", "Nǐ zhōngwǔ chī shénme?", group="questions"),
    example_item("你吃什么？", "Nǐ chī shénme?", group="questions", item_id="ex_q_chi_shenme"),
    example_item("你吃几个馒头？", "Nǐ chī jǐ ge mántou?", group="questions"),
    example_item("你喝什么？", "Nǐ hē shénme?", group="questions"),
    example_item("你喝什么汤？", "Nǐ hē shénme tāng?", group="questions"),
    example_item("你喝什么啤酒？", "Nǐ hē shénme píjiǔ?", group="questions"),
]

# ---------------------------------------------------------------------------
# Lesson 8
# ---------------------------------------------------------------------------

LESSON_08_DIALOGUE = lines_with_speakers(
    [
        ("你买什么？", "Nǐ mǎi shénme?"),
        ("我买水果。苹果一斤多少钱？", "Wǒ mǎi shuǐguǒ. Píngguǒ yì jīn duōshao qián?"),
        ("三块。", "Sān kuài."),
        ("三块？太贵了。两块五吧。", "Sān kuài? Tài guì le. Liǎng kuài wǔ ba."),
        ("你要几斤？", "Nǐ yào jǐ jīn?"),
        ("我要五斤。", "Wǒ yào wǔ jīn."),
        ("还要别的吗？", "Hái yào biéde ma?"),
        ("橘子怎么卖？", "Júzi zěnme mài?"),
        ("两块。", "Liǎng kuài."),
        ("要两斤。一共多少钱？", "Yào liǎng jīn. Yígòng duōshao qián?"),
        ("一共十六块五（毛）。你给十六块吧。", "Yígòng shíliù kuài wǔ (máo). Nǐ gěi shíliù kuài ba."),
        ("给你钱。", "Gěi nǐ qián."),
        ("这是五十，我找您三十四块。", "Zhè shì wǔshí, zhǎo nín sānshísì kuài."),
    ]
)

LESSON_08_VOCAB_SHOPPING = [
    vocab_item("买", "mǎi", "купить / покупать"),
    vocab_item("水果", "shuǐguǒ", "фрукты"),
    vocab_item("苹果", "píngguǒ", "яблоко"),
    vocab_item("橘子", "júzi", "мандарин"),
    vocab_item("怎么", "zěnme", "как"),
    vocab_item("卖", "mài", "продавать"),
    vocab_item("还", "hái", "ещё"),
    vocab_item("别的", "biéde", "другой"),
]

LESSON_08_VOCAB_MONEY = [
    vocab_item("贵", "guì", "дорогой"),
    vocab_item("了", "le", "частица"),
    vocab_item("吧", "ba", "модальная частица"),
    vocab_item("多少", "duōshao", "сколько"),
    vocab_item("多", "duō", "много"),
    vocab_item("少", "shǎo", "мало"),
    vocab_item("块 / 元", "kuài / yuán", "юань", item_id="kuai_yuan"),
    vocab_item("角 / 毛", "jiǎo / máo", "0,1 юаня", item_id="jiao_mao"),
    vocab_item("分", "fēn", "0,01 юаня"),
    vocab_item("给", "gěi", "дать"),
    vocab_item("找", "zhǎo", "дать сдачу"),
]

LESSON_08_VOCAB_QUANTITY = [
    vocab_item("斤", "jīn", "цзинь"),
    vocab_item("公斤", "gōngjīn", "килограмм"),
    vocab_item("两", "liǎng", "два"),
    vocab_item("一共", "yígòng", "всего"),
]

LESSON_08_EXAMPLES = [
    example_item("你买什么？", "Nǐ mǎi shénme?", group="dialogue"),
    example_item("我买水果。", "Wǒ mǎi shuǐguǒ.", group="dialogue"),
    example_item("苹果一斤多少钱？", "Píngguǒ yì jīn duōshao qián?", group="dialogue"),
    example_item("三块。", "Sān kuài.", group="dialogue"),
    example_item("三块？太贵了。两块五吧。", "Sān kuài? Tài guì le. Liǎng kuài wǔ ba.", group="dialogue"),
    example_item("你要几斤？", "Nǐ yào jǐ jīn?", group="dialogue"),
    example_item("我要五斤。", "Wǒ yào wǔ jīn.", group="dialogue"),
    example_item("还要别的吗？", "Hái yào biéde ma?", group="dialogue"),
    example_item("橘子怎么卖？", "Júzi zěnme mài?", group="dialogue"),
    example_item("两块。", "Liǎng kuài.", group="dialogue"),
    example_item("要两斤。", "Yào liǎng jīn.", group="dialogue"),
    example_item("一共多少钱？", "Yígòng duōshao qián?", group="dialogue"),
    example_item("一共十六块五（毛）。", "Yígòng shíliù kuài wǔ (máo).", group="dialogue"),
    example_item("你给十六块吧。", "Nǐ gěi shíliù kuài ba.", group="dialogue"),
    example_item("给你钱。", "Gěi nǐ qián.", group="dialogue"),
    example_item("这是五十，我找您三十四块。", "Zhè shì wǔshí, zhǎo nín sānshísì kuài.", group="dialogue"),
    example_item("买苹果", "mǎi píngguǒ", group="compounds"),
    example_item("买馒头", "mǎi mántou", group="compounds"),
    example_item("买饺子", "mǎi jiǎozi", group="compounds"),
    example_item("买米饭", "mǎi mǐfàn", group="compounds"),
    example_item("买包子", "mǎi bāozi", group="compounds"),
    example_item("多少钱", "duōshao qián", group="compounds"),
    example_item("多少斤", "duōshao jīn", group="compounds"),
    example_item("多少人", "duōshao rén", group="compounds"),
    example_item("多少学生", "duōshao xuésheng", group="compounds"),
    example_item("多少老师", "duōshao lǎoshī", group="compounds"),
    example_item("还买吗", "hái mǎi ma", group="compounds"),
    example_item("还买马", "hái mǎi mǎ", group="compounds"),
    example_item("还去吗", "hái qù ma", group="compounds"),
    example_item("还吃吗", "hái chī ma", group="compounds"),
    example_item("还喝吗", "hái hē ma", group="compounds"),
    example_item("还买", "hái mǎi", group="compounds"),
    example_item("还要", "hái yào", group="compounds"),
    example_item("还去", "hái qù", group="compounds"),
    example_item("还吃", "hái chī", group="compounds"),
    example_item("还喝", "hái hē", group="compounds"),
]

# ---------------------------------------------------------------------------
# Lesson 9
# ---------------------------------------------------------------------------

LESSON_09_DIALOGUE = lines_with_speakers(
    [
        ("下午我去图书馆，你去不去？", "Xiàwǔ wǒ qù túshūguǎn, nǐ qù bu qù?"),
        ("我不去。我要去银行换钱。", "Wǒ bú qù. Wǒ yào qù yínháng huàn qián."),
        ("小姐，我换钱。", "Xiǎojiě, wǒ huàn qián."),
        ("您换什么钱？", "Nín huàn shénme qián?"),
        ("我换人民币。", "Wǒ huàn rénmínbì."),
        ("换多少？", "Huàn duōshao?"),
        ("二百美元。", "Èrbǎi měiyuán."),
        ("请等一会儿……先生，给您钱。", "Qǐng děng yíhuìr... Xiānsheng, gěi nín qián."),
        ("请数数。", "Qǐng shǔshu."),
        ("对了。谢谢！", "Duì le. Xièxie!"),
        ("不客气！", "Bú kèqi!"),
    ]
)

LESSON_09_VOCAB_CURRENCY = [
    vocab_item("人民币", "rénmínbì", "юань / жэньминьби"),
    vocab_item("人民", "rénmín", "народ"),
    vocab_item("美元", "měiyuán", "доллар США"),
    vocab_item("港币", "gǎngbì", "гонконгский доллар"),
    vocab_item("日元", "rìyuán", "японская иена"),
    vocab_item("欧元", "ōuyuán", "евро"),
]

LESSON_09_VOCAB_NUMBERS = [
    vocab_item("百", "bǎi", "сто"),
    vocab_item("千", "qiān", "тысяча"),
    vocab_item("万", "wàn", "десять тысяч"),
]

LESSON_09_VOCAB_BANK = [
    vocab_item("下午", "xiàwǔ", "вторая половина дня"),
    vocab_item("上午", "shàngwǔ", "первая половина дня"),
    vocab_item("图书馆", "túshūguǎn", "библиотека"),
    vocab_item("要", "yào", "хотеть / нужно"),
    vocab_item("换", "huàn", "менять / обменивать"),
    vocab_item("小姐", "xiǎojiě", "мисс"),
    vocab_item("营业员", "yíngyèyuán", "служащий / продавец"),
    vocab_item("等", "děng", "ждать"),
    vocab_item("一会儿", "yíhuìr", "немного времени / минутку"),
    vocab_item("先生", "xiānsheng", "господин"),
    vocab_item("数", "shǔ", "считать"),
]

LESSON_09_EXAMPLES = [
    example_item("下午我去图书馆，你去不去？", "Xiàwǔ wǒ qù túshūguǎn, nǐ qù bu qù?", group="dialogue"),
    example_item("我不去。我要去银行换钱。", "Wǒ bú qù. Wǒ yào qù yínháng huàn qián.", group="dialogue"),
    example_item("小姐，我换钱。", "Xiǎojiě, wǒ huàn qián.", group="dialogue"),
    example_item("您换什么钱？", "Nín huàn shénme qián?", group="dialogue"),
    example_item("我换人民币。", "Wǒ huàn rénmínbì.", group="dialogue"),
    example_item("换多少？", "Huàn duōshao?", group="dialogue"),
    example_item("二百美元。", "Èrbǎi měiyuán.", group="dialogue"),
    example_item("请等一会儿……", "Qǐng děng yíhuìr...", group="dialogue"),
    example_item("先生，给您钱。", "Xiānsheng, gěi nín qián.", group="dialogue"),
    example_item("请数数。", "Qǐng shǔshu.", group="dialogue"),
    example_item("对了。谢谢！", "Duì le. Xièxie!", group="dialogue"),
    example_item("不客气！", "Bú kèqi!", group="dialogue"),
    example_item("先生，我要换钱。", "Xiānsheng, wǒ yào huàn qián.", group="additional"),
    example_item("您换什么钱？", "Nín huàn shénme qián?", group="additional", item_id="ex_add_huan_shenme"),
    example_item("我换五万日元的人民币。", "Wǒ huàn wǔ wàn rìyuán de rénmínbì.", group="additional"),
    example_item("请等一会儿……", "Qǐng děng yíhuìr...", group="additional", item_id="ex_add_deng"),
    example_item("小姐，给您钱，您数数。", "Xiǎojiě, gěi nín qián, nín shǔshu.", group="additional"),
    example_item("对了。谢谢！", "Duì le. Xièxie!", group="additional", item_id="ex_add_duile"),
    example_item("不客气！", "Bú kèqi!", group="additional", item_id="ex_add_bukeqi"),
    example_item("给你", "gěi nǐ", group="compounds"),
    example_item("给我", "gěi wǒ", group="compounds"),
    example_item("给他", "gěi tā", group="compounds"),
    example_item("给你们", "gěi nǐmen", group="compounds"),
    example_item("给他们", "gěi tāmen", group="compounds"),
    example_item("给老师", "gěi lǎoshī", group="compounds"),
    example_item("一百", "yì bǎi", group="compounds"),
    example_item("二百", "èr bǎi", group="compounds"),
    example_item("三百", "sān bǎi", group="compounds"),
    example_item("五百", "wǔ bǎi", group="compounds"),
    example_item("六百", "liù bǎi", group="compounds"),
    example_item("今天下午", "jīntiān xiàwǔ", group="compounds"),
    example_item("明天下午", "míngtiān xiàwǔ", group="compounds"),
    example_item("星期三下午", "xīngqīsān xiàwǔ", group="compounds"),
]

# ---------------------------------------------------------------------------
# Lesson 10
# ---------------------------------------------------------------------------

LESSON_10_DIALOGUE = lines_with_speakers(
    [
        ("请问，这是办公室吗？", "Qǐngwèn, zhè shì bàngōngshì ma?"),
        ("是。你找谁？", "Shì. Nǐ zhǎo shéi?"),
        ("王老师在哪儿？我是他的学生。", "Wáng lǎoshī zài nǎr? Wǒ shì tā de xuésheng."),
        ("他不在。他在家呢。", "Tā bú zài. Tā zài jiā ne."),
        ("他住哪儿？", "Tā zhù nǎr?"),
        ("他住十八楼一门，房间号是601。", "Tā zhù shíbā lóu yì mén, fángjiān hào shì liù líng yī."),
        ("您知道他的电话号码吗？", "Nín zhīdào tā de diànhuà hàomǎ ma?"),
        ("知道，62931074。", "Zhīdào, liù èr jiǔ sān yī líng qī sì."),
        ("他的手机号码是多少？", "Tā de shǒujī hàomǎ shì duōshao?"),
        ("不知道。", "Bù zhīdào."),
        ("谢谢您。", "Xièxie nín."),
        ("不客气。", "Bú kèqi."),
    ]
)

LESSON_10_VOCAB_ADDRESS = [
    vocab_item("办公室", "bàngōngshì", "кабинет"),
    vocab_item("办公", "bàngōng", "работать / заниматься делами"),
    vocab_item("家", "jiā", "дом / семья"),
    vocab_item("呢", "ne", "модальная частица"),
    vocab_item("住", "zhù", "жить"),
    vocab_item("楼", "lóu", "здание / этаж"),
    vocab_item("门", "mén", "дверь / ворота"),
    vocab_item("房间", "fángjiān", "комната"),
    vocab_item("号", "hào", "номер"),
    vocab_item("在", "zài", "находиться / быть в"),
]

LESSON_10_VOCAB_PHONE = [
    vocab_item("知道", "zhīdào", "знать"),
    vocab_item("电话", "diànhuà", "телефон"),
    vocab_item("电", "diàn", "электричество"),
    vocab_item("话", "huà", "слово / речь"),
    vocab_item("号码", "hàomǎ", "номер"),
    vocab_item("零", "líng", "ноль"),
    vocab_item("手机", "shǒujī", "мобильный телефон"),
    vocab_item("手", "shǒu", "рука"),
]

LESSON_10_VOCAB_OTHER = [
    vocab_item("职员", "zhíyuán", "служащий"),
    vocab_item("找", "zhǎo", "искать"),
    vocab_item("李昌浩", "Lǐ Chānghào", "Ли Чанхо"),
]

LESSON_10_EXAMPLES = [
    example_item("请问，这是办公室吗？", "Qǐngwèn, zhè shì bàngōngshì ma?", group="dialogue"),
    example_item("是。你找谁？", "Shì. Nǐ zhǎo shéi?", group="dialogue"),
    example_item("王老师在哪儿？", "Wáng lǎoshī zài nǎr?", group="dialogue"),
    example_item("我是他的学生。", "Wǒ shì tā de xuésheng.", group="dialogue"),
    example_item("他不在。", "Tā bú zài.", group="dialogue"),
    example_item("他在家呢。", "Tā zài jiā ne.", group="dialogue"),
    example_item("他住哪儿？", "Tā zhù nǎr?", group="dialogue"),
    example_item("他住十八楼一门，房间号是601。", "Tā zhù shíbā lóu yì mén, fángjiān hào shì liù líng yī.", group="dialogue"),
    example_item("您知道他的电话号码吗？", "Nín zhīdào tā de diànhuà hàomǎ ma?", group="dialogue"),
    example_item("知道，62931074。", "Zhīdào, liù èr jiǔ sān yī líng qī sì.", group="dialogue"),
    example_item("他的手机号码是多少？", "Tā de shǒujī hàomǎ shì duōshao?", group="dialogue"),
    example_item("不知道。", "Bù zhīdào.", group="dialogue"),
    example_item("谢谢您。", "Xièxie nín.", group="dialogue"),
    example_item("不客气。", "Bú kèqi.", group="dialogue"),
    example_item("找老师", "zhǎo lǎoshī", group="compounds"),
    example_item("找同学", "zhǎo tóngxué", group="compounds"),
    example_item("找朋友", "zhǎo péngyou", group="compounds"),
    example_item("找书", "zhǎo shū", group="compounds"),
    example_item("找食堂", "zhǎo shítáng", group="compounds"),
    example_item("在家", "zài jiā", group="compounds"),
    example_item("在学校", "zài xuéxiào", group="compounds"),
    example_item("在宿舍", "zài sùshè", group="compounds"),
    example_item("在大楼", "zài dàlóu", group="compounds"),
    example_item("在办公室", "zài bàngōngshì", group="compounds"),
    example_item("我知道", "wǒ zhīdào", group="compounds"),
    example_item("你知道", "nǐ zhīdào", group="compounds"),
    example_item("他知道", "tā zhīdào", group="compounds"),
    example_item("不知道", "bù zhīdào", group="compounds"),
    example_item("知道吗", "zhīdào ma", group="compounds"),
    example_item("你是留学生吗？", "Nǐ shì liúxuéshēng ma?", group="questions"),
    example_item("你学习什么？", "Nǐ xuéxí shénme?", group="questions"),
    example_item("你住哪儿？", "Nǐ zhù nǎr?", group="questions"),
    example_item("你住多少号？", "Nǐ zhù duōshao hào?", group="questions"),
    example_item("你的手机号码是多少号？", "Nǐ de shǒujī hàomǎ shì duōshao hào?", group="questions"),
    example_item(
        "我去办公室找王老师，办公室的老师说，王老师不在，他在家呢。王老师住18楼1门601号，他家的电话是62931074。",
        "Wǒ qù bàngōngshì zhǎo Wáng lǎoshī, bàngōngshì de lǎoshī shuō, Wáng lǎoshī bú zài, tā zài jiā ne. Wáng lǎoshī zhù 18 lóu 1 mén 601 hào, tā jiā de diànhuà shì liù èr jiǔ sān yī líng qī sì.",
        group="reading",
        item_id="ex_reading_paragraph",
    ),
]


def lesson_06() -> dict[str, Any]:
    return build_lesson(
        6,
        "我学习汉语",
        "Wǒ xuéxí Hànyǔ",
        [
            {"id": "dialogue_intro", "title": None, "lines": LESSON_06_DIALOGUE_1},
            {"id": "dialogue_books", "title": None, "lines": LESSON_06_DIALOGUE_2},
        ],
        [
            ("vocab_countries", "Страны", LESSON_06_VOCAB_COUNTRIES),
            ("vocab_languages", "Языки", LESSON_06_VOCAB_LANGUAGES),
            ("vocab_main", "Основные слова", LESSON_06_VOCAB_MAIN),
        ],
        LESSON_06_EXAMPLES,
    )


def lesson_07() -> dict[str, Any]:
    return build_lesson(
        7,
        "你吃什么",
        "Nǐ chī shénme",
        [{"id": "dialogue_main", "title": None, "lines": LESSON_07_DIALOGUE}],
        [
            ("vocab_food", "Еда", LESSON_07_VOCAB_FOOD),
            ("vocab_drinks", "Напитки", LESSON_07_VOCAB_DRINKS),
            ("vocab_other", "Другие слова", LESSON_07_VOCAB_OTHER),
        ],
        LESSON_07_EXAMPLES,
    )


def lesson_08() -> dict[str, Any]:
    return build_lesson(
        8,
        "苹果一斤多少钱",
        "Píngguǒ yì jīn duōshao qián",
        [{"id": "dialogue_main", "title": None, "lines": LESSON_08_DIALOGUE}],
        [
            ("vocab_shopping", "Покупки", LESSON_08_VOCAB_SHOPPING),
            ("vocab_money", "Деньги", LESSON_08_VOCAB_MONEY),
            ("vocab_quantity", "Количество", LESSON_08_VOCAB_QUANTITY),
        ],
        LESSON_08_EXAMPLES,
    )


def lesson_09() -> dict[str, Any]:
    return build_lesson(
        9,
        "我换人民币",
        "Wǒ huàn rénmínbì",
        [{"id": "dialogue_main", "title": None, "lines": LESSON_09_DIALOGUE}],
        [
            ("vocab_currency", "Валюта", LESSON_09_VOCAB_CURRENCY),
            ("vocab_numbers", "Числа", LESSON_09_VOCAB_NUMBERS),
            ("vocab_bank", "Банк", LESSON_09_VOCAB_BANK),
        ],
        LESSON_09_EXAMPLES,
    )


def lesson_10() -> dict[str, Any]:
    return build_lesson(
        10,
        "他住哪儿",
        "Tā zhù nǎr",
        [{"id": "dialogue_main", "title": None, "lines": LESSON_10_DIALOGUE}],
        [
            ("vocab_address", "Адрес", LESSON_10_VOCAB_ADDRESS),
            ("vocab_phone", "Телефон", LESSON_10_VOCAB_PHONE),
            ("vocab_other", "Другие слова", LESSON_10_VOCAB_OTHER),
        ],
        LESSON_10_EXAMPLES,
    )


LESSONS = {
    6: lesson_06,
    7: lesson_07,
    8: lesson_08,
    9: lesson_09,
    10: lesson_10,
}


def count_dialogues(lesson: dict[str, Any]) -> int:
    return sum(1 for section in lesson["sections"] if section["kind"] == "dialogue")


def count_vocabulary(lesson: dict[str, Any]) -> int:
    total = 0
    for section in lesson["sections"]:
        if section["kind"] == "vocabulary":
            total += len(section["vocabulary"]["items"])
    return total


def count_examples(lesson: dict[str, Any]) -> int:
    for section in lesson["sections"]:
        if section["kind"] == "examples":
            return len(section["items"])
    return 0


def update_course_json(vocabulary_counts: dict[int, int]) -> None:
    with COURSE_JSON.open(encoding="utf-8") as handle:
        course = json.load(handle)

    unchanged = [entry for entry in course["lessons"] if entry["number"] <= 5]
    new_entries = []
    for number in range(6, 11):
        builder = LESSONS[number]
        lesson = builder()
        new_entries.append(
            {
                "id": f"lesson_{number:02d}",
                "number": number,
                "sourceLessonNumbers": [number],
                "chineseTitle": lesson["chineseTitle"],
                "pinyinTitle": lesson["pinyinTitle"],
                "translationTitle": None,
                "vocabularyCount": vocabulary_counts[number],
                "contentFile": f"lesson_{number:02d}",
                "isAvailable": True,
            }
        )

    new_entries.append(
        {
            "id": "lesson_11",
            "number": 11,
            "sourceLessonNumbers": [11],
            "chineseTitle": "···",
            "pinyinTitle": None,
            "translationTitle": "Скоро",
            "vocabularyCount": 0,
            "contentFile": None,
            "isAvailable": False,
        }
    )

    course["lessons"] = unchanged + new_entries

    with COURSE_JSON.open("w", encoding="utf-8") as handle:
        json.dump(course, handle, ensure_ascii=False, indent=2)
        handle.write("\n")


def main() -> None:
    stats: dict[int, dict[str, int]] = {}
    vocabulary_counts: dict[int, int] = {}

    for number, builder in LESSONS.items():
        lesson = builder()
        vocabulary_counts[number] = count_vocabulary(lesson)
        stats[number] = {
            "dialogues": count_dialogues(lesson),
            "vocabulary": vocabulary_counts[number],
            "examples": count_examples(lesson),
        }

        output_path = OUTPUT_DIR / f"lesson_{number:02d}.json"
        with output_path.open("w", encoding="utf-8") as handle:
            json.dump(lesson, handle, ensure_ascii=False, indent=2)
            handle.write("\n")
        print(f"Wrote {output_path}")

    update_course_json(vocabulary_counts)
    print(f"Updated {COURSE_JSON}")

    print("\n=== Summary ===")
    for number in sorted(stats):
        entry = stats[number]
        print(
            f"Lesson {number}: "
            f"dialogues={entry['dialogues']}, "
            f"vocabulary={entry['vocabulary']}, "
            f"examples={entry['examples']}"
        )


if __name__ == "__main__":
    main()
