#!/usr/bin/env python3
"""Generate Path course lesson JSON files 11–14 from book spec."""

from __future__ import annotations

import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "Resources" / "PathCourse"


def tr(ru: str, en: str, es: str, pt: str) -> dict:
    return {"ru": ru, "en": en, "es": es, "pt-BR": pt}


def line(speaker: str, hanzi: str, pinyin: str) -> dict:
    return {
        "speaker": speaker,
        "hanzi": hanzi,
        "pinyin": pinyin,
        "translation": None,
        "audioKey": None,
    }


def vocab_item(vid: str, hanzi: str, pinyin: str, ru: str, en: str, es: str, pt: str) -> dict:
    return {
        "id": vid,
        "hanzi": hanzi,
        "pinyin": pinyin,
        "translation": tr(ru, en, es, pt),
        "audioKey": None,
        "countsInLessonTotal": True,
        "isPhraseExample": False,
    }


def example(eid: str, hanzi: str, pinyin: str, group: str = "additional") -> dict:
    return {
        "id": eid,
        "hanzi": hanzi,
        "pinyin": pinyin,
        "translation": None,
        "group": group,
    }


def slug(s: str) -> str:
    s = re.sub(r"[^\w\u4e00-\u9fff]+", "_", s)
    return f"ex_{s.strip('_')[:60]}"


def dialogue_section(
    did: str,
    title: str | None,
    lines: list[dict],
    *,
    continue_title: str = "Дальше",
    show_header: bool = False,
) -> dict:
    return {
        "kind": "dialogue",
        "continueButtonTitle": continue_title,
        "showLessonHeader": show_header,
        "dialogue": {"id": did, "title": title, "lines": lines},
    }


def vocab_section(vid: str, title: dict, items: list[dict]) -> dict:
    return {"kind": "vocabulary", "vocabulary": {"id": vid, "title": title, "items": items}}


def summary_groups(groups: list[tuple[str, dict]]) -> dict:
    return {
        "kind": "vocabularySummary",
        "groups": [{"id": gid, "title": title, "items": []} for gid, title in groups],
    }


def repeat(title: str, did: str, dtitle: str | None, lines: list[dict]) -> dict:
    return {
        "kind": "dialogueRepeat",
        "title": title,
        "dialogue": {"id": did, "title": dtitle, "lines": lines},
    }


def tail(examples: list[dict]) -> list[dict]:
    return [
        {"kind": "quizChineseToTranslation"},
        {"kind": "quizTranslationToChinese"},
        {"kind": "examples", "items": examples},
        {"kind": "completion"},
    ]


def write_lesson(data: dict) -> None:
    path = OUT / f"{data['id']}.json"
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"Wrote {path.name}")


# ── Lesson 11 ──────────────────────────────────────────────────────────────

D11_1 = [
    line("秘书", "我先介绍一下儿，这位是王教授。这是马校长。", "Wǒ xiān jièshao yíxiàr, zhè wèi shì Wáng jiàoshòu. Zhè shì Mǎ xiàozhǎng."),
    line("校长", "欢迎您，王教授。", "Huānyíng nín, Wáng jiàoshòu."),
    line("王教授", "谢谢！", "Xièxie!"),
]

D11_2 = [
    line("田芳", "你是留学生吗？", "Nǐ shì liúxuéshēng ma?"),
    line("罗曼", "是。", "Shì."),
    line("田芳", "她也是留学生吗？", "Tā yě shì liúxuéshēng ma?"),
    line("罗曼", "她也是留学生。我们都是留学生。", "Tā yě shì liúxuéshēng. Wǒmen dōu shì liúxuéshēng."),
    line("田芳", "他们俩也都是留学生吗？", "Tāmen liǎ yě dōu shì liúxuéshēng ma?"),
    line("罗曼", "不，他们俩不是留学生。他们都是中国学生。", "Bù, tāmen liǎ bú shì liúxuéshēng. Tāmen dōu shì Zhōngguó xuésheng."),
]

D11_3 = [
    line("爱德华", "他是中国人吗？", "Tā shì Zhōngguó rén ma?"),
    line("李昌浩", "是。", "Shì."),
    line("爱德华", "你也是中国人吗？", "Nǐ yě shì Zhōngguó rén ma?"),
    line("李昌浩", "不是。我是韩国人。", "Bú shì. Wǒ shì Hánguó rén."),
    line("爱德华", "对不起。", "Duìbuqǐ."),
    line("李昌浩", "没什么。", "Méi shénme."),
]

V11_INTRO = [
    vocab_item("mishu", "秘书", "mìshū", "секретарь", "secretary", "secretario/a", "secretário/a"),
    vocab_item("xian", "先", "xiān", "прежде всего", "first; beforehand", "primero; antes", "primeiro; antes"),
    vocab_item("jieshao", "介绍", "jièshao", "познакомить; представить; рекомендовать", "to introduce; to recommend", "presentar; recomendar", "apresentar; recomendar"),
    vocab_item("yixiar", "一下儿", "yíxiàr", "немного; один раз", "a bit; once", "un poco; una vez", "um pouco; uma vez"),
    vocab_item("wei", "位", "wèi", "счётное слово для уважаемых людей", "classifier for people (polite)", "clasificador de personas (cortés)", "classificador de pessoas (cortês)"),
    vocab_item("jiaoshou", "教授", "jiàoshòu", "профессор", "professor", "profesor universitario", "professor universitário"),
    vocab_item("xiaozhang", "校长", "xiàozhǎng", "директор", "principal; president (of school)", "director; rector", "diretor; reitor"),
    vocab_item("huanying", "欢迎", "huānyíng", "приветствовать", "to welcome", "dar la bienvenida", "dar boas-vindas"),
]

V11_STUDENTS = [
    vocab_item("liuxuesheng", "留学生", "liúxuéshēng", "иностранный студент", "international student", "estudiante extranjero", "estudante estrangeiro"),
    vocab_item("liuxue", "留学", "liúxué", "учиться за границей", "to study abroad", "estudiar en el extranjero", "estudar no exterior"),
    vocab_item("ye", "也", "yě", "тоже; также", "also; too", "también", "também"),
    vocab_item("women", "我们", "wǒmen", "мы", "we; us", "nosotros", "nós"),
    vocab_item("nimen", "你们", "nǐmen", "вы", "you (plural)", "ustedes; vosotros", "vocês"),
    vocab_item("tamen", "他们", "tāmen", "они", "they; them", "ellos; ellas", "eles; elas"),
    vocab_item("dou", "都", "dōu", "все", "all; both", "todos; ambos", "todos; ambos"),
    vocab_item("lia", "俩", "liǎ", "оба; двое", "two; both (colloquial)", "dos; ambos (coloquial)", "dois; ambos (coloquial)"),
    vocab_item("xuesheng", "学生", "xuésheng", "студент", "student", "estudiante", "estudante"),
    vocab_item("mei_shenme", "没什么", "méi shénme", "ничего", "it's nothing", "no es nada", "não foi nada"),
]

V11_NAMES = [
    vocab_item("ma", "马", "Mǎ", "Ма", "Ma (surname)", "Ma (apellido)", "Ma (sobrenome)"),
    vocab_item("tian_fang", "田芳", "Tián Fāng", "Тянь Фан", "Tian Fang", "Tian Fang", "Tian Fang"),
    vocab_item("luoman", "罗曼", "Luómàn", "Роман", "Luoman", "Luoman", "Luoman"),
    vocab_item("aidehua", "爱德华", "Àidéhuá", "Эдуард", "Edward", "Eduardo", "Eduardo"),
]

EX11_HANZI = [
    "你是中国人吗？",
    "是。（我是中国人。）",
    "你是老师吗？",
    "不是。我是学生。",
    "他们都是留学生吗？",
    "他们都是留学生。",
    "他们都是学生。",
    "他也是留学生。",
    "她也是留学生。",
    "他们都是留学生。",
    "你是留学生吗？",
    "是。（我是留学生。）",
    "她也是留学生吗？",
    "她也是留学生。我们都是留学生。",
    "他是老师吗？",
    "不是。（他不是老师。）",
    "他也是中国人吗？",
    "不是。（我不是中国人。）",
    "不是",
    "也是",
    "都是",
    "先去",
    "先吃",
    "也是留学生",
    "都是老师",
    "都是朋友",
    "不好",
    "不难",
    "也买",
    "也要",
    "都去",
    "都吃",
]

EX11_PINYIN = [
    "Nǐ shì Zhōngguó rén ma?",
    "Shì. (Wǒ shì Zhōngguó rén.)",
    "Nǐ shì lǎoshī ma?",
    "Bú shì. Wǒ shì xuésheng.",
    "Tāmen dōu shì liúxuéshēng ma?",
    "Tāmen dōu shì liúxuéshēng.",
    "Tāmen dōu shì xuésheng.",
    "Tā yě shì liúxuéshēng.",
    "Tā yě shì liúxuéshēng.",
    "Tāmen dōu shì liúxuéshēng.",
    "Nǐ shì liúxuéshēng ma?",
    "Shì. (Wǒ shì liúxuéshēng.)",
    "Tā yě shì liúxuéshēng ma?",
    "Tā yě shì liúxuéshēng. Wǒmen dōu shì liúxuéshēng.",
    "Tā shì lǎoshī ma?",
    "Bú shì. (Tā bú shì lǎoshī.)",
    "Tā yě shì Zhōngguó rén ma?",
    "Bú shì. (Wǒ bú shì Zhōngguó rén.)",
    "Bú shì",
    "Yě shì",
    "Dōu shì",
    "Xiān qù",
    "Xiān chī",
    "Yě shì liúxuéshēng",
    "Dōu shì lǎoshī",
    "Dōu shì péngyou",
    "Bù hǎo",
    "Bù nán",
    "Yě mǎi",
    "Yě yào",
    "Dōu qù",
    "Dōu chī",
]

lesson_11 = {
    "id": "lesson_11",
    "number": 11,
    "sourceLessonNumbers": [11],
    "chineseTitle": "我们都是留学生",
    "chineseSubtitle": None,
    "pinyinTitle": "Wǒmen dōu shì liúxuéshēng",
    "translationTitle": tr(
        "Мы все — иностранные студенты",
        "We are all international students",
        "Todos somos estudiantes extranjeros",
        "Todos somos estudantes estrangeiros",
    ),
    "sections": [
        dialogue_section("dialogue_professor", "这位是王教授", D11_1, continue_title="Дальше", show_header=True),
        dialogue_section("dialogue_students", "我们都是留学生", D11_2),
        dialogue_section("dialogue_chinese", "你也是中国人吗", D11_3, continue_title="Изучить новые слова"),
        vocab_section("vocab_intro", tr("Знакомство", "Introduction", "Presentación", "Apresentação"), V11_INTRO),
        vocab_section("vocab_students", tr("Студенты", "Students", "Estudiantes", "Estudantes"), V11_STUDENTS),
        vocab_section("vocab_names", tr("Имена", "Names", "Nombres", "Nomes"), V11_NAMES),
        summary_groups([
            ("vocab_intro", tr("Знакомство", "Introduction", "Presentación", "Apresentação")),
            ("vocab_students", tr("Студенты", "Students", "Estudiantes", "Estudantes")),
            ("vocab_names", tr("Имена", "Names", "Nombres", "Nomes")),
        ]),
        repeat("这位是王教授", "dialogue_professor", "这位是王教授", D11_1),
        repeat("我们都是留学生", "dialogue_students", "我们都是留学生", D11_2),
        repeat("你也是中国人吗", "dialogue_chinese", "你也是中国人吗", D11_3),
        *tail([example(f"ex11_{i:02d}", h, p) for i, (h, p) in enumerate(zip(EX11_HANZI, EX11_PINYIN))]),
    ],
}

# ── Lesson 12 ──────────────────────────────────────────────────────────────

D12_1 = [
    line("A", "你在哪儿学习汉语？", "Nǐ zài nǎr xuéxí Hànyǔ?"),
    line("B", "在北京语言大学。", "Zài Běijīng Yǔyán Dàxué."),
    line("A", "你们的老师怎么样？", "Nǐmen de lǎoshī zěnmeyàng?"),
    line("B", "很好！", "Hěn hǎo!"),
    line("A", "你觉得学习汉语难吗？", "Nǐ juéde xuéxí Hànyǔ nán ma?"),
    line(
        "B",
        "我觉得语法不太难。听和说也比较容易，但是读和写很难。",
        "Wǒ juéde yǔfǎ bú tài nán. Tīng hé shuō yě bǐjiào róngyì, dànshì dú hé xiě hěn nán.",
    ),
]

D12_2 = [
    line("A", "我给你们介绍一下儿，这位是新同学，是我的同屋。", "Wǒ gěi nǐmen jièshao yíxiàr, zhè wèi shì xīn tóngxué, shì wǒ de tóngwū."),
    line("B", "你在哪个班学习？", "Nǐ zài nǎge bān xuéxí?"),
    line("C", "在103班。", "Zài yī líng sān bān."),
    line("B", "你们的老师是谁？", "Nǐmen de lǎoshī shì shéi?"),
    line("C", "我们的老师是林老师。", "Wǒmen de lǎoshī shì Lín lǎoshī."),
]

V12_MAIN = [
    vocab_item("yuyan", "语言", "yǔyán", "язык", "language", "idioma", "língua"),
    vocab_item("daxue", "大学", "dàxué", "университет", "university", "universidad", "universidade"),
    vocab_item("zenmeyang", "怎么样", "zěnmeyàng", "как", "how; how about", "cómo; qué tal", "como; que tal"),
    vocab_item("juede", "觉得", "juéde", "чувствовать; считать", "to feel; to think", "sentir; pensar", "sentir; achar"),
    vocab_item("yufa", "语法", "yǔfǎ", "грамматика", "grammar", "gramática", "gramática"),
    vocab_item("ting", "听", "tīng", "слушать", "to listen", "escuchar", "ouvir"),
    vocab_item("he", "和", "hé", "и", "and", "y", "e"),
    vocab_item("shuo", "说", "shuō", "говорить", "to speak", "hablar", "falar"),
    vocab_item("bijiao", "比较", "bǐjiào", "сравнительно; сравнивать", "relatively; to compare", "relativamente; comparar", "relativamente; comparar"),
    vocab_item("rongyi", "容易", "róngyì", "лёгкий", "easy", "fácil", "fácil"),
    vocab_item("du", "读", "dú", "читать", "to read", "leer", "ler"),
    vocab_item("xie", "写", "xiě", "писать", "to write", "escribir", "escrever"),
    vocab_item("danshi", "但是", "dànshì", "но", "but", "pero", "mas"),
    vocab_item("gei", "给", "gěi", "дать; для", "to give; for", "dar; para", "dar; para"),
    vocab_item("xin", "新", "xīn", "новый", "new", "nuevo", "novo"),
    vocab_item("tongxue", "同学", "tóngxué", "однокурсник", "classmate", "compañero de clase", "colega de classe"),
    vocab_item("tongwu", "同屋", "tóngwū", "сосед по комнате", "roommate", "compañero de cuarto", "colega de quarto"),
    vocab_item("ban", "班", "bān", "класс; группа", "class; group", "clase; grupo", "turma; grupo"),
]

V12_NAMES = [
    vocab_item("bjyyu", "北京语言大学", "Běijīng Yǔyán Dàxué", "Пекинский университет языка и культуры", "Beijing Language and Culture University", "Universidad de Lenguas y Cultura de Pekín", "Universidade de Línguas e Cultura de Pequim"),
    vocab_item("lin", "林", "Lín", "Линь", "Lin (surname)", "Lin (apellido)", "Lin (sobrenome)"),
]

EX12 = [
    ("什么名字", "Shénme míngzi"),
    ("什么老师", "Shénme lǎoshī"),
    ("吃什么", "Chī shénme"),
    ("喝什么", "Hē shénme"),
    ("身体怎么样", "Shēntǐ zěnmeyàng"),
    ("学习怎么样", "Xuéxí zěnmeyàng"),
    ("爸爸怎么样", "Bàba zěnmeyàng"),
    ("妈妈怎么样", "Māma zěnmeyàng"),
    ("谁的书", "Shéi de shū"),
    ("谁的老师", "Shéi de lǎoshī"),
    ("谁的词典", "Shéi de cídiǎn"),
    ("谁的英文杂志", "Shéi de Yīngwén zázhì"),
    ("谁的杯", "Shéi de bēi"),
    ("我的英文杂志", "Wǒ de Yīngwén zázhì"),
    ("学习什么", "Xuéxí shénme"),
    ("学习语言", "Xuéxí yǔyán"),
    ("学习英语", "Xuéxí Yīngyǔ"),
    ("在中国", "Zài Zhōngguó"),
    ("在北京", "Zài Běijīng"),
    ("在学校", "Zài xuéxiào"),
    ("在语言大学", "Zài yǔyán dàxué"),
    ("男同学", "Nán tóngxué"),
    ("女同学", "Nǚ tóngxué"),
    ("男老师", "Nán lǎoshī"),
    ("女老师", "Nǚ lǎoshī"),
    ("中文书", "Zhōngwén shū"),
    ("法文书", "Fǎwén shū"),
    ("日文杂志", "Rìwén zázhì"),
    ("韩文杂志", "Hánwén zázhì"),
    ("新同学", "Xīn tóngxué"),
    ("老同学", "Lǎo tóngxué"),
    ("新杂志", "Xīn zázhì"),
    ("旧杂志", "Jiù zázhì"),
    ("很多人", "Hěn duō rén"),
    ("很多同学", "Hěn duō tóngxué"),
    ("很多老师", "Hěn duō lǎoshī"),
    ("很多钱", "Hěn duō qián"),
    ("我妈妈", "Wǒ māma"),
    ("他哥哥", "Tā gēge"),
    ("你弟弟", "Nǐ dìdi"),
    ("我们学校", "Wǒmen xuéxiào"),
    ("你学习什么？", "Nǐ xuéxí shénme?"),
    ("我学习汉语。", "Wǒ xuéxí Hànyǔ."),
    ("你们的老师是谁？", "Nǐmen de lǎoshī shì shéi?"),
    ("我们的老师是王老师。", "Wǒmen de lǎoshī shì Wáng lǎoshī."),
    ("你在哪儿学习？", "Nǐ zài nǎr xuéxí?"),
    ("语言大学。", "Yǔyán dàxué."),
    ("她也在语言大学学习。", "Tā yě zài yǔyán dàxué xuéxí."),
    ("语言大学怎么样？", "Yǔyán dàxué zěnmeyàng?"),
    ("很好。", "Hěn hǎo."),
    ("你觉得学习汉语难吗？", "Nǐ juéde xuéxí Hànyǔ nán ma?"),
    ("我觉得不太难。", "Wǒ juéde bú tài nán."),
]

lesson_12 = {
    "id": "lesson_12",
    "number": 12,
    "sourceLessonNumbers": [12],
    "chineseTitle": "你在哪儿学习",
    "chineseSubtitle": None,
    "pinyinTitle": "Nǐ zài nǎr xuéxí",
    "translationTitle": tr(
        "Где ты учишься",
        "Where do you study",
        "¿Dónde estudias?",
        "Onde você estuda",
    ),
    "sections": [
        dialogue_section("dialogue_where_study", "你在哪儿学习汉语", D12_1, continue_title="Дальше", show_header=True),
        dialogue_section("dialogue_class", "你们的老师是谁", D12_2, continue_title="Изучить новые слова"),
        vocab_section("vocab_main", tr("Основные слова", "Core words", "Palabras principales", "Palavras principais"), V12_MAIN),
        vocab_section("vocab_names", tr("Имена", "Names", "Nombres", "Nomes"), V12_NAMES),
        summary_groups([
            ("vocab_main", tr("Основные слова", "Core words", "Palabras principales", "Palavras principais")),
            ("vocab_names", tr("Имена", "Names", "Nombres", "Nomes")),
        ]),
        repeat("你在哪儿学习汉语", "dialogue_where_study", "你在哪儿学习汉语", D12_1),
        repeat("你们的老师是谁", "dialogue_class", "你们的老师是谁", D12_2),
        *tail([example(f"ex12_{i:02d}", h, p) for i, (h, p) in enumerate(EX12)]),
    ],
}

# ── Lesson 13 ──────────────────────────────────────────────────────────────

D13_1 = [
    line("A", "你没有箱子吗？", "Nǐ méiyǒu xiāngzi ma?"),
    line("B", "有啊。我的在这儿呢。", "Yǒu a. Wǒ de zài zhèr ne."),
    line("A", "我的很重，你的重不重？", "Wǒ de hěn zhòng, nǐ de zhòng bu zhòng?"),
    line("B", "这个黑的很重，那个红的比较轻。", "Zhège hēi de hěn zhòng, nàge hóng de bǐjiào qīng."),
    line("A", "你的箱子很新，我的很旧。", "Nǐ de xiāngzi hěn xīn, wǒ de hěn jiù."),
    line("B", "那个新的，是朋友的。这个旧的是我的。", "Nàge xīn de, shì péngyou de. Zhège jiù de shì wǒ de."),
]

D13_2 = [
    line("A", "先生，这些黑的是什么东西？", "Xiānsheng, zhèxiē hēi de shì shénme dōngxi?"),
    line("B", "这是一些药。", "Zhè shì yìxiē yào."),
    line("A", "什么药？", "Shénme yào?"),
    line("B", "中药。", "Zhōngyào."),
    line("A", "这是不是药？", "Zhè shì bu shì yào?"),
    line("B", "这不是药，这是茶叶。", "Zhè bú shì yào, zhè shì cháyè."),
    line("A", "那个箱子里是什么？", "Nàge xiāngzi li shì shénme?"),
    line(
        "B",
        "都是日用品。有两件衣服、一把雨伞和一瓶香水，还有一本书、一本词典、两张光盘和三支笔。",
        "Dōu shì rìyòngpǐn. Yǒu liǎng jiàn yīfu, yì bǎ yǔsǎn hé yì píng xiāngshuǐ, hái yǒu yì běn shū, yì běn cídiǎn, liǎng zhāng guāngpán hé sān zhī bǐ.",
    ),
]

V13_MAIN = [
    vocab_item("meiyou", "没（有）", "méi (yǒu)", "нет", "not have; there isn't", "no tener; no hay", "não ter; não há"),
    vocab_item("xiangzi", "箱子", "xiāngzi", "ящик; чемодан; сундук", "box; suitcase; trunk", "caja; maleta; baúl", "caixa; mala; baú"),
    vocab_item("you", "有", "yǒu", "есть", "to have; there is", "tener; hay", "ter; há"),
    vocab_item("zheer", "这儿", "zhèr", "тут", "here", "aquí", "aqui"),
    vocab_item("zhong", "重", "zhòng", "тяжёлый", "heavy", "pesado", "pesado"),
    vocab_item("hei", "黑", "hēi", "чёрный", "black", "negro", "preto"),
    vocab_item("hong", "红", "hóng", "красный", "red", "rojo", "vermelho"),
    vocab_item("qing", "轻", "qīng", "лёгкий", "light (weight)", "ligero", "leve"),
    vocab_item("jiu", "旧", "jiù", "старый; прошлый", "old; used", "viejo; usado", "velho; usado"),
    vocab_item("yao", "药", "yào", "лекарство", "medicine; drug", "medicina", "remédio"),
    vocab_item("zhongyao", "中药", "zhōngyào", "китайское лекарство", "traditional Chinese medicine", "medicina tradicional china", "medicina tradicional chinesa"),
    vocab_item("xiyao", "西药", "xīyào", "лекарство западной медицины", "Western medicine", "medicina occidental", "medicina ocidental"),
    vocab_item("chaye", "茶叶", "cháyè", "чай", "tea leaves; tea", "té", "chá"),
    vocab_item("li", "里", "lǐ", "внутри", "inside", "dentro", "dentro"),
    vocab_item("riyongpin", "日用品", "rìyòngpǐn", "предметы обихода", "daily necessities", "artículos de uso diario", "artigos de uso diário"),
    vocab_item("jian", "件", "jiàn", "счётное слово для одежды", "classifier for clothing", "clasificador de ropa", "classificador de roupa"),
    vocab_item("yifu", "衣服", "yīfu", "одежда", "clothes", "ropa", "roupa"),
    vocab_item("ba", "把", "bǎ", "счётное слово для предметов с ручкой", "classifier for objects with a handle", "clasificador de objetos con mango", "classificador de objetos com cabo"),
    vocab_item("yusan", "雨伞", "yǔsǎn", "зонтик", "umbrella", "paraguas", "guarda-chuva"),
    vocab_item("yu", "雨", "yǔ", "дождь", "rain", "lluvia", "chuva"),
    vocab_item("ping", "瓶", "píng", "бутылка", "bottle", "botella", "garrafa"),
    vocab_item("xiangshui", "香水", "xiāngshuǐ", "духи", "perfume", "perfume", "perfume"),
    vocab_item("shui", "水", "shuǐ", "вода", "water", "agua", "água"),
    vocab_item("ben", "本", "běn", "счётное слово для книг", "classifier for books", "clasificador de libros", "classificador de livros"),
    vocab_item("cidian", "词典", "cídiǎn", "словарь", "dictionary", "diccionario", "dicionário"),
    vocab_item("zhang", "张", "zhāng", "счётное слово для листов/плоских предметов", "classifier for flat objects", "clasificador de objetos planos", "classificador de objetos planos"),
    vocab_item("guangpan", "光盘", "guāngpán", "диск", "CD; disc", "disco", "disco"),
    vocab_item("zhi", "支", "zhī", "счётное слово для ручек/карандашей", "classifier for pens", "clasificador de bolígrafos", "classificador de canetas"),
    vocab_item("bi", "笔", "bǐ", "ручка; карандаш", "pen; pencil", "bolígrafo; lápiz", "caneta; lápis"),
]

EX13 = [
    ("一件衣服", "Yí jiàn yīfu"),
    ("一张光盘", "Yì zhāng guāngpán"),
    ("一把雨伞", "Yì bǎ yǔsǎn"),
    ("一个本子", "Yí ge běnzi"),
    ("一瓶香水", "Yì píng xiāngshuǐ"),
    ("一支笔", "Yì zhī bǐ"),
    ("一本书", "Yì běn shū"),
    ("一本词典", "Yì běn cídiǎn"),
    ("谁的包", "Shéi de bāo"),
    ("谁的笔", "Shéi de bǐ"),
    ("谁的报纸", "Shéi de bàozhǐ"),
    ("谁的光盘", "Shéi de guāngpán"),
    ("谁的书", "Shéi de shū"),
    ("谁的地图", "Shéi de dìtú"),
    ("什么词典", "Shénme cídiǎn"),
    ("什么药", "Shénme yào"),
    ("我的", "Wǒ de"),
    ("他的", "Tā de"),
    ("老师的", "Lǎoshī de"),
    ("留学生的", "Liúxuéshēng de"),
    ("新的", "Xīn de"),
    ("旧的", "Jiù de"),
    ("黑的", "Hēi de"),
    ("红的", "Hóng de"),
    ("有没有", "Yǒu méiyǒu"),
    ("是不是", "Shì bu shì"),
    ("忙不忙", "Máng bu máng"),
    ("听不听", "Tīng bu tīng"),
    ("说不说", "Shuō bu shuō"),
    ("读不读", "Dú bu dú"),
    ("写不写", "Xiě bu xiě"),
    ("要不要", "Yào bu yào"),
    ("多少钱人民币", "Duōshao qián rénmínbì"),
    ("词典好不好", "Cídiǎn hǎo bu hǎo"),
    ("箱子重不重", "Xiāngzi zhòng bu zhòng"),
    ("汉字难不难", "Hànzì nán bu nán"),
    ("学习忙不忙", "Xuéxí máng bu máng"),
    ("学习不学习", "Xuéxí bu xuéxí"),
    ("欢迎不欢迎", "Huānyíng bu huānyíng"),
    ("工作不工作", "Gōngzuò bu gōngzuò"),
    ("这是什么？", "Zhè shì shénme?"),
    ("这是药。", "Zhè shì yào."),
    ("这是什么药？", "Zhè shì shénme yào?"),
    ("中药。（这是中药。）", "Zhōngyào. (Zhè shì zhōngyào.)"),
    ("你有没有箱子？", "Nǐ yǒu méiyǒu xiāngzi?"),
    ("有。", "Yǒu."),
    ("你的箱子重不重？", "Nǐ de xiāngzi zhòng bu zhòng?"),
    ("很重。", "Hěn zhòng."),
    ("这个箱子是谁的？", "Zhège xiāngzi shì shéi de?"),
    ("是我的。", "Shì wǒ de."),
    ("那个是不是你的？", "Nàge shì bu shì nǐ de?"),
    ("不是。", "Bú shì."),
    ("这些是不是药？", "Zhèxiē shì bu shì yào?"),
    ("不是。（这些不是药。）", "Bú shì. (Zhèxiē bú shì yào.)"),
    ("你去不去银行？", "Nǐ qù bu qù yínháng?"),
    ("去。", "Qù."),
    ("你买苹果不买？", "Nǐ mǎi píngguǒ bú mǎi?"),
    ("不买，我买橘子。", "Bú mǎi, wǒ mǎi júzi."),
]

lesson_13 = {
    "id": "lesson_13",
    "number": 13,
    "sourceLessonNumbers": [13],
    "chineseTitle": "这是不是中药",
    "chineseSubtitle": None,
    "pinyinTitle": "Zhè shì bu shì zhōngyào",
    "translationTitle": tr(
        "Это китайское лекарство или нет",
        "Is this traditional Chinese medicine",
        "¿Es esto medicina tradicional china?",
        "Isso é medicina tradicional chinesa",
    ),
    "sections": [
        dialogue_section("dialogue_suitcase", "这个黑箱子很重", D13_1, continue_title="Дальше", show_header=True),
        dialogue_section("dialogue_medicine", "这是不是中药", D13_2, continue_title="Изучить новые слова"),
        vocab_section("vocab_main", tr("Основные слова", "Core words", "Palabras principales", "Palavras principais"), V13_MAIN),
        summary_groups([
            ("vocab_main", tr("Основные слова", "Core words", "Palabras principales", "Palavras principais")),
        ]),
        repeat("这个黑箱子很重", "dialogue_suitcase", "这个黑箱子很重", D13_1),
        repeat("这是不是中药", "dialogue_medicine", "这是不是中药", D13_2),
        *tail([example(f"ex13_{i:02d}", h, p) for i, (h, p) in enumerate(EX13)]),
    ],
}

# ── Lesson 14 ──────────────────────────────────────────────────────────────

D14_1 = [
    line("关经理", "王老师，好久不见了。", "Wáng lǎoshī, hǎojiǔ bú jiàn le."),
    line("王老师", "啊！关经理，欢迎，欢迎！", "A! Guān jīnglǐ, huānyíng, huānyíng!"),
    line("关经理", "您身体好吗？", "Nín shēntǐ hǎo ma?"),
    line("王老师", "很好。您身体怎么样？", "Hěn hǎo. Nín shēntǐ zěnmeyàng?"),
    line("关经理", "马马虎虎。", "Mǎmǎhūhū."),
    line("王老师", "最近工作忙不忙？", "Zuìjìn gōngzuò máng bu máng?"),
    line("关经理", "不太忙，您呢？", "Bú tài máng, nín ne?"),
    line("王老师", "刚开学，有点儿忙。喝点儿什么？茶还是咖啡？", "Gāng kāi xué, yǒudiǎnr máng. Hē diǎnr shénme? Chá háishi kāfēi?"),
    line("关经理", "喝杯茶吧！", "Hē bēi chá ba!"),
]

D14_2 = [
    line("田芳", "我的车呢？", "Wǒ de chē ne?"),
    line("张东", "你的车是什么颜色的？", "Nǐ de chē shì shénme yánsè de?"),
    line("田芳", "蓝的。", "Lán de."),
    line("张东", "是新的还是旧的？", "Shì xīn de háishi jiù de?"),
    line("田芳", "新的。", "Xīn de."),
    line("张东", "那辆蓝的是不是你的？", "Nà liàng lán de shì bu shì nǐ de?"),
    line("田芳", "哪辆？", "Nǎ liàng?"),
    line("张东", "那辆。", "Nà liàng."),
    line("田芳", "不是……啊，我的车在那儿呢。", "Bú shì... A, wǒ de chē zài nàr ne."),
]

V14_MAIN = [
    vocab_item("jingli", "经理", "jīnglǐ", "директор", "manager", "gerente", "gerente"),
    vocab_item("haojiu", "好久", "hǎojiǔ", "долго", "long time", "mucho tiempo", "muito tempo"),
    vocab_item("a", "啊", "a", "модальная частица", "modal particle", "partícula modal", "partícula modal"),
    vocab_item("mamahuhu", "马马虎虎", "mǎmǎhūhū", "так себе; ещё ничего", "so-so; not bad", "más o menos", "mais ou menos"),
    vocab_item("zuijin", "最近", "zuìjìn", "в последнее время", "recently", "recientemente", "recentemente"),
    vocab_item("gang", "刚", "gāng", "только что", "just; just now", "acabar de", "acabar de"),
    vocab_item("kaixue", "开学", "kāi xué", "начало занятий; приступить к учёбе", "school starts; to start school", "inicio de clases", "início das aulas"),
    vocab_item("kai", "开", "kāi", "начинать", "to open; to start", "abrir; empezar", "abrir; começar"),
    vocab_item("youdianr", "有（一）点儿", "yǒu(yì)diǎnr", "немного", "a little; somewhat", "un poco", "um pouco"),
    vocab_item("dianr", "点儿", "diǎnr", "немного", "a bit", "un poco", "um pouco"),
    vocab_item("haishi", "还是", "háishi", "или", "or", "o", "ou"),
    vocab_item("kafei", "咖啡", "kāfēi", "кофе", "coffee", "café", "café"),
    vocab_item("bei", "杯", "bēi", "чашка", "cup; glass", "taza; vaso", "xícara; copo"),
    vocab_item("che", "车", "chē", "транспортное средство", "vehicle", "vehículo", "veículo"),
    vocab_item("zixingche", "自行车", "zìxíngchē", "велосипед", "bicycle", "bicicleta", "bicicleta"),
    vocab_item("qiche", "汽车", "qìchē", "автомобиль", "car; automobile", "automóvil", "automóvel"),
    vocab_item("motuoche", "摩托车", "mótuōchē", "мотоцикл", "motorcycle", "motocicleta", "motocicleta"),
    vocab_item("chuzuche", "出租车", "chūzūchē", "такси", "taxi", "taxi", "táxi"),
    vocab_item("yanse", "颜色", "yánsè", "цвет", "color", "color", "cor"),
    vocab_item("lan", "蓝", "lán", "синий", "blue", "azul", "azul"),
    vocab_item("liang", "辆", "liàng", "счётное слово для транспорта", "classifier for vehicles", "clasificador de vehículos", "classificador de veículos"),
]

V14_NAMES = [
    vocab_item("guan", "关", "Guān", "Гуань", "Guan (surname)", "Guan (apellido)", "Guan (sobrenome)"),
]

EX14 = [
    ("你的身体怎么样？", "Nǐ de shēntǐ zěnmeyàng?"),
    ("很好。（我身体很好。）", "Hěn hǎo. (Wǒ shēntǐ hěn hǎo.)"),
    ("忙不忙？", "Máng bu máng?"),
    ("很忙。（我很忙。）", "Hěn máng. (Wǒ hěn máng.)"),
    ("你的自行车是什么颜色的？", "Nǐ de zìxíngchē shì shénme yánsè de?"),
    ("蓝的。（我的自行车是蓝的。）", "Lán de. (Wǒ de zìxíngchē shì lán de.)"),
    ("你的车是新的还是旧的？", "Nǐ de chē shì xīn de háishi jiù de?"),
    ("新的。（我的车是新的。）", "Xīn de. (Wǒ de chē shì xīn de.)"),
    ("你喝茶还是咖啡？", "Nǐ hē chá háishi kāfēi?"),
    ("喝咖啡。", "Hē kāfēi."),
    ("有点儿大", "Yǒudiǎnr dà"),
    ("有点儿小", "Yǒudiǎnr xiǎo"),
    ("有点儿重", "Yǒudiǎnr zhòng"),
    ("有点儿轻", "Yǒudiǎnr qīng"),
    ("有点儿贵", "Yǒudiǎnr guì"),
    ("有点儿难", "Yǒudiǎnr nán"),
    ("有点儿多", "Yǒudiǎnr duō"),
    ("有点儿少", "Yǒudiǎnr shǎo"),
    ("去银行还是去邮局", "Qù yínháng háishi qù yóujú"),
    ("蓝自行车", "Lán zìxíngchē"),
    ("黑自行车", "Hēi zìxíngchē"),
    ("喝水", "Hē shuǐ"),
    ("喝啤酒", "Hē píjiǔ"),
    ("学习英语", "Xuéxí Yīngyǔ"),
    ("学习法语", "Xuéxí Fǎyǔ"),
    ("是学生", "Shì xuésheng"),
    ("是老师", "Shì lǎoshī"),
    ("新照相机", "Xīn zhàoxiàngjī"),
    ("旧照相机", "Jiù zhàoxiàngjī"),
]

lesson_14 = {
    "id": "lesson_14",
    "number": 14,
    "sourceLessonNumbers": [14],
    "chineseTitle": "你的车是新的还是旧的",
    "chineseSubtitle": None,
    "pinyinTitle": "Nǐ de chē shì xīn de háishi jiù de",
    "translationTitle": tr(
        "Твоя машина новая или старая",
        "Is your vehicle new or old",
        "¿Tu vehículo es nuevo o viejo?",
        "Seu veículo é novo ou velho",
    ),
    "sections": [
        dialogue_section("dialogue_health", "您身体好吗", D14_1, continue_title="Дальше", show_header=True),
        dialogue_section("dialogue_bike", "你的自行车是新的还是旧的", D14_2, continue_title="Изучить новые слова"),
        vocab_section("vocab_main", tr("Основные слова", "Core words", "Palabras principales", "Palavras principais"), V14_MAIN),
        vocab_section("vocab_names", tr("Имена", "Names", "Nombres", "Nomes"), V14_NAMES),
        summary_groups([
            ("vocab_main", tr("Основные слова", "Core words", "Palabras principales", "Palavras principais")),
            ("vocab_names", tr("Имена", "Names", "Nombres", "Nomes")),
        ]),
        repeat("您身体好吗", "dialogue_health", "您身体好吗", D14_1),
        repeat("你的自行车是新的还是旧的", "dialogue_bike", "你的自行车是新的还是旧的", D14_2),
        *tail([example(f"ex14_{i:02d}", h, p) for i, (h, p) in enumerate(EX14)]),
    ],
}


def audit_lesson(lesson: dict) -> dict:
    dialogues = []
    examples = []
    for sec in lesson["sections"]:
        k = sec["kind"]
        if k == "dialogue":
            dialogues.append(sec["dialogue"])
        elif k == "dialogueRepeat":
            dialogues.append(sec["dialogue"])
        elif k == "examples":
            examples = sec["items"]
    vocab = sum(
        len(sec["vocabulary"]["items"])
        for sec in lesson["sections"]
        if sec["kind"] == "vocabulary"
    )
    line_count = sum(len(d["lines"]) for d in dialogues)
    unique_dialogue_sections = sum(1 for sec in lesson["sections"] if sec["kind"] == "dialogue")
    return {
        "number": lesson["number"],
        "dialogue_sections": unique_dialogue_sections,
        "dialogue_line_count": line_count,
        "vocabulary": vocab,
        "examples": len(examples),
        "dialogue_hanzi": [ln["hanzi"] for d in dialogues for ln in d["lines"]],
        "example_hanzi": [e["hanzi"] for e in examples],
    }


def main() -> None:
    lessons = [lesson_11, lesson_12, lesson_13, lesson_14]
    for lesson in lessons:
        write_lesson(lesson)

    print("\n=== CONTENT AUDIT ===")
    for lesson in lessons:
        a = audit_lesson(lesson)
        print(f"\nLesson {a['number']}:")
        print(f"  Original dialogue sections: {a['dialogue_sections']}")
        print(f"  Original dialogue line count: {a['original_line_count']}")
        print(f"  Vocabulary count: {a['vocabulary']}")
        print(f"  Example count: {a['examples']}")
        print("  FULL DIALOGUE HANZI AUDIT:")
        for h in a["dialogue_hanzi"]:
            print(f"    {h}")
        print("  FULL EXAMPLES HANZI AUDIT:")
        for h in a["example_hanzi"]:
            print(f"    {h}")


if __name__ == "__main__":
    main()
