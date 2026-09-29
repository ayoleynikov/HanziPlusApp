#!/usr/bin/env python3
"""Merge Hanzi+ Path localization keys into Localizable.xcstrings."""

from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2] / "HanziPlus"  # app source folder
XCSTRINGS = ROOT / "Localizable.xcstrings"

LOCALES = ("en", "es", "pt-BR", "ru")

# key -> {locale: value}
STRINGS: dict[str, dict[str, str]] = {
    "path.card.title": {
        "en": "Hanzi+ Path",
        "es": "Hanzi+ Path",
        "pt-BR": "Hanzi+ Path",
        "ru": "Hanzi+ Path",
    },
    "path.card.subtitle": {
        "en": "Chinese from zero — step by step",
        "es": "Chino desde cero — paso a paso",
        "pt-BR": "Chinês do zero — passo a passo",
        "ru": "Китайский с нуля — шаг за шагом",
    },
    "path.card.detail": {
        "en": "Dialogues, new words, and real phrases from the full course.",
        "es": "Diálogos, palabras nuevas y frases reales del curso completo.",
        "pt-BR": "Diálogos, palavras novas e frases reais do curso completo.",
        "ru": "Диалоги, новые слова и живые фразы из полного курса обучения.",
    },
    "path.start_course": {
        "en": "Start course",
        "es": "Empezar curso",
        "pt-BR": "Iniciar curso",
        "ru": "Начать курс",
    },
    "path.continue_course": {
        "en": "Continue course",
        "es": "Continuar curso",
        "pt-BR": "Continuar curso",
        "ru": "Продолжить курс",
    },
    "path.about_course": {
        "en": "About the course",
        "es": "Sobre el curso",
        "pt-BR": "Sobre o curso",
        "ru": "О курсе",
    },
    "path.read_more": {
        "en": "Read more",
        "es": "Leer más",
        "pt-BR": "Saiba mais",
        "ru": "Подробнее",
    },
    "path.course_format_label": {
        "en": "Dialogues · words · quiz",
        "es": "Diálogos · palabras · prueba",
        "pt-BR": "Diálogos · palavras · teste",
        "ru": "Диалоги · слова · проверка",
    },
    "path.how_it_works.title": {
        "en": "How learning works",
        "es": "Cómo funciona el aprendizaje",
        "pt-BR": "Como funciona o aprendizado",
        "ru": "Как проходит обучение",
    },
    "path.how.step1.title": {
        "en": "1. Dialogue",
        "es": "1. Diálogo",
        "pt-BR": "1. Diálogo",
        "ru": "1. Диалог",
    },
    "path.how.step1.detail": {
        "en": "First you see the lesson dialogue with characters, pinyin, translation, and audio.",
        "es": "Primero ves el diálogo de la lección con caracteres, pinyin, traducción y audio.",
        "pt-BR": "Primeiro você vê o diálogo da lição com caracteres, pinyin, tradução e áudio.",
        "ru": "Сначала ты видишь оригинальный диалог урока с иероглифами, pinyin, переводом и аудио.",
    },
    "path.how.step2.title": {
        "en": "2. New words",
        "es": "2. Palabras nuevas",
        "pt-BR": "2. Palavras novas",
        "ru": "2. Новые слова",
    },
    "path.how.step2.detail": {
        "en": "Then you study all new words from the lesson one by one.",
        "es": "Luego estudias todas las palabras nuevas de la lección una por una.",
        "pt-BR": "Depois você estuda todas as palavras novas da lição, uma por uma.",
        "ru": "Затем последовательно изучаешь все новые слова урока.",
    },
    "path.how.step3.title": {
        "en": "3. Back to dialogue",
        "es": "3. Volver al diálogo",
        "pt-BR": "3. Voltar ao diálogo",
        "ru": "3. Возврат к диалогу",
    },
    "path.how.step3.detail": {
        "en": "After the words, read the same dialogue again and recognize what you learned.",
        "es": "Después de las palabras, vuelve a leer el mismo diálogo y reconoce lo aprendido.",
        "pt-BR": "Depois das palavras, leia o mesmo diálogo novamente e reconheça o que aprendeu.",
        "ru": "После слов снова читаешь тот же диалог и узнаёшь изученные слова.",
    },
    "path.how.step4.title": {
        "en": "4. Word check",
        "es": "4. Comprobación",
        "pt-BR": "4. Verificação",
        "ru": "4. Проверка слов",
    },
    "path.how.step4.detail": {
        "en": "At the end, take a short quiz on the lesson vocabulary.",
        "es": "Al final, haz una breve prueba del vocabulario de la lección.",
        "pt-BR": "No final, faça um teste rápido do vocabulário da lição.",
        "ru": "В конце проходишь проверку слов урока.",
    },
    "path.first_words": {
        "en": "First words",
        "es": "Primeras palabras",
        "pt-BR": "Primeiras palavras",
        "ru": "Первые слова",
    },
    "path.study_first_words": {
        "en": "Study first words",
        "es": "Estudiar primeras palabras",
        "pt-BR": "Estudar primeiras palavras",
        "ru": "Изучить первые слова",
    },
    "path.study_new_words": {
        "en": "Study new words",
        "es": "Estudiar palabras nuevas",
        "pt-BR": "Estudar palavras novas",
        "ru": "Изучить новые слова",
    },
    "path.continue_conversation": {
        "en": "Now let's continue the conversation.",
        "es": "Ahora sigamos la conversación.",
        "pt-BR": "Agora vamos continuar a conversa.",
        "ru": "Теперь продолжим разговор.",
    },
    "path.lesson_words": {
        "en": "Lesson words",
        "es": "Palabras de la lección",
        "pt-BR": "Palavras da lição",
        "ru": "Слова урока",
    },
    "path.lesson_phrases_title": {
        "en": "Phrases from the lesson",
        "es": "Frases de la lección",
        "pt-BR": "Frases da lição",
        "ru": "Фразы из урока",
    },
    "path.example_group.dialogue": {
        "en": "Dialogue",
        "es": "Diálogo",
        "pt-BR": "Diálogo",
        "ru": "Диалог",
    },
    "path.example_group.additional": {
        "en": "Extra phrases",
        "es": "Frases adicionales",
        "pt-BR": "Frases extras",
        "ru": "Дополнительные фразы",
    },
    "path.example_group.questions": {
        "en": "Questions",
        "es": "Preguntas",
        "pt-BR": "Perguntas",
        "ru": "Вопросы",
    },
    "path.example_group.compounds": {
        "en": "Useful compounds",
        "es": "Combinaciones útiles",
        "pt-BR": "Combinações úteis",
        "ru": "Полезные сочетания",
    },
    "path.example_group.reading": {
        "en": "Reading",
        "es": "Texto",
        "pt-BR": "Texto",
        "ru": "Текст",
    },
    "path.finish_phrases": {
        "en": "Finish",
        "es": "Terminar",
        "pt-BR": "Concluir",
        "ru": "Завершить",
    },
    "path.studied_dialogues": {
        "en": "Studied dialogues",
        "es": "Diálogos estudiados",
        "pt-BR": "Diálogos estudados",
        "ru": "Изученные диалоги",
    },
    "path.replay_dialogues": {
        "en": "Replay dialogues",
        "es": "Repetir diálogos",
        "pt-BR": "Repetir diálogos",
        "ru": "Повторить диалоги",
    },
    "path.course_in_development": {
        "en": "More lessons are on the way — the full course is still in development.",
        "es": "Próximamente habrá más lecciones: el curso completo aún está en desarrollo.",
        "pt-BR": "Mais lições estão a caminho — o curso completo ainda está em desenvolvimento.",
        "ru": "Скоро появятся новые уроки — полный курс ещё в разработке.",
    },
    "path.lesson_unavailable": {
        "en": "Lesson unavailable",
        "es": "Lección no disponible",
        "pt-BR": "Lição indisponível",
        "ru": "Урок недоступен",
    },
    "path.lessons_title": {
        "en": "Lessons",
        "es": "Lecciones",
        "pt-BR": "Lições",
        "ru": "Уроки",
    },
    "path.lesson_prefix": {
        "en": "Lesson",
        "es": "Lección",
        "pt-BR": "Lição",
        "ru": "Урок",
    },
    "path.all_words_learned": {
        "en": "All words studied",
        "es": "Todas las palabras estudiadas",
        "pt-BR": "Todas as palavras estudadas",
        "ru": "Все слова изучены",
    },
    "path.next": {
        "en": "Next",
        "es": "Siguiente",
        "pt-BR": "Próximo",
        "ru": "Дальше",
    },
    "path.back_to_dialogue": {
        "en": "Back to dialogue",
        "es": "Volver al diálogo",
        "pt-BR": "Voltar ao diálogo",
        "ru": "Вернуться к диалогу",
    },
    "path.read_dialogue_again": {
        "en": "Read the dialogue again",
        "es": "Lee el diálogo otra vez",
        "pt-BR": "Leia o diálogo novamente",
        "ru": "Прочитай диалог ещё раз",
    },
    "path.words_in_dialogue": {
        "en": "Words in this dialogue",
        "es": "Palabras en este diálogo",
        "pt-BR": "Palavras neste diálogo",
        "ru": "Слова в этом диалоге",
    },
    "path.other_lesson_words_note": {
        "en": "These words don't appear in the dialogues but are part of the lesson vocabulary and quiz.",
        "es": "Estas palabras no aparecen en los diálogos, pero forman parte del vocabulario y la prueba de la lección.",
        "pt-BR": "Essas palavras não aparecem nos diálogos, mas fazem parte do vocabulário e do teste da lição.",
        "ru": "Эти слова не встречаются в диалогах, но входят в словарь урока и проверку.",
    },
    "path.what_does_word_mean": {
        "en": "What does this word mean?",
        "es": "¿Qué significa esta palabra?",
        "pt-BR": "O que significa esta palavra?",
        "ru": "Что означает это слово?",
    },
    "path.lesson_complete": {
        "en": "Lesson complete",
        "es": "Lección completada",
        "pt-BR": "Lição concluída",
        "ru": "Урок завершён",
    },
    "path.next_lesson": {
        "en": "Next lesson",
        "es": "Siguiente lección",
        "pt-BR": "Próxima lição",
        "ru": "Следующий урок",
    },
    "path.retry_lesson": {
        "en": "Retry lesson",
        "es": "Repetir lección",
        "pt-BR": "Refazer lição",
        "ru": "Пройти заново",
    },
    "path.status.start": {
        "en": "Start",
        "es": "Empezar",
        "pt-BR": "Iniciar",
        "ru": "Начать",
    },
    "path.status.in_progress": {
        "en": "In progress",
        "es": "En curso",
        "pt-BR": "Em andamento",
        "ru": "В процессе",
    },
    "path.status.completed": {
        "en": "Completed",
        "es": "Completado",
        "pt-BR": "Concluído",
        "ru": "Завершён",
    },
    "path.status.coming_soon": {
        "en": "Coming soon",
        "es": "Próximamente",
        "pt-BR": "Em breve",
        "ru": "Скоро",
    },
    "path.status.requires_prior_lesson": {
        "en": "Complete the previous lesson",
        "es": "Completa la lección anterior",
        "pt-BR": "Conclua a lição anterior",
        "ru": "Пройди предыдущий урок",
    },
    "path.lesson_progress %lld %lld": {
        "en": "Lesson %lld of %lld",
        "es": "Lección %lld de %lld",
        "pt-BR": "Lição %lld de %lld",
        "ru": "Урок %lld из %lld",
    },
    "path.lesson_completed_title %lld": {
        "en": "Lesson %lld complete",
        "es": "Lección %lld completada",
        "pt-BR": "Lição %lld concluída",
        "ru": "Урок %lld завершён",
    },
    "path.new_words_label %lld": {
        "en": "%lld new words",
        "es": "%lld palabras nuevas",
        "pt-BR": "%lld palavras novas",
        "ru": "%lld новых слов",
    },
    "path.how_to_say_prompt": {
        "en": "How do you say “%@”?",
        "es": "¿Cómo se dice «%@»?",
        "pt-BR": "Como se diz “%@”?",
        "ru": "Как будет «%@»?",
    },
    "path.course_lessons_label %lld %lld": {
        "en": "%1$lld lessons · %2$lld available",
        "es": "%1$lld lecciones · %2$lld disponibles",
        "pt-BR": "%1$lld lições · %2$lld disponíveis",
        "ru": "%1$lld уроков · %2$lld доступно",
    },
    "path.course.subtitle": {
        "en": "Chinese from zero — step by step",
        "es": "Chino desde cero — paso a paso",
        "pt-BR": "Chinês do zero — passo a passo",
        "ru": "Китайский с нуля — шаг за шагом",
    },
    "path.course.summary": {
        "en": "Live dialogues, new words, and a quiz in every lesson. The course builds gradually: from greetings and simple phrases to everyday situations and more complex structures.",
        "es": "Diálogos reales, palabras nuevas y una prueba en cada lección. El curso avanza gradualmente: de saludos y frases simples a situaciones cotidianas y estructuras más complejas.",
        "pt-BR": "Diálogos reais, palavras novas e um teste em cada lição. O curso avança gradualmente: de cumprimentos e frases simples a situações do dia a dia e estruturas mais complexas.",
        "ru": "Живые диалоги, новые слова и проверка в каждом уроке. Курс выстроен по нарастающей: от приветствий и простых фраз к повседневным ситуациям и более сложным конструкциям.",
    },
    "path.course.description": {
        "en": "Hanzi+ Path is your route into Chinese from zero.\n\nYou start with simple dialogues and basic words, then gradually move to longer phrases, new structures, and everyday situations.\n\nIn each lesson:\n• a dialogue with characters, pinyin, and translation\n• studying new words\n• revisiting the dialogue with context\n• a knowledge check\n\nNew material appears only after you've mastered the previous lesson — so knowledge builds naturally without overload.",
        "es": "Hanzi+ Path es tu ruta al chino desde cero.\n\nEmpiezas con diálogos simples y palabras básicas, y luego pasas gradualmente a frases más largas, nuevas estructuras y situaciones cotidianas.\n\nEn cada lección:\n• un diálogo con caracteres, pinyin y traducción\n• estudio de palabras nuevas\n• volver al diálogo con contexto\n• comprobación de conocimientos\n\nEl material nuevo aparece solo después de dominar la lección anterior, para que el aprendizaje sea natural y sin sobrecarga.",
        "pt-BR": "Hanzi+ Path é sua rota para o chinês do zero.\n\nVocê começa com diálogos simples e palavras básicas e depois avança gradualmente para frases mais longas, novas estruturas e situações do dia a dia.\n\nEm cada lição:\n• um diálogo com caracteres, pinyin e tradução\n• estudo de palavras novas\n• retorno ao diálogo com contexto\n• verificação de conhecimento\n\nO material novo só aparece depois que você domina a lição anterior — assim o conhecimento se consolida de forma natural, sem sobrecarga.",
        "ru": "Hanzi+ Path — твой маршрут в китайский с нуля.\n\nТы начинаешь с простых диалогов и базовых слов, а затем постепенно переходишь к более длинным фразам, новым конструкциям и повседневным ситуациям.\n\nВ каждом уроке:\n• диалог с иероглифами, pinyin и переводом\n• изучение новых слов\n• повторный диалог с пониманием контекста\n• проверка знаний\n\nНовый материал появляется только после того, как ты освоил предыдущий — так знания закрепляются естественно и без перегруза.",
    },
    "path.continue_chapter": {
        "en": "Continue",
        "es": "Continuar",
        "pt-BR": "Continuar",
        "ru": "Продолжить",
    },
    "path.chapter.locked": {
        "en": "Locked",
        "es": "Bloqueado",
        "pt-BR": "Bloqueado",
        "ru": "Заблокирована",
    },
    "path.chapter.available": {
        "en": "Available",
        "es": "Disponible",
        "pt-BR": "Disponível",
        "ru": "Доступна",
    },
    "path.chapter.in_progress": {
        "en": "In progress",
        "es": "En curso",
        "pt-BR": "Em andamento",
        "ru": "Начата",
    },
    "path.chapter.completed": {
        "en": "Completed",
        "es": "Completado",
        "pt-BR": "Concluída",
        "ru": "Завершена",
    },
    "path.chapter.complete_title": {
        "en": "Chapter complete!",
        "es": "¡Capítulo completado!",
        "pt-BR": "Capítulo concluído!",
        "ru": "Глава завершена!",
    },
    "path.mistake_review.title": {
        "en": "Let's fix mistakes",
        "es": "Repasemos los errores",
        "pt-BR": "Vamos corrigir os erros",
        "ru": "Закрепим ошибки",
    },
    "path.mistake_review.remaining %lld": {
        "en": "%lld words left to review",
        "es": "Quedan %lld palabras por repasar",
        "pt-BR": "Faltam %lld palavras para revisar",
        "ru": "Осталось закрепить %lld слов",
    },
    "path.check_answer": {
        "en": "Check",
        "es": "Comprobar",
        "pt-BR": "Verificar",
        "ru": "Проверить",
    },
    "path.correct_answer": {
        "en": "Correct!",
        "es": "¡Correcto!",
        "pt-BR": "Correto!",
        "ru": "Верно!",
    },
    "path.sentence_builder.title": {
        "en": "Sentence Builder",
        "es": "Construye la frase",
        "pt-BR": "Monte a frase",
        "ru": "Собери предложение",
    },
    "path.fill_blank.title": {
        "en": "Fill in the Blank",
        "es": "Completa el espacio",
        "pt-BR": "Preencha o espaço",
        "ru": "Вставь слово",
    },
    "path.dialogue_order.title": {
        "en": "Dialogue Order",
        "es": "Orden del diálogo",
        "pt-BR": "Ordem do diálogo",
        "ru": "Порядок реплик",
    },
    "path.grammar.title": {
        "en": "Grammar",
        "es": "Gramática",
        "pt-BR": "Gramática",
        "ru": "Грамматика",
    },
    "path.tone_guide.title": {
        "en": "Tones",
        "es": "Tonos",
        "pt-BR": "Tons",
        "ru": "Тоны",
    },
    "path.back_to_chapters": {
        "en": "Chapters",
        "es": "Capítulos",
        "pt-BR": "Capítulos",
        "ru": "Главы",
    },
}


def make_entry(translations: dict[str, str]) -> dict:
    localizations = {}
    for locale in LOCALES:
        localizations[locale] = {
            "stringUnit": {
                "state": "translated",
                "value": translations[locale],
            }
        }
    return {
        "extractionState": "manual",
        "localizations": localizations,
    }


def main() -> None:
    catalog = json.loads(XCSTRINGS.read_text(encoding="utf-8"))
    strings = catalog.setdefault("strings", {})
    added = 0
    updated = 0
    for key, translations in STRINGS.items():
        if key in strings:
            updated += 1
        else:
            added += 1
        strings[key] = make_entry(translations)
    XCSTRINGS.write_text(
        json.dumps(catalog, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(f"Path localizations: {added} added, {updated} updated.")


if __name__ == "__main__":
    main()
