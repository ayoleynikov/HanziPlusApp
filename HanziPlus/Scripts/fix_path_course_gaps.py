#!/usr/bin/env python3
"""Fill Path course gaps: TODO dialogue lines, summary group titles, lesson titles."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent
PATH_COURSE = ROOT / "Resources" / "PathCourse"
TRANSLATIONS_FILE = SCRIPT_DIR / "path_ru_translations.json"

TODO_RE = re.compile(r"^TODO:", re.I)

# Dialogue lines keyed by hanzi (lessons 3–5).
HANZI_TRANSLATIONS: dict[str, dict[str, str]] = {
    "你学俄语吗？": {
        "ru": "Ты учишь русский?",
        "en": "Do you study Russian?",
        "es": "¿Estudias ruso?",
        "pt-BR": "Você estuda russo?",
    },
    "不，学汉语。": {
        "ru": "Нет, учу китайский.",
        "en": "No, I study Chinese.",
        "es": "No, estudio chino.",
        "pt-BR": "Não, estudo chinês.",
    },
    "去北京吗？": {
        "ru": "Едешь в Пекин?",
        "en": "Are you going to Beijing?",
        "es": "¿Vas a Pekín?",
        "pt-BR": "Você vai para Pequim?",
    },
    "对。": {
        "ru": "Да.",
        "en": "Yes.",
        "es": "Sí.",
        "pt-BR": "Sim.",
    },
    "你去邮局寄信吗？": {
        "ru": "Ты идёшь на почту отправить письмо?",
        "en": "Are you going to the post office to mail a letter?",
        "es": "¿Vas a la oficina de correos a enviar una carta?",
        "pt-BR": "Você vai aos correios enviar uma carta?",
    },
    "不去。去银行取钱。": {
        "ru": "Нет. Иду в банк снять деньги.",
        "en": "No. I'm going to the bank to withdraw money.",
        "es": "No. Voy al banco a sacar dinero.",
        "pt-BR": "Não. Vou ao banco sacar dinheiro.",
    },
    "明天见！": {
        "ru": "До завтра!",
        "en": "See you tomorrow!",
        "es": "¡Hasta mañana!",
        "pt-BR": "Até amanhã!",
    },
    "今天星期几？": {
        "ru": "Какой сегодня день недели?",
        "en": "What day of the week is it today?",
        "es": "¿Qué día de la semana es hoy?",
        "pt-BR": "Que dia da semana é hoje?",
    },
    "今天星期二。": {
        "ru": "Сегодня вторник.",
        "en": "Today is Tuesday.",
        "es": "Hoy es martes.",
        "pt-BR": "Hoje é terça-feira.",
    },
    "你去哪儿？": {
        "ru": "Куда ты идёшь?",
        "en": "Where are you going?",
        "es": "¿A dónde vas?",
        "pt-BR": "Para onde você vai?",
    },
    "我去天安门，你去不去？": {
        "ru": "Я иду на Тяньаньмэнь, ты идёшь?",
        "en": "I'm going to Tiananmen. Are you coming?",
        "es": "Voy a Tiananmen. ¿Vienes?",
        "pt-BR": "Vou à Tiananmen. Você vem?",
    },
    "不去，我回学校。": {
        "ru": "Нет, я иду в школу.",
        "en": "No, I'm going back to school.",
        "es": "No, vuelvo a la escuela.",
        "pt-BR": "Não, volto para a escola.",
    },
    "再见！": {
        "ru": "До свидания!",
        "en": "Goodbye!",
        "es": "¡Adiós!",
        "pt-BR": "Tchau!",
    },
    "对不起！": {
        "ru": "Извините!",
        "en": "Sorry!",
        "es": "¡Perdón!",
        "pt-BR": "Desculpe!",
    },
    "没关系！": {
        "ru": "Ничего страшного!",
        "en": "It's okay!",
        "es": "¡No pasa nada!",
        "pt-BR": "Tudo bem!",
    },
    "这是王老师，这是我爸爸。": {
        "ru": "Это учитель Ван, это мой папа.",
        "en": "This is Teacher Wang. This is my dad.",
        "es": "Este es el profesor Wang. Este es mi papá.",
        "pt-BR": "Este é o professor Wang. Este é meu pai.",
    },
    "王老师，您好！": {
        "ru": "Здравствуйте, учитель Ван!",
        "en": "Hello, Teacher Wang!",
        "es": "¡Hola, profesor Wang!",
        "pt-BR": "Olá, professor Wang!",
    },
    "您好！请进！请坐！请喝茶！": {
        "ru": "Здравствуйте! Проходите! Садитесь! Пейте чай!",
        "en": "Hello! Come in! Sit down! Have some tea!",
        "es": "¡Hola! ¡Pase! ¡Siéntese! ¡Tome té!",
        "pt-BR": "Olá! Entre! Sente-se! Tome chá!",
    },
    "谢谢！": {
        "ru": "Спасибо!",
        "en": "Thank you!",
        "es": "¡Gracias!",
        "pt-BR": "Obrigado!",
    },
    "不客气！": {
        "ru": "Пожалуйста!",
        "en": "You're welcome!",
        "es": "¡De nada!",
        "pt-BR": "De nada!",
    },
    "工作忙吗？": {
        "ru": "Работа занимает много времени?",
        "en": "Are you busy with work?",
        "es": "¿Está ocupado con el trabajo?",
        "pt-BR": "Está ocupado com o trabalho?",
    },
    "不太忙。": {
        "ru": "Не очень.",
        "en": "Not too busy.",
        "es": "No mucho.",
        "pt-BR": "Não muito.",
    },
    "身体好吗？": {
        "ru": "Как здоровье?",
        "en": "How is your health?",
        "es": "¿Cómo está de salud?",
        "pt-BR": "Como está a saúde?",
    },
    "很好！": {
        "ru": "Очень хорошо!",
        "en": "Very good!",
        "es": "¡Muy bien!",
        "pt-BR": "Muito bem!",
    },
}

LESSON_TRANSLATION_TITLES: dict[int, dict[str, str]] = {
    3: {
        "ru": "До завтра",
        "en": "See you tomorrow",
        "es": "Hasta mañana",
        "pt-BR": "Até amanhã",
    },
    4: {
        "ru": "Куда ты идёшь?",
        "en": "Where are you going?",
        "es": "¿A dónde vas?",
        "pt-BR": "Para onde você vai?",
    },
    5: {
        "ru": "Это учитель Ван",
        "en": "This is Teacher Wang",
        "es": "Este es el profesor Wang",
        "pt-BR": "Este é o professor Wang",
    },
    6: {
        "ru": "Я учу китайский",
        "en": "I study Chinese",
        "es": "Estudio chino",
        "pt-BR": "Eu estudo chinês",
    },
    7: {
        "ru": "Что ты ешь?",
        "en": "What are you eating?",
        "es": "¿Qué comes?",
        "pt-BR": "O que você come?",
    },
    8: {
        "ru": "Сколько стоит цзинь яблок?",
        "en": "How much is a jin of apples?",
        "es": "¿Cuánto cuesta un jin de manzanas?",
        "pt-BR": "Quanto custa um jin de maçãs?",
    },
    9: {
        "ru": "Я меняю юани",
        "en": "I'm exchanging RMB",
        "es": "Cambio yuanes",
        "pt-BR": "Estou trocando yuan",
    },
    10: {
        "ru": "Где он живёт?",
        "en": "Where does he live?",
        "es": "¿Dónde vive?",
        "pt-BR": "Onde ele mora?",
    },
}


def load_translations() -> dict[str, dict[str, str]]:
    return json.loads(TRANSLATIONS_FILE.read_text(encoding="utf-8"))


def localize_string(ru: str, translations: dict[str, dict[str, str]]) -> dict[str, str]:
    entry = translations.get(ru)
    if entry is None:
        print(f"  WARNING: missing group title translation for {ru!r}", file=sys.stderr)
        return {"ru": ru, "en": ru, "es": ru, "pt-BR": ru}
    return {"ru": ru, "en": entry["en"], "es": entry["es"], "pt-BR": entry["pt-BR"]}


def is_plain_russian_title(value: object) -> bool:
    if not isinstance(value, str):
        return False
    stripped = value.strip()
    if not stripped:
        return False
    if TODO_RE.match(stripped):
        return False
    return True


def fix_todo_translations(node: object) -> int:
    changed = 0
    if isinstance(node, dict):
        translation = node.get("translation")
        hanzi = node.get("hanzi")
        if (
            isinstance(translation, str)
            and TODO_RE.match(translation.strip())
            and isinstance(hanzi, str)
            and hanzi in HANZI_TRANSLATIONS
        ):
            node["translation"] = HANZI_TRANSLATIONS[hanzi]
            changed += 1
        for value in node.values():
            changed += fix_todo_translations(value)
    elif isinstance(node, list):
        for item in node:
            changed += fix_todo_translations(item)
    return changed


def fix_summary_group_titles(node: object, translations: dict[str, dict[str, str]]) -> int:
    changed = 0
    if isinstance(node, dict):
        if node.get("kind") == "vocabularySummary":
            groups = node.get("groups")
            if isinstance(groups, list):
                for group in groups:
                    if not isinstance(group, dict):
                        continue
                    title = group.get("title")
                    if is_plain_russian_title(title):
                        group["title"] = localize_string(title, translations)
                        changed += 1
        for value in node.values():
            changed += fix_summary_group_titles(value, translations)
    elif isinstance(node, list):
        for item in node:
            changed += fix_summary_group_titles(item, translations)
    return changed


def apply_lesson_title(data: object) -> bool:
    if not isinstance(data, dict):
        return False
    number = data.get("number")
    if not isinstance(number, int) or number not in LESSON_TRANSLATION_TITLES:
        return False
    if data.get("translationTitle") is not None:
        return False
    data["translationTitle"] = LESSON_TRANSLATION_TITLES[number]
    return True


def write_json(path: Path, data: object) -> None:
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def main() -> None:
    translations = load_translations()
    todo_fixed = 0
    summary_fixed = 0
    titles_fixed = 0

    for path in sorted(PATH_COURSE.glob("lesson_*.json")):
        data = json.loads(path.read_text(encoding="utf-8"))
        t1 = fix_todo_translations(data)
        t2 = fix_summary_group_titles(data, translations)
        t3 = apply_lesson_title(data)
        if t1 or t2 or t3:
            write_json(path, data)
            print(f"{path.name}: {t1} TODO line(s), {t2} summary title(s)" + (", title added" if t3 else ""))
            todo_fixed += t1
            summary_fixed += t2
            if t3:
                titles_fixed += 1

    course_path = PATH_COURSE / "course.json"
    course = json.loads(course_path.read_text(encoding="utf-8"))
    course_titles = 0
    for lesson in course.get("lessons", []):
        if isinstance(lesson, dict) and apply_lesson_title(lesson):
            course_titles += 1
    if course_titles:
        write_json(course_path, course)
        print(f"course.json: {course_titles} lesson title(s)")

    print(
        f"\nDone: {todo_fixed} TODO translations, {summary_fixed} summary titles, "
        f"{titles_fixed + course_titles} lesson titles."
    )


if __name__ == "__main__":
    main()
