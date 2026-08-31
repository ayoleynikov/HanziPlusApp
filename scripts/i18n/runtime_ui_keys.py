#!/usr/bin/env python3
"""Fill runtime-extracted UI strings for every supported app language."""
from __future__ import annotations

import json

from merge_xcstrings import XCSTRINGS, merge


def q(en: str, ru: str, es: str, pt: str) -> dict[str, str]:
    return {"en": en, "ru": ru, "es": es, "pt-BR": pt}


TRANSLATIONS = {
    "%@, %lld phrases. %@": q("%@, %lld phrases. %@", "%@. Фраз: %lld. %@", "%@, %lld frases. %@", "%@, %lld frases. %@"),
    "%@. Locked. %@": q("%@. Locked. %@", "%@. Заблокировано. %@", "%@. Bloqueado. %@", "%@. Bloqueado. %@"),
    "%lld / %lld learned": q("%lld / %lld learned", "Выучено: %lld из %lld", "%lld de %lld aprendidas", "%lld de %lld aprendidas"),
    "%lld / 300 to next level": q("%lld / 300 to next level", "%lld из 300 до следующего уровня", "%lld de 300 para el siguiente nivel", "%lld de 300 para o próximo nível"),
    "%lld correct": q("%lld correct", "Правильно: %lld", "%lld correctas", "%lld corretas"),
    "%lld day streak": q("%lld day streak", "Серия: %lld дн.", "Racha de %lld días", "Sequência de %lld dias"),
    "%lld games": q("%lld games", "Игр: %lld", "%lld juegos", "%lld jogos"),
    "%lld items": q("%lld items", "Заданий: %lld", "%lld elementos", "%lld itens"),
    "%lld of %lld cities explored": q("%lld of %lld cities explored", "Исследовано городов: %lld из %lld", "%lld de %lld ciudades exploradas", "%lld de %lld cidades exploradas"),
    "%lld of %lld collectibles collected": q("%lld of %lld collectibles collected", "Собрано сувениров: %lld из %lld", "%lld de %lld objetos coleccionados", "%lld de %lld itens coletados"),
    "%lld percent": q("%lld percent", "%lld процентов", "%lld por ciento", "%lld por cento"),
    "%lld phrases": q("%lld phrases", "Фраз: %lld", "%lld frases", "%lld frases"),
    "%lld pts": q("%lld pts", "%lld очк.", "%lld ptos.", "%lld pts."),
    "%lld words": q("%lld words", "Слов: %lld", "%lld palabras", "%lld palavras"),
    "%lld words · %@": q("%lld words · %@", "%lld слов · %@", "%lld palabras · %@", "%lld palavras · %@"),
    "%lld words · %lld sections": q("%lld words · %lld sections", "%lld слов · %lld разделов", "%lld palabras · %lld secciones", "%lld palavras · %lld seções"),
    "%lld XP total": q("%lld XP total", "Всего %lld XP", "%lld XP en total", "%lld XP no total"),
    "%lld%% explored": q("%lld%% explored", "Исследовано: %lld%%", "%lld%% explorado", "%lld%% explorado"),
    "%llds": q("%llds", "%lld с", "%lld s", "%lld s"),
    "×%lld Combo": q("×%lld Combo", "Комбо ×%lld", "Combo ×%lld", "Combo ×%lld"),
    "~25 sec · +%lld XP": q("~25 sec · +%lld XP", "≈25 сек · +%lld XP", "≈25 s · +%lld XP", "≈25 s · +%lld XP"),
    "Achievements": q("Achievements", "Достижения", "Logros", "Conquistas"),
    "Add to favorites": q("Add to favorites", "Добавить в избранное", "Añadir a favoritos", "Adicionar aos favoritos"),
    "Answer locked": q("Answer locked", "Ответ зафиксирован", "Respuesta bloqueada", "Resposta bloqueada"),
    "By Game": q("By Game", "По играм", "Por juego", "Por jogo"),
    "Category unavailable": q("Category unavailable", "Категория недоступна", "Categoría no disponible", "Categoria indisponível"),
    "Chapter complete": q("Chapter complete", "Глава завершена", "Capítulo completado", "Capítulo concluído"),
    "Check": q("Check", "Проверить", "Comprobar", "Verificar"),
    "Check Sentence": q("Check Sentence", "Проверить предложение", "Comprobar frase", "Verificar frase"),
    "Chinese character %@": q("Chinese character %@", "Китайский иероглиф %@", "Carácter chino %@", "Caractere chinês %@"),
    "Complete": q("Complete", "Завершено", "Completado", "Concluído"),
    "Completed": q("Completed", "Выполнено", "Completado", "Concluído"),
    "Difficulty": q("Difficulty", "Сложность", "Dificultad", "Dificuldade"),
    "Double tap to choose": q("Double tap to choose", "Коснитесь дважды, чтобы выбрать", "Toca dos veces para elegir", "Toque duas vezes para escolher"),
    "Double tap to flip the flashcard": q("Double tap to flip the flashcard", "Коснитесь дважды, чтобы перевернуть карточку", "Toca dos veces para voltear la tarjeta", "Toque duas vezes para virar o cartão"),
    "Example %@%@": q("Example %@%@", "Пример %@%@", "Ejemplo %@%@", "Exemplo %@%@"),
    "Games Completed": q("Games Completed", "Завершено игр", "Juegos completados", "Jogos concluídos"),
    "I have a travel date": q("I have a travel date", "Я знаю дату поездки", "Tengo una fecha de viaje", "Tenho uma data de viagem"),
    "LVL": q("LVL", "УР.", "NV.", "NV."),
    "Learned ✓": q("Learned ✓", "Выучено ✓", "Aprendida ✓", "Aprendida ✓"),
    "Lesson progress": q("Lesson progress", "Прогресс урока", "Progreso de la lección", "Progresso da lição"),
    "Library": q("Library", "Библиотека", "Biblioteca", "Biblioteca"),
    "Listen": q("Listen", "Слушать", "Escuchar", "Ouvir"),
    "Mark as Learned": q("Mark as Learned", "Отметить как выученное", "Marcar como aprendida", "Marcar como aprendida"),
    "Next": q("Next", "Далее", "Siguiente", "Próximo"),
    "No combo": q("No combo", "Нет комбо", "Sin combo", "Sem combo"),
    "No Favorites": q("No Favorites", "Нет избранного", "Sin favoritos", "Sem favoritos"),
    "No Learned Words": q("No Learned Words", "Нет выученных слов", "No hay palabras aprendidas", "Nenhuma palavra aprendida"),
    "No Perfect Scores Yet": q("No Perfect Scores Yet", "Идеальных результатов пока нет", "Aún no hay puntuaciones perfectas", "Ainda não há pontuações perfeitas"),
    "No Sentences Available": q("No Sentences Available", "Нет доступных предложений", "No hay frases disponibles", "Não há frases disponíveis"),
    "No Souvenirs Yet": q("No Souvenirs Yet", "Сувениров пока нет", "Aún no hay recuerdos", "Ainda não há souvenirs"),
    "Onboarding progress": q("Onboarding progress", "Прогресс настройки", "Progreso de configuración", "Progresso da configuração"),
    "Opens phrase details": q("Opens phrase details", "Открывает подробности фразы", "Abre los detalles de la frase", "Abre os detalhes da frase"),
    "Phrase unavailable": q("Phrase unavailable", "Фраза недоступна", "Frase no disponible", "Frase indisponível"),
    "Pinyin %@": q("Pinyin %@", "Пиньинь %@", "Pinyin %@", "Pinyin %@"),
    "Play pronunciation": q("Play pronunciation", "Воспроизвести произношение", "Reproducir pronunciación", "Reproduzir pronúncia"),
    "Related Badges": q("Related Badges", "Связанные значки", "Insignias relacionadas", "Emblemas relacionados"),
    "Remove": q("Remove", "Удалить", "Eliminar", "Remover"),
    "Remove from favorites": q("Remove from favorites", "Удалить из избранного", "Quitar de favoritos", "Remover dos favoritos"),
    "Restart": q("Restart", "Начать заново", "Reiniciar", "Reiniciar"),
    "Session Expired": q("Session Expired", "Сессия завершена", "Sesión finalizada", "Sessão encerrada"),
    "Show back of card": q("Show back of card", "Показать обратную сторону карточки", "Mostrar el reverso de la tarjeta", "Mostrar o verso do cartão"),
    "Show front of card": q("Show front of card", "Показать лицевую сторону карточки", "Mostrar el frente de la tarjeta", "Mostrar a frente do cartão"),
    "Smart Review": q("Smart Review", "Умное повторение", "Repaso inteligente", "Revisão inteligente"),
    "Speaks the Chinese word": q("Speaks the Chinese word", "Произносит китайское слово", "Pronuncia la palabra china", "Pronuncia a palavra chinesa"),
    "Step %lld of %lld": q("Step %lld of %lld", "Шаг %lld из %lld", "Paso %lld de %lld", "Etapa %lld de %lld"),
    "Travel Collection": q("Travel Collection", "Коллекция путешествий", "Colección de viaje", "Coleção de viagem"),
    "Type Hanzi here": q("Type Hanzi here", "Введите иероглиф", "Escribe el Hanzi aquí", "Digite o Hanzi aqui"),
    "Your Route Across China": q("Your Route Across China", "Ваш маршрут по Китаю", "Tu ruta por China", "Sua rota pela China"),
}


IDENTICAL_KEYS = {
    " / %lld", "%@ %@", "%@ · %@", "%@, %@", "%@, %@, %@",
    "%@. %@", "%@. %@. %@", "%@. %@. %@. %@", "%lld", "%lld %@",
    "%lld / %lld", "%lld%%", "%lld/%lld", "+%lld XP", "×%lld",
    "⭐", "中", "习", "复", "学", "文", "汇", "词", "🇨🇳", "🇨🇳 %@", "🎉", "🧠",
}

STALE_DYNAMIC_KEYS = {
    "Hanzi+",
    "HanziPlus",
    "achievement.%@.description", "achievement.%@.title",
    "games.collection.%@.subtitle", "games.collection.%@.title",
    "games.daily.task.%@", "games.def.%@.benefit.%lld",
    "games.def.%@.description", "games.def.%@.tagline", "games.def.%@.title",
    "games.memory.mode.%@", "lesson.phase.%@",
    "journey.city.%@.bestSeason", "journey.city.%@.famousFor",
    "journey.city.%@.introduction", "journey.city.%@.localAchievement",
    "journey.city.%@.localFood", "journey.city.%@.mini.instruction",
    "journey.city.%@.mini.title", "journey.city.%@.name",
    "journey.city.%@.population", "journey.city.%@.province",
    "journey.city.%@.souvenirName",
}


def prune_stale_dynamic_keys() -> int:
    catalog = json.loads(XCSTRINGS.read_text(encoding="utf-8"))
    strings = catalog.get("strings") or {}
    removed = 0
    for key in STALE_DYNAMIC_KEYS:
        if strings.pop(key, None) is not None:
            removed += 1
    XCSTRINGS.write_text(json.dumps(catalog, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return removed


def all_strings() -> dict[str, dict[str, str]]:
    values = {key: q(key, key, key, key) for key in IDENTICAL_KEYS}
    values.update(TRANSLATIONS)
    return values


if __name__ == "__main__":
    removed = prune_stale_dynamic_keys()
    strings = all_strings()
    added = merge(strings)
    print(f"Completed {len(strings)} runtime UI keys ({added} added, {removed} stale keys removed)")
