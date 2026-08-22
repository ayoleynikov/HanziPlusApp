#!/usr/bin/env python3
"""Add remaining UI localization keys and merge into Localizable.xcstrings."""
from __future__ import annotations

from merge_xcstrings import merge

# (en, ru, es, pt-BR)
T = tuple[str, str, str, str]


def q(en: str, ru: str, es: str, pt: str) -> dict[str, str]:
    return {"en": en, "ru": ru, "es": es, "pt-BR": pt}


def game_keys() -> dict[str, dict[str, str]]:
    games: dict[str, dict[str, T]] = {
        "matchPairs": {
            "description": (
                "Match Chinese words with their meanings in a fast-paced pairing game.",
                "Сопоставляйте китайские слова с переводами в быстрой игре на пары.",
                "Empareja palabras chinas con sus significados en un juego rápido.",
                "Combine palavras chinesas com seus significados em um jogo rápido.",
            ),
            "tagline": (
                "Connect words with meanings",
                "Связывайте слова со значениями",
                "Conecta palabras con significados",
                "Conecte palavras aos significados",
            ),
            "benefit.0": (
                "Build vocabulary recognition",
                "Развивайте узнавание слов",
                "Mejora el reconocimiento de vocabulario",
                "Desenvolva o reconhecimento de vocabulário",
            ),
            "benefit.1": (
                "Strengthen word-meaning links",
                "Укрепляйте связь слова и значения",
                "Refuerza el vínculo palabra-significado",
                "Fortaleça o vínculo palavra–significado",
            ),
            "benefit.2": (
                "Great for beginners",
                "Отлично для начинающих",
                "Ideal para principiantes",
                "Ótimo para iniciantes",
            ),
        },
        "speedChallenge": {
            "description": (
                "Answer as many questions as you can before time runs out.",
                "Ответьте на как можно больше вопросов, пока не истечёт время.",
                "Responde tantas preguntas como puedas antes de que se acabe el tiempo.",
                "Responda a quantas perguntas puder antes que o tempo acabe.",
            ),
            "tagline": (
                "Think fast, learn faster",
                "Думайте быстро — учитесь быстрее",
                "Piensa rápido, aprende más rápido",
                "Pense rápido, aprenda mais rápido",
            ),
            "benefit.0": (
                "Improve recall speed",
                "Ускоряйте вспоминание",
                "Mejora la velocidad de recuerdo",
                "Melhore a velocidade de lembrança",
            ),
            "benefit.1": (
                "Sharpen under pressure",
                "Тренируйтесь под давлением",
                "Afina tu mente bajo presión",
                "Afie o raciocínio sob pressão",
            ),
            "benefit.2": (
                "Boost daily XP",
                "Больше XP за день",
                "Gana más XP al día",
                "Ganhe mais XP por dia",
            ),
        },
        "sentenceBuilder": {
            "description": (
                "Drag words into the correct sentence order and learn natural Chinese grammar.",
                "Перетаскивайте слова в правильный порядок и учите естественную китайскую грамматику.",
                "Arrastra las palabras al orden correcto y aprende gramática china natural.",
                "Arraste as palavras para a ordem correta e aprenda gramática chinesa natural.",
            ),
            "tagline": (
                "Master sentence structure",
                "Освойте структуру предложений",
                "Domina la estructura de las oraciones",
                "Domine a estrutura das frases",
            ),
            "benefit.0": (
                "Learn grammar patterns",
                "Изучайте грамматические модели",
                "Aprende patrones gramaticales",
                "Aprenda padrões gramaticais",
            ),
            "benefit.1": (
                "Practice word order",
                "Практикуйте порядок слов",
                "Practica el orden de las palabras",
                "Pratique a ordem das palavras",
            ),
            "benefit.2": (
                "Build fluency",
                "Развивайте беглость",
                "Gana fluidez",
                "Desenvolva fluência",
            ),
        },
        "listeningQuiz": {
            "description": (
                "Hear a word spoken aloud and pick the correct Hanzi.",
                "Слушайте произнесённое слово и выберите правильный иероглиф.",
                "Escucha una palabra y elige el Hanzi correcto.",
                "Ouça uma palavra falada e escolha o Hanzi correto.",
            ),
            "tagline": (
                "Train your ear",
                "Тренируйте слух",
                "Entrena el oído",
                "Treine o ouvido",
            ),
            "benefit.0": (
                "Improve listening skills",
                "Улучшайте навыки аудирования",
                "Mejora la comprensión auditiva",
                "Melhore a compreensão auditiva",
            ),
            "benefit.1": (
                "Connect sound to script",
                "Связывайте звук с письмом",
                "Conecta el sonido con la escritura",
                "Conecte o som à escrita",
            ),
            "benefit.2": (
                "Prepare for real conversations",
                "Готовьтесь к живым разговорам",
                "Prepárate para conversaciones reales",
                "Prepare-se para conversas reais",
            ),
        },
        "hanziMemory": {
            "description": (
                "Flip cards and find matching pairs to strengthen character memory.",
                "Переворачивайте карточки и находите пары, чтобы укрепить память на иероглифы.",
                "Voltea cartas y encuentra pares para reforzar la memoria de caracteres.",
                "Vire cartas e encontre pares para reforçar a memória dos caracteres.",
            ),
            "tagline": (
                "Memory meets mastery",
                "Память встречает мастерство",
                "Memoria y dominio",
                "Memória encontra maestria",
            ),
            "benefit.0": (
                "Memorize characters visually",
                "Запоминайте иероглифы визуально",
                "Memoriza caracteres visualmente",
                "Memorize caracteres visualmente",
            ),
            "benefit.1": (
                "Reinforce pinyin and meaning",
                "Закрепляйте пиньинь и значение",
                "Refuerza pinyin y significado",
                "Reforce pinyin e significado",
            ),
            "benefit.2": (
                "Low-pressure practice",
                "Спокойная практика",
                "Práctica sin presión",
                "Prática sem pressão",
            ),
        },
        "findTheHanzi": {
            "description": (
                "Spot the correct character hidden in a grid of look-alikes.",
                "Найдите нужный иероглиф среди похожих в сетке.",
                "Encuentra el carácter correcto oculto entre similares.",
                "Encontre o caractere correto escondido entre parecidos.",
            ),
            "tagline": (
                "Spot the difference",
                "Найдите отличия",
                "Encuentra la diferencia",
                "Ache a diferença",
            ),
            "benefit.0": (
                "Train visual discrimination",
                "Тренируйте визуальное различение",
                "Entrena la discriminación visual",
                "Treine a discriminação visual",
            ),
            "benefit.1": (
                "Notice subtle stroke differences",
                "Замечайте тонкие различия черт",
                "Nota sutiles diferencias de trazos",
                "Note diferenças sutis de traços",
            ),
            "benefit.2": (
                "Build reading accuracy",
                "Повышайте точность чтения",
                "Mejora la precisión lectora",
                "Melhore a precisão na leitura",
            ),
        },
        "typingChallenge": {
            "description": (
                "Type the Hanzi for each meaning and lock in active recall.",
                "Вводите иероглифы по значению и закрепляйте активное вспоминание.",
                "Escribe el Hanzi de cada significado y refuerza el recuerdo activo.",
                "Digite o Hanzi de cada significado e fixe a lembrança ativa.",
            ),
            "tagline": (
                "Active recall training",
                "Тренировка активного вспоминания",
                "Entrenamiento de recuerdo activo",
                "Treino de lembrança ativa",
            ),
            "benefit.0": (
                "Strengthen production skills",
                "Укрепляйте навыки производства",
                "Refuerza la producción",
                "Fortaleça a produção",
            ),
            "benefit.1": (
                "Deepen character memory",
                "Углубляйте память на иероглифы",
                "Profundiza la memoria de caracteres",
                "Aprofunde a memória dos caracteres",
            ),
            "benefit.2": (
                "Challenge advanced learners",
                "Вызов для продвинутых",
                "Desafío para niveles avanzados",
                "Desafio para alunos avançados",
            ),
        },
        "dailyChallenge": {
            "description": (
                "A fresh mixed challenge every day with bonus rewards.",
                "Новое смешанное испытание каждый день с бонусными наградами.",
                "Un reto mixto nuevo cada día con recompensas extra.",
                "Um desafio misto novo todos os dias com recompensas extras.",
            ),
            "tagline": (
                "New goals every day",
                "Новые цели каждый день",
                "Nuevas metas cada día",
                "Novas metas todos os dias",
            ),
            "benefit.0": (
                "Stay consistent",
                "Сохраняйте регулярность",
                "Mantén la constancia",
                "Mantenha a constância",
            ),
            "benefit.1": (
                "Earn bonus XP",
                "Получайте бонусный XP",
                "Gana XP extra",
                "Ganhe XP bônus",
            ),
            "benefit.2": (
                "Build a daily habit",
                "Формируйте ежедневную привычку",
                "Crea un hábito diario",
                "Crie um hábito diário",
            ),
        },
        "smartReview": {
            "description": (
                "Focus on words you struggle with most, powered by your mistake history.",
                "Сосредоточьтесь на словах, в которых чаще ошибаетесь, по истории ошибок.",
                "Concéntrate en las palabras que más te cuestan, según tu historial de errores.",
                "Foque nas palavras que mais erram, com base no seu histórico de erros.",
            ),
            "tagline": (
                "Learn what you missed",
                "Учите то, что упустили",
                "Aprende lo que se te escapó",
                "Aprenda o que você perdeu",
            ),
            "benefit.0": (
                "Target weak words",
                "Цельтесь в слабые слова",
                "Apunta a palabras débiles",
                "Foque nas palavras fracas",
            ),
            "benefit.1": (
                "Adaptive practice",
                "Адаптивная практика",
                "Práctica adaptativa",
                "Prática adaptativa",
            ),
            "benefit.2": (
                "Close knowledge gaps",
                "Закрывайте пробелы в знаниях",
                "Cierra lagunas de conocimiento",
                "Feche lacunas de conhecimento",
            ),
        },
    }
    out: dict[str, dict[str, str]] = {}
    for kind, fields in games.items():
        for field, vals in fields.items():
            out[f"games.def.{kind}.{field}"] = q(*vals)
    return out


def collection_keys() -> dict[str, dict[str, str]]:
    data = {
        "vocabulary": (
            ("Vocabulary", "Словарь", "Vocabulario", "Vocabulário"),
            ("Build your word library", "Пополняйте словарный запас", "Amplía tu vocabulario", "Amplie seu vocabulário"),
        ),
        "memory": (
            ("Memory", "Память", "Memoria", "Memória"),
            ("Master characters visually", "Освойте иероглифы визуально", "Domina los caracteres visualmente", "Domine os caracteres visualmente"),
        ),
        "listening": (
            ("Listening", "Аудирование", "Audición", "Audição"),
            ("Train your ear", "Тренируйте слух", "Entrena el oído", "Treine o ouvido"),
        ),
        "speed": (
            ("Fast Challenge", "Скоростной вызов", "Reto rápido", "Desafio rápido"),
            ("Think fast, score big", "Думайте быстро — набирайте очки", "Piensa rápido y suma puntos", "Pense rápido e some pontos"),
        ),
        "writing": (
            ("Writing", "Письмо", "Escritura", "Escrita"),
            ("Active recall & typing", "Активное вспоминание и ввод", "Recuerdo activo y escritura", "Lembrança ativa e digitação"),
        ),
        "review": (
            ("Smart Review", "Умное повторение", "Repaso inteligente", "Revisão inteligente"),
            ("Focus on weak spots", "Фокус на слабых местах", "Enfócate en puntos débiles", "Foque nos pontos fracos"),
        ),
    }
    out: dict[str, dict[str, str]] = {}
    for key, (title, subtitle) in data.items():
        out[f"games.collection.{key}.title"] = q(*title)
        out[f"games.collection.{key}.subtitle"] = q(*subtitle)
    return out


def achievement_keys() -> dict[str, dict[str, str]]:
    items = {
        "first_game": (
            ("First Game", "Первая игра", "Primera partida", "Primeiro jogo"),
            ("Complete your first game.", "Завершите первую игру.", "Completa tu primera partida.", "Conclua seu primeiro jogo."),
        ),
        "100_correct": (
            ("100 Correct Answers", "100 правильных ответов", "100 respuestas correctas", "100 respostas corretas"),
            ("Answer 100 questions correctly.", "Ответьте правильно на 100 вопросов.", "Responde 100 preguntas correctamente.", "Responda 100 perguntas corretamente."),
        ),
        "7_day_streak": (
            ("7-Day Streak", "Серия 7 дней", "Racha de 7 días", "Sequência de 7 dias"),
            ("Complete daily challenges 7 days in a row.", "Выполняйте ежедневные испытания 7 дней подряд.", "Completa retos diarios 7 días seguidos.", "Conclua desafios diários por 7 dias seguidos."),
        ),
        "100_learned": (
            ("100 Learned Words", "100 выученных слов", "100 palabras aprendidas", "100 palavras aprendidas"),
            ("Mark 100 words as learned.", "Отметьте 100 слов как выученные.", "Marca 100 palabras como aprendidas.", "Marque 100 palavras como aprendidas."),
        ),
        "1000_xp": (
            ("1000 XP", "1000 XP", "1000 XP", "1000 XP"),
            ("Earn 1000 XP across all games.", "Наберите 1000 XP во всех играх.", "Gana 1000 XP en todos los juegos.", "Ganhe 1000 XP em todos os jogos."),
        ),
        "master_hsk1": (
            ("Master of HSK 1", "Мастер HSK 1", "Maestro de HSK 1", "Mestre de HSK 1"),
            ("Perfect score on an HSK 1 game.", "Идеальный результат в игре HSK 1.", "Puntuación perfecta en un juego de HSK 1.", "Pontuação perfeita em um jogo de HSK 1."),
        ),
        "perfect_listening": (
            ("Perfect Listening", "Идеальное аудирование", "Audición perfecta", "Audição perfeita"),
            ("100% accuracy in Listening Quiz.", "100% точности в викторине на слух.", "100% de precisión en Listening Quiz.", "100% de precisão no Listening Quiz."),
        ),
        "typing_expert": (
            ("Typing Expert", "Эксперт печати", "Experto en escritura", "Especialista em digitação"),
            ("90%+ accuracy in Typing Challenge.", "Точность 90%+ в Typing Challenge.", "90%+ de precisión en Typing Challenge.", "90%+ de precisão no Typing Challenge."),
        ),
        "memory_champion": (
            ("Memory Champion", "Чемпион памяти", "Campeón de memoria", "Campeão da memória"),
            ("85%+ accuracy in Hanzi Memory.", "Точность 85%+ в Hanzi Memory.", "85%+ de precisión en Hanzi Memory.", "85%+ de precisão no Hanzi Memory."),
        ),
        "journey_first_city": (
            ("First City", "Первый город", "Primera ciudad", "Primeira cidade"),
            ("Complete your first journey milestone.", "Завершите первую веху путешествия.", "Completa tu primer hito del viaje.", "Conclua seu primeiro marco da jornada."),
        ),
        "journey_complete": (
            ("China Explorer", "Исследователь Китая", "Explorador de China", "Explorador da China"),
            ("Complete the full HanziPlus journey.", "Пройдите всё путешествие HanziPlus.", "Completa todo el viaje de HanziPlus.", "Conclua toda a jornada HanziPlus."),
        ),
    }
    out: dict[str, dict[str, str]] = {}
    for aid, (title, desc) in items.items():
        out[f"achievement.{aid}.title"] = q(*title)
        out[f"achievement.{aid}.description"] = q(*desc)
    return out


def memory_mode_keys() -> dict[str, dict[str, str]]:
    return {
        "games.memory.mode.chineseEnglish": q(
            "Hanzi ↔ Meaning",
            "Иероглиф ↔ Значение",
            "Hanzi ↔ Significado",
            "Hanzi ↔ Significado",
        ),
        "games.memory.mode.chinesePinyin": q(
            "Hanzi ↔ Pinyin",
            "Иероглиф ↔ Пиньинь",
            "Hanzi ↔ Pinyin",
            "Hanzi ↔ Pinyin",
        ),
        "games.memory.mode.chineseAudio": q(
            "Hanzi ↔ Audio",
            "Иероглиф ↔ Аудио",
            "Hanzi ↔ Audio",
            "Hanzi ↔ Áudio",
        ),
        "games.memory.mode.englishChinese": q(
            "Meaning ↔ Hanzi",
            "Значение ↔ Иероглиф",
            "Significado ↔ Hanzi",
            "Significado ↔ Hanzi",
        ),
    }


def daily_task_keys() -> dict[str, dict[str, str]]:
    return {
        "games.daily.task.match": q(
            "5 Match Pairs",
            "5 пар на сопоставление",
            "5 pares a emparejar",
            "5 pares para combinar",
        ),
        "games.daily.task.speed": q(
            "10 Speed Questions",
            "10 вопросов на скорость",
            "10 preguntas de velocidad",
            "10 perguntas de velocidade",
        ),
        "games.daily.task.listening": q(
            "5 Listening Questions",
            "5 вопросов на слух",
            "5 preguntas de audición",
            "5 perguntas de audição",
        ),
        "games.daily.task.typing": q(
            "5 Typing Questions",
            "5 вопросов на ввод",
            "5 preguntas de escritura",
            "5 perguntas de digitação",
        ),
        "games.daily.tasks_title": q(
            "Today's Tasks",
            "Задания на сегодня",
            "Tareas de hoy",
            "Tarefas de hoje",
        ),
        "games.daily.start_task": q(
            "Start: %@",
            "Начать: %@",
            "Empezar: %@",
            "Começar: %@",
        ),
        "games.daily.claim_rewards": q(
            "Claim Rewards",
            "Забрать награды",
            "Reclamar recompensas",
            "Resgatar recompensas",
        ),
        "games.daily.all_done": q(
            "All tasks completed today!",
            "Все задания на сегодня выполнены!",
            "¡Todas las tareas de hoy completadas!",
            "Todas as tarefas de hoje concluídas!",
        ),
        "games.daily.recommended": q(
            "Recommended Today",
            "Рекомендуем сегодня",
            "Recomendado hoy",
            "Recomendado hoje",
        ),
        "games.detail.benefits": q("Benefits", "Преимущества", "Beneficios", "Benefícios"),
        "games.detail.achievements": q("Achievements", "Достижения", "Logros", "Conquistas"),
        "games.detail.mode_selection": q(
            "Mode Selection", "Выбор режима", "Selección de modo", "Seleção de modo"
        ),
        "games.detail.difficulty_selection": q(
            "Difficulty Selection",
            "Выбор сложности",
            "Selección de dificultad",
            "Seleção de dificuldade",
        ),
        "games.detail.your_statistics": q(
            "Your Statistics", "Ваша статистика", "Tus estadísticas", "Suas estatísticas"
        ),
        "games.detail.est_time": q("Est. Time", "Время", "Tiempo est.", "Tempo est."),
        "games.detail.xp_reward": q("XP Reward", "Награда XP", "Recompensa XP", "Recompensa XP"),
        "games.detail.best_score": q("Best Score", "Лучший счёт", "Mejor puntuación", "Melhor pontuação"),
        "games.stat.played": q("Played", "Сыграно", "Jugadas", "Jogados"),
        "games.stat.accuracy": q("Accuracy", "Точность", "Precisión", "Precisão"),
        "games.stat.best_streak": q("Best Streak", "Лучшая серия", "Mejor racha", "Melhor sequência"),
        "games.stat.total_xp": q("Total XP", "Всего XP", "XP total", "XP total"),
        "games.hub.player_stats": q("Player Stats", "Статистика игрока", "Estadísticas", "Estatísticas"),
        "games.hub.todays_xp": q("Today's XP", "XP сегодня", "XP de hoy", "XP de hoje"),
        "games.hub.weekly_xp": q("Weekly XP", "XP за неделю", "XP semanal", "XP da semana"),
        "games.hub.current_streak": q(
            "Current Streak", "Текущая серия", "Racha actual", "Sequência atual"
        ),
        "games.hub.games_played": q("Games Played", "Игр сыграно", "Partidas jugadas", "Jogos jogados"),
        "games.hub.reward": q("Reward", "Награда", "Recompensa", "Recompensa"),
        "games.hub.total_sessions": q(
            "Total Sessions", "Всего сессий", "Sesiones totales", "Total de sessões"
        ),
        "games.locked.message": q(
            "This game is locked.",
            "Эта игра заблокирована.",
            "Este juego está bloqueado.",
            "Este jogo está bloqueado.",
        ),
        "games.memory.pairs_found": q("Pairs Found", "Найдено пар", "Pares encontrados", "Pares encontrados"),
        "games.memory.moves": q("Moves", "Ходы", "Movimientos", "Movimentos"),
        "games.sentence.empty": q(
            "This study set doesn't have enough example sentences yet.",
            "В этом наборе пока недостаточно примеров предложений.",
            "Este conjunto aún no tiene suficientes oraciones de ejemplo.",
            "Este conjunto ainda não tem frases de exemplo suficientes.",
        ),
        "games.sentence.correct": q("Correct!", "Верно!", "¡Correcto!", "Correto!"),
        "games.sentence.not_quite": q("Not quite", "Почти", "Casi", "Quase"),
        "games.review.todays": q("Today's Review", "Повторение сегодня", "Repaso de hoy", "Revisão de hoje"),
        "games.review.completion": q(
            "Completion %lld%%",
            "Готово %lld%%",
            "Completado %lld%%",
            "Conclusão %lld%%",
        ),
        "games.mode.pick_hint": q(
            "Pick how you want to match cards, then choose a study set.",
            "Выберите, как сопоставлять карточки, затем набор для учёбы.",
            "Elige cómo emparejar las cartas y luego un conjunto de estudio.",
            "Escolha como combinar as cartas e depois um conjunto de estudo.",
        ),
        "games.perfect_scores.title": q(
            "Perfect Scores", "Идеальные результаты", "Puntuaciones perfectas", "Pontuações perfeitas"
        ),
        "games.perfect_scores.empty": q(
            "Finish a game with 100% accuracy to earn a perfect score.",
            "Завершите игру со 100% точностью, чтобы получить идеальный результат.",
            "Termina un juego con 100% de precisión para lograr una puntuación perfecta.",
            "Conclua um jogo com 100% de precisão para ganhar uma pontuação perfeita.",
        ),
    }


def quiz_extra_keys() -> dict[str, dict[str, str]]:
    return {
        "quiz.correct_count": q(
            "Correct: %lld", "Верно: %lld", "Correctas: %lld", "Corretas: %lld"
        ),
        "quiz.wrong_count": q("Wrong: %lld", "Неверно: %lld", "Incorrectas: %lld", "Erradas: %lld"),
        "quiz.accuracy": q("Accuracy: %lld%%", "Точность: %lld%%", "Precisión: %lld%%", "Precisão: %lld%%"),
        "quiz.best_score": q(
            "Best Score: %lld%%",
            "Лучший результат: %lld%%",
            "Mejor puntuación: %lld%%",
            "Melhor pontuação: %lld%%",
        ),
        "quiz.new_record": q("New Record!", "Новый рекорд!", "¡Nuevo récord!", "Novo recorde!"),
        "quiz.final_score": q("Final Score", "Итоговый счёт", "Puntuación final", "Pontuação final"),
        "quiz.score_line": q(
            "Score: %lld ✓   %lld ✗",
            "Счёт: %lld ✓   %lld ✗",
            "Puntos: %lld ✓   %lld ✗",
            "Pontuação: %lld ✓   %lld ✗",
        ),
        "quiz.empty_words": q(
            "No words available",
            "Нет доступных слов",
            "No hay palabras disponibles",
            "Nenhuma palavra disponível",
        ),
    }


def lesson_extra_keys() -> dict[str, dict[str, str]]:
    # Plural-aware sentence is handled via String Catalog variations separately after merge.
    return {
        "lesson.summary.worked_through": q(
            "You worked through %@ today.",
            "Сегодня вы прошли %@.",
            "Hoy practicaste %@.",
            "Hoje você praticou %@.",
        ),
        "a11y.chinese_character": q(
            "Chinese character %@",
            "Китайский иероглиф %@",
            "Carácter chino %@",
            "Caractere chinês %@",
        ),
        "a11y.pinyin": q("Pinyin %@", "Пиньинь %@", "Pinyin %@", "Pinyin %@"),
    }


def misc_keys() -> dict[str, dict[str, str]]:
    return {
        "learn.header.brand": q("Hanzi+", "Hanzi+", "Hanzi+", "Hanzi+"),
        "catalog.learned_fraction": q(
            "%lld / %lld learned",
            "%lld / %lld выучено",
            "%lld / %lld aprendidas",
            "%lld / %lld aprendidas",
        ),
        "study.card_of": q(
            "Card %lld of %lld",
            "Карточка %lld из %lld",
            "Tarjeta %lld de %lld",
            "Cartão %lld de %lld",
        ),
        "study.complete.subtitle_set": q(
            "You have completed %@.",
            "Вы завершили %@.",
            "Has completado %@.",
            "Você concluiu %@.",
        ),
        "study.complete.subtitle_section": q(
            "You have completed %@ in %@.",
            "Вы завершили %@ в наборе %@.",
            "Has completado %@ en %@.",
            "Você concluiu %@ em %@.",
        ),
        "study.complete.words_learned": q(
            "%lld / %lld words learned.",
            "%lld / %lld слов выучено.",
            "%lld / %lld palabras aprendidas.",
            "%lld / %lld palavras aprendidas.",
        ),
        "search.results_count": q(
            "%lld Results",
            "%lld результатов",
            "%lld resultados",
            "%lld resultados",
        ),
        "travel.a11y.see_all": q(
            "See all %@",
            "Смотреть все: %@",
            "Ver todo: %@",
            "Ver tudo: %@",
        ),
        "travel.detail.copy_chinese": q(
            "Copy Chinese",
            "Скопировать китайский",
            "Copiar chino",
            "Copiar chinês",
        ),
        "games.complete.accuracy": q("Accuracy", "Точность", "Precisión", "Precisão"),
        "journey.info.population": q("Population", "Население", "Población", "População"),
        "journey.info.province": q("Province", "Провинция", "Provincia", "Província"),
        "journey.info.famous_for": q("Famous For", "Известно", "Famoso por", "Famoso por"),
        "journey.info.best_season": q(
            "Best Season", "Лучший сезон", "Mejor temporada", "Melhor estação"
        ),
        "journey.info.local_food": q(
            "Local Food", "Местная еда", "Comida local", "Comida local"
        ),
        "journey.section.facts_title": q(
            "Interesting Facts",
            "Интересные факты",
            "Datos interesantes",
            "Fatos interessantes",
        ),
        "journey.section.must_visit_title": q(
            "Must Visit", "Стоит увидеть", "Imprescindible", "Imperdível"
        ),
        "journey.section.vocab_title": q(
            "City Vocabulary",
            "Словарь города",
            "Vocabulario de la ciudad",
            "Vocabulário da cidade",
        ),
        "journey.section.mini_activity_title": q(
            "Mini Activity", "Мини-активность", "Miniactividad", "Miniatividade"
        ),
        "journey.complete.title": q(
            "China Journey Complete!",
            "Путешествие по Китаю завершено!",
            "¡Viaje por China completado!",
            "Jornada pela China concluída!",
        ),
        "journey.complete.subtitle": q(
            "You've collected every travel collectible. You're a true explorer!",
            "Вы собрали все сувениры путешествия. Вы настоящий исследователь!",
            "Has coleccionado todos los objetos de viaje. ¡Eres un verdadero explorador!",
            "Você coletou todos os itens de viagem. Você é um verdadeiro explorador!",
        ),
        "journey.locked.keep_learning": q(
            "Keep learning to unlock your next destination.",
            "Продолжайте учиться, чтобы открыть следующий город.",
            "Sigue aprendiendo para desbloquear tu próximo destino.",
            "Continue aprendendo para desbloquear o próximo destino.",
        ),
        "journey.locked.complete_previous": q(
            "Complete the previous city to continue your journey.",
            "Завершите предыдущий город, чтобы продолжить путь.",
            "Completa la ciudad anterior para continuar el viaje.",
            "Conclua a cidade anterior para continuar a jornada.",
        ),
        "journey.locked.unlock_city": q(
            "Complete requirements to unlock %@.",
            "Выполните требования, чтобы открыть %@.",
            "Cumple los requisitos para desbloquear %@.",
            "Cumpra os requisitos para desbloquear %@.",
        ),
        "journey.detail.chapter_progress": q(
            "Chapter Progress",
            "Прогресс главы",
            "Progreso del capítulo",
            "Progresso do capítulo",
        ),
        "journey.detail.city_badge": q(
            "City Badge", "Значок города", "Insignia de ciudad", "Emblema da cidade"
        ),
        "journey.detail.souvenir": q("Souvenir", "Сувенир", "Recuerdo", "Souvenir"),
        "journey.detail.collected_on": q(
            "Collected %@",
            "Собрано %@",
            "Coleccionado %@",
            "Coletado %@",
        ),
        "journey.detail.complete_to_collect": q(
            "Complete this chapter to collect",
            "Завершите главу, чтобы получить",
            "Completa este capítulo para coleccionar",
            "Conclua este capítulo para coletar",
        ),
        "journey.detail.unlock_requirements": q(
            "Unlock Requirements",
            "Требования для открытия",
            "Requisitos de desbloqueo",
            "Requisitos de desbloqueio",
        ),
        "journey.map.destination_locked": q(
            "Destination locked",
            "Направление закрыто",
            "Destino bloqueado",
            "Destino bloqueado",
        ),
        "journey.celebration.collectible": q(
            "Travel collectible unlocked: %@",
            "Открыт сувенир путешествия: %@",
            "Coleccionable de viaje desbloqueado: %@",
            "Colecionável de viagem desbloqueado: %@",
        ),
        "journey.celebration.explore": q(
            "Explore %@",
            "Исследовать %@",
            "Explorar %@",
            "Explorar %@",
        ),
        "journey.celebration.continue": q(
            "Continue Journey",
            "Продолжить путь",
            "Continuar el viaje",
            "Continuar a jornada",
        ),
        "journey.mini.great_find": q(
            "Great find!", "Отличная находка!", "¡Gran hallazgo!", "Ótima descoberta!"
        ),
        "journey.passport.not_discovered": q(
            "Not discovered", "Ещё не открыто", "Sin descubrir", "Não descoberto"
        ),
        "journey.passport.collection_header": q(
            "TRAVEL COLLECTION",
            "КОЛЛЕКЦИЯ ПУТЕШЕСТВИЙ",
            "COLECCIÓN DE VIAJE",
            "COLEÇÃO DE VIAGEM",
        ),
        "journey.req.learn_words": q(
            "Learn %lld words",
            "Выучить %lld слов",
            "Aprender %lld palabras",
            "Aprender %lld palavras",
        ),
        "journey.req.earn_xp": q("Earn XP", "Заработать XP", "Ganar XP", "Ganhar XP"),
        "journey.req.play_games": q(
            "Play Games", "Играть", "Jugar", "Jogar"
        ),
        "journey.req.accuracy": q(
            "Reach %lld%% accuracy",
            "Достичь точности %lld%%",
            "Alcanzar %lld%% de precisión",
            "Atingir %lld%% de precisão",
        ),
        "journey.req.hsk1": q(
            "Complete HSK 1", "Завершить HSK 1", "Completar HSK 1", "Concluir HSK 1"
        ),
        "journey.req.hsk2": q(
            "Complete HSK 2", "Завершить HSK 2", "Completar HSK 2", "Concluir HSK 2"
        ),
        "settings.progress.perfect_score": q(
            "Perfect Score", "Идеальный результат", "Puntuación perfecta", "Pontuação perfeita"
        ),
        "common.player": q("Player", "Игрок", "Jugador", "Jogador"),
        "common.level_n": q("Level %lld", "Уровень %lld", "Nivel %lld", "Nível %lld"),
        "common.done_short": q("Done", "Готово", "Hecho", "Pronto"),
    }


def journey_city_keys() -> dict[str, dict[str, str]]:
    # Compact city prose for UI display. City names kept internationally recognizable.
    cities = {
        "beijing": {
            "name": ("Beijing", "Пекин", "Pekín", "Pequim"),
            "province": (
                "Beijing Municipality",
                "Город центрального подчинения Пекин",
                "Municipio de Pekín",
                "Municipalidade de Pequim",
            ),
            "population": ("21.5 million", "21,5 млн", "21,5 millones", "21,5 milhões"),
            "introduction": (
                "Welcome to Beijing — China's historic capital with more than 3,000 years of history.",
                "Добро пожаловать в Пекин — историческую столицу Китая с более чем 3000 лет истории.",
                "Bienvenido a Pekín: la capital histórica de China con más de 3000 años de historia.",
                "Bem-vindo a Pequim — a capital histórica da China com mais de 3.000 anos de história.",
            ),
            "famousFor": (
                "Imperial palaces, hutong alleys, and Peking opera",
                "Императорские дворцы, хутуны и пекинская опера",
                "Palacios imperiales, callejones hutong y ópera de Pekín",
                "Palácios imperiais, hutongs e ópera de Pequim",
            ),
            "bestSeason": (
                "September – October (crisp autumn skies)",
                "Сентябрь – октябрь (ясная осенняя погода)",
                "Septiembre – octubre (cielos otoñales claros)",
                "Setembro – outubro (céus de outono limpos)",
            ),
            "localFood": (
                "Peking Duck, jianbing, zhajiangmian",
                "Утка по-пекински, цзяньбин, чжацзянмянь",
                "Pato pekinés, jianbing, zhajiangmian",
                "Pato à pequinesa, jianbing, zhajiangmian",
            ),
            "souvenirName": ("Lantern", "Фонарь", "Linterna", "Lanterna"),
            "localAchievement": (
                "Capital Explorer",
                "Исследователь столицы",
                "Explorador de la capital",
                "Explorador da capital",
            ),
            "mini.title": (
                "Find the Great Wall",
                "Найдите Великую стену",
                "Encuentra la Gran Muralla",
                "Encontre a Grande Muralha",
            ),
            "mini.instruction": (
                "Tap the hidden Great Wall tile before time runs out!",
                "Нажмите скрытую плитку Великой стены, пока не истекло время!",
                "¡Toca la ficha oculta de la Gran Muralla antes de que se acabe el tiempo!",
                "Toque a peça escondida da Grande Muralha antes que o tempo acabe!",
            ),
        },
        "xian": {
            "name": ("Xi'an", "Сиань", "Xi'an", "Xi'an"),
            "province": ("Shaanxi", "Шэньси", "Shaanxi", "Shaanxi"),
            "population": ("13 million", "13 млн", "13 millones", "13 milhões"),
            "introduction": (
                "Step into Xi'an — ancient capital of thirteen dynasties and gateway to the Silk Road.",
                "Добро пожаловать в Сиань — древнюю столицу тринадцати династий и ворота Шёлкового пути.",
                "Entra en Xi'an: antigua capital de trece dinastías y puerta de la Ruta de la Seda.",
                "Entre em Xi'an — antiga capital de treze dinastias e porta da Rota da Seda.",
            ),
            "famousFor": (
                "Terracotta Warriors, city walls, and Muslim Quarter street food",
                "Терракотовая армия, городские стены и уличная еда Мусульманского квартала",
                "Guerreros de terracota, murallas y comida callejera del barrio musulmán",
                "Guerreiros de terracota, muralhas e comida de rua do bairro muçulmano",
            ),
            "bestSeason": (
                "March – May & September – November",
                "Март – май и сентябрь – ноябрь",
                "Marzo – mayo y septiembre – noviembre",
                "Março – maio e setembro – novembro",
            ),
            "localFood": (
                "Biang biang noodles, roujiamo, yangrou paomo",
                "Лапша бяньбянь, жоуцзямо, янжоу паомо",
                "Fideos biang biang, roujiamo, yangrou paomo",
                "Macarrão biang biang, roujiamo, yangrou paomo",
            ),
            "souvenirName": (
                "Terracotta Warrior",
                "Терракотовый воин",
                "Guerrero de terracota",
                "Guerreiro de terracota",
            ),
            "localAchievement": (
                "Silk Road Scholar",
                "Знаток Шёлкового пути",
                "Erudito de la Ruta de la Seda",
                "Erudito da Rota da Seda",
            ),
            "mini.title": (
                "Assemble a Warrior",
                "Соберите воина",
                "Arma un guerrero",
                "Monte um guerreiro",
            ),
            "mini.instruction": (
                "Match the Terracotta Warrior pieces in the correct order!",
                "Сложите части терракотового воина в правильном порядке!",
                "¡Empareja las piezas del guerrero de terracota en el orden correcto!",
                "Combine as peças do guerreiro de terracota na ordem correta!",
            ),
        },
        "chengdu": {
            "name": ("Chengdu", "Чэнду", "Chengdú", "Chengdu"),
            "province": ("Sichuan", "Сычуань", "Sichuan", "Sichuan"),
            "population": ("21 million", "21 млн", "21 millones", "21 milhões"),
            "introduction": (
                "Welcome to Chengdu — relaxed tea-house culture and homeland of the giant panda.",
                "Добро пожаловать в Чэнду — спокойную культуру чайных домов и родину большой панды.",
                "Bienvenido a Chengdú: cultura de casas de té y tierra del panda gigante.",
                "Bem-vindo a Chengdu — cultura descontraída das casas de chá e terra do panda-gigante.",
            ),
            "famousFor": (
                "Giant pandas, spicy hot pot, and laid-back lifestyle",
                "Большие панды, острый хого и неспешный образ жизни",
                "Pandas gigantes, hot pot picante y ritmo relajado",
                "Pandas-gigantes, hot pot picante e estilo de vida descontraído",
            ),
            "bestSeason": (
                "March – June & September – November",
                "Март – июнь и сентябрь – ноябрь",
                "Marzo – junio y septiembre – noviembre",
                "Março – junho e setembro – novembro",
            ),
            "localFood": (
                "Mapo tofu, hot pot, dan dan noodles",
                "Мапо доуфу, хого, лапша даньдань",
                "Mapo tofu, hot pot, fideos dan dan",
                "Mapo tofu, hot pot, macarrão dan dan",
            ),
            "souvenirName": ("Panda", "Панда", "Panda", "Panda"),
            "localAchievement": (
                "Panda Friend",
                "Друг панды",
                "Amigo del panda",
                "Amigo do panda",
            ),
            "mini.title": (
                "Find the Panda",
                "Найдите панду",
                "Encuentra al panda",
                "Encontre o panda",
            ),
            "mini.instruction": (
                "Spot the panda hiding among the bamboo!",
                "Найдите панду, спрятавшуюся в бамбуке!",
                "¡Encuentra al panda escondido entre el bambú!",
                "Ache o panda escondido no bambu!",
            ),
        },
        "guilin": {
            "name": ("Guilin", "Гуйлинь", "Guilin", "Guilin"),
            "province": ("Guangxi", "Гуанси", "Guangxi", "Guangxi"),
            "population": ("4.9 million", "4,9 млн", "4,9 millones", "4,9 milhões"),
            "introduction": (
                "Discover Guilin — misty karst peaks rising from the Li River like a painted scroll.",
                "Откройте Гуйлинь — туманные карстовые пики над рекой Ли, словно на свитке.",
                "Descubre Guilin: picos kársticos neblinosos sobre el río Li como un rollo pintado.",
                "Descubra Guilin — picos cársticos enevoados sobre o rio Li como um pergaminho pintado.",
            ),
            "famousFor": (
                "Karst mountains, Li River cruises, and rice terraces",
                "Карстовые горы, круизы по реке Ли и рисовые террасы",
                "Montañas kársticas, cruceros por el río Li y terrazas de arroz",
                "Montanhas cársticas, cruzeiros no rio Li e terraços de arroz",
            ),
            "bestSeason": (
                "April – October",
                "Апрель – октябрь",
                "Abril – octubre",
                "Abril – outubro",
            ),
            "localFood": (
                "Guilin rice noodles, beer fish, stuffed snails",
                "Рисовая лапша Гуйлиня, рыба в пиве, фаршированные улитки",
                "Fideos de arroz de Guilin, pescado a la cerveza, caracoles rellenos",
                "Macarrão de arroz de Guilin, peixe na cerveja, caracóis recheados",
            ),
            "souvenirName": ("Karst Peaks", "Карстовые пики", "Picos kársticos", "Picos cársticos"),
            "localAchievement": (
                "River Wanderer",
                "Странник реки",
                "Vagabundo del río",
                "Andarilho do rio",
            ),
            "mini.title": (
                "Paint the Landscape",
                "Нарисуйте пейзаж",
                "Pinta el paisaje",
                "Pinte a paisagem",
            ),
            "mini.instruction": (
                "Trace the karst peaks to complete the scroll!",
                "Обведите карстовые пики, чтобы завершить свиток!",
                "¡Traza los picos kársticos para completar el rollo!",
                "Trace os picos cársticos para completar o pergaminho!",
            ),
        },
        "shanghai": {
            "name": ("Shanghai", "Шанхай", "Shanghái", "Xangai"),
            "province": (
                "Shanghai Municipality",
                "Город центрального подчинения Шанхай",
                "Municipio de Shanghái",
                "Municipalidade de Xangai",
            ),
            "population": ("24.9 million", "24,9 млн", "24,9 millones", "24,9 milhões"),
            "introduction": (
                "Arrive in Shanghai — where Art Deco heritage meets one of the world's most futuristic skylines.",
                "Добро пожаловать в Шанхай — где наследие ар-деко встречается с одним из самых футуристичных горизонтов мира.",
                "Llega a Shanghái: el patrimonio art déco se une a uno de los rascacielos más futuristas del mundo.",
                "Chegue a Xangai — onde o legado art déco encontra um dos skylines mais futuristas do mundo.",
            ),
            "famousFor": (
                "The Bund, Pudong skyline, and maglev train",
                "Набережная Бунд, горизонт Пудуна и поезд на магнитной подушке",
                "El Bund, el skyline de Pudong y el tren maglev",
                "O Bund, o skyline de Pudong e o trem maglev",
            ),
            "bestSeason": (
                "March – May & September – November",
                "Март – май и сентябрь – ноябрь",
                "Marzo – mayo y septiembre – noviembre",
                "Março – maio e setembro – novembro",
            ),
            "localFood": (
                "Xiaolongbao, shengjianbao, hairy crab",
                "Сяолунбао, шэнцзяньбао, мохнатый краб",
                "Xiaolongbao, shengjianbao, cangrejo peludo",
                "Xiaolongbao, shengjianbao, caranguejo peludo",
            ),
            "souvenirName": ("Skyline", "Горизонт", "Skyline", "Skyline"),
            "localAchievement": (
                "Metro Master",
                "Мастер метро",
                "Maestro del metro",
                "Mestre do metrô",
            ),
            "mini.title": (
                "Skyline Puzzle",
                "Пазл горизонта",
                "Puzzle del skyline",
                "Quebra-cabeça do skyline",
            ),
            "mini.instruction": (
                "Arrange the buildings to complete the Shanghai skyline!",
                "Расставьте здания, чтобы собрать горизонт Шанхая!",
                "¡Ordena los edificios para completar el skyline de Shanghái!",
                "Organize os prédios para completar o skyline de Xangai!",
            ),
        },
        "hangzhou": {
            "name": ("Hangzhou", "Ханчжоу", "Hangzhou", "Hangzhou"),
            "province": ("Zhejiang", "Чжэцзян", "Zhejiang", "Zhejiang"),
            "population": ("12.3 million", "12,3 млн", "12,3 millones", "12,3 milhões"),
            "introduction": (
                "Explore Hangzhou — West Lake serenity and the birthplace of Longjing tea.",
                "Откройте Ханчжоу — спокойствие Западного озера и родину чая лунцзин.",
                "Explora Hangzhou: la serenidad del Lago del Oeste y la cuna del té Longjing.",
                "Explore Hangzhou — a serenidade do Lago Ocidental e o berço do chá Longjing.",
            ),
            "famousFor": (
                "West Lake, Longjing tea, and silk production",
                "Западное озеро, чай лунцзин и производство шёлка",
                "Lago del Oeste, té Longjing y producción de seda",
                "Lago Ocidental, chá Longjing e produção de seda",
            ),
            "bestSeason": (
                "March – May & September – October",
                "Март – май и сентябрь – октябрь",
                "Marzo – mayo y septiembre – octubre",
                "Março – maio e setembro – outubro",
            ),
            "localFood": (
                "West Lake fish, dongpo pork, Longjing shrimp",
                "Рыба Западного озера, свинина дунпо, креветки с лунцзин",
                "Pescado del Lago del Oeste, cerdo dongpo, gambas Longjing",
                "Peixe do Lago Ocidental, porco dongpo, camarão Longjing",
            ),
            "souvenirName": ("Longjing Tea", "Чай лунцзин", "Té Longjing", "Chá Longjing"),
            "localAchievement": (
                "West Lake Poet",
                "Поэт Западного озера",
                "Poeta del Lago del Oeste",
                "Poeta do Lago Ocidental",
            ),
            "mini.title": (
                "Steep the Tea",
                "Заварите чай",
                "Prepara el té",
                "Prepare o chá",
            ),
            "mini.instruction": (
                "Complete the tea ceremony steps in order!",
                "Выполните шаги чайной церемонии по порядку!",
                "¡Completa los pasos de la ceremonia del té en orden!",
                "Conclua os passos da cerimônia do chá na ordem!",
            ),
        },
        "suzhou": {
            "name": ("Suzhou", "Сучжоу", "Suzhou", "Suzhou"),
            "province": ("Jiangsu", "Цзянсу", "Jiangsu", "Jiangsu"),
            "population": ("12.7 million", "12,7 млн", "12,7 millones", "12,7 milhões"),
            "introduction": (
                "Enter Suzhou — the Venice of the East, where classical gardens whisper centuries of elegance.",
                "Добро пожаловать в Сучжоу — Венецию Востока, где классические сады хранят века изящества.",
                "Entra en Suzhou: la Venecia del Este, donde los jardines clásicos susurran siglos de elegancia.",
                "Entre em Suzhou — a Veneza do Oriente, onde jardins clássicos guardam séculos de elegância.",
            ),
            "famousFor": (
                "Classical gardens, canals, and silk embroidery",
                "Классические сады, каналы и шёлковая вышивка",
                "Jardines clásicos, canales y bordado de seda",
                "Jardins clássicos, canais e bordado de seda",
            ),
            "bestSeason": (
                "March – May & September – November",
                "Март – май и сентябрь – ноябрь",
                "Marzo – mayo y septiembre – noviembre",
                "Março – maio e setembro – novembro",
            ),
            "localFood": (
                "Squirrel mandarin fish, biluochun tea, sweet osmanthus cake",
                "Рыба «белка», чай билуочунь, сладкий пирог с османтусом",
                "Pez mandarín ardilla, té biluochun, pastel dulce de osmanthus",
                "Peixe mandarim esquilo, chá biluochun, bolo doce de osmanthus",
            ),
            "souvenirName": ("Silk Fan", "Шёлковый веер", "Abanico de seda", "Leque de seda"),
            "localAchievement": (
                "Garden Poet",
                "Поэт садов",
                "Poeta de los jardines",
                "Poeta dos jardins",
            ),
            "mini.title": (
                "Design a Garden",
                "Спроектируйте сад",
                "Diseña un jardín",
                "Projete um jardim",
            ),
            "mini.instruction": (
                "Place the pavilion, bridge, and pond to complete the garden!",
                "Расставьте павильон, мост и пруд, чтобы завершить сад!",
                "¡Coloca el pabellón, el puente y el estanque para completar el jardín!",
                "Coloque o pavilhão, a ponte e o lago para completar o jardim!",
            ),
        },
        "harbin": {
            "name": ("Harbin", "Харбин", "Harbin", "Harbin"),
            "province": ("Heilongjiang", "Хэйлунцзян", "Heilongjiang", "Heilongjiang"),
            "population": ("10 million", "10 млн", "10 millones", "10 milhões"),
            "introduction": (
                "Venture to Harbin — China's ice city, where winter magic transforms the landscape.",
                "Отправьтесь в Харбин — ледяной город Китая, где зима преображает пейзаж.",
                "Aventúrate en Harbin: la ciudad de hielo de China, donde el invierno transforma el paisaje.",
                "Aventure-se em Harbin — a cidade do gelo da China, onde o inverno transforma a paisagem.",
            ),
            "famousFor": (
                "Ice Festival, Russian architecture, and winter sports",
                "Ледовый фестиваль, русская архитектура и зимние виды спорта",
                "Festival del Hielo, arquitectura rusa y deportes de invierno",
                "Festival do Gelo, arquitetura russa e esportes de inverno",
            ),
            "bestSeason": (
                "December – February (Ice Festival)",
                "Декабрь – февраль (Ледовый фестиваль)",
                "Diciembre – febrero (Festival del Hielo)",
                "Dezembro – fevereiro (Festival do Gelo)",
            ),
            "localFood": (
                "Guo bao rou, Harbin sausage, frozen pear",
                "Гоубаожоу, харбинская колбаса, мороженая груша",
                "Guo bao rou, salchicha de Harbin, pera congelada",
                "Guo bao rou, linguiça de Harbin, pera congelada",
            ),
            "souvenirName": ("Ice Crystal", "Ледяной кристалл", "Cristal de hielo", "Cristal de gelo"),
            "localAchievement": (
                "Ice Explorer",
                "Исследователь льда",
                "Explorador del hielo",
                "Explorador do gelo",
            ),
            "mini.title": (
                "Carve the Ice",
                "Вырежьте изо льда",
                "Talla el hielo",
                "Esculpa o gelo",
            ),
            "mini.instruction": (
                "Tap to sculpt the ice block before it melts!",
                "Нажимайте, чтобы вырезать ледяной блок, пока он не растаял!",
                "¡Toca para esculpir el bloque de hielo antes de que se derrita!",
                "Toque para esculpir o bloco de gelo antes que derreta!",
            ),
        },
        "hongkong": {
            "name": ("Hong Kong", "Гонконг", "Hong Kong", "Hong Kong"),
            "province": (
                "Hong Kong SAR",
                "САР Гонконг",
                "RAE de Hong Kong",
                "RAE de Hong Kong",
            ),
            "population": ("7.5 million", "7,5 млн", "7,5 millones", "7,5 milhões"),
            "introduction": (
                "Reach Hong Kong — where East meets West on a glittering harbor of endless energy.",
                "Добро пожаловать в Гонконг — где Восток встречается с Западом у сверкающей гавани.",
                "Llega a Hong Kong: donde Oriente y Occidente se encuentran en un puerto brillante.",
                "Chegue a Hong Kong — onde Oriente e Ocidente se encontram em um porto brilhante.",
            ),
            "famousFor": (
                "Victoria Harbour, dim sum, and skyline views",
                "Гавань Виктория, димсам и виды на горизонт",
                "Puerto Victoria, dim sum y vistas del skyline",
                "Porto Victoria, dim sum e vistas do skyline",
            ),
            "bestSeason": (
                "October – December",
                "Октябрь – декабрь",
                "Octubre – diciembre",
                "Outubro – dezembro",
            ),
            "localFood": (
                "Dim sum, egg tarts, pineapple bun",
                "Димсам, яичные тарты, булочка с ананасом",
                "Dim sum, tartas de huevo, pan de piña",
                "Dim sum, tortinhas de ovo, pão de abacaxi",
            ),
            "souvenirName": ("Star Ferry", "Звёздный паром", "Star Ferry", "Star Ferry"),
            "localAchievement": (
                "Harbor Voyager",
                "Мореплаватель гавани",
                "Viajero del puerto",
                "Viajante do porto",
            ),
            "mini.title": (
                "Catch the Ferry",
                "Поймайте паром",
                "Atrapa el ferry",
                "Pegue a balsa",
            ),
            "mini.instruction": (
                "Guide the Star Ferry across Victoria Harbour!",
                "Проведите Star Ferry через гавань Виктория!",
                "¡Guía el Star Ferry a través del Puerto Victoria!",
                "Guie o Star Ferry pelo Porto Victoria!",
            ),
        },
    }
    out: dict[str, dict[str, str]] = {}
    for cid, fields in cities.items():
        for field, vals in fields.items():
            out[f"journey.city.{cid}.{field}"] = q(*vals)
    return out


def all_strings() -> dict[str, dict[str, str]]:
    merged: dict[str, dict[str, str]] = {}
    for part in (
        game_keys(),
        collection_keys(),
        achievement_keys(),
        memory_mode_keys(),
        daily_task_keys(),
        quiz_extra_keys(),
        lesson_extra_keys(),
        misc_keys(),
        journey_city_keys(),
    ):
        merged.update(part)
    return merged


if __name__ == "__main__":
    added = merge(all_strings())
    print(f"Merged {len(all_strings())} keys ({added} newly added)")
