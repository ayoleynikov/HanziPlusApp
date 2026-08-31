#!/usr/bin/env python3
"""Add missing es/pt-BR (and decorative CJK) localizations to Localizable.xcstrings."""

from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
XCSTRINGS = ROOT / "HanziPlus" / "Localizable.xcstrings"

PATCHES: dict[str, dict[str, str]] = {
    "journey.map.tap_to_explore": {
        "es": "Toca para explorar",
        "pt-BR": "Toque para explorar",
    },
    "settings.reset.all_alert_body": {
        "es": "Se borrarán todas las palabras aprendidas, puntuaciones de juegos, progreso del viaje, lecciones Path, favoritos y estadísticas diarias. Esto no se puede deshacer.",
        "pt-BR": "Todas as palavras aprendidas, pontuações dos jogos, progresso da jornada, lições Path, favoritos e estatísticas diárias serão apagados. Isso não pode ser desfeito.",
    },
    "settings.reset.all_alert_title": {
        "es": "¿Restablecer todo el progreso?",
        "pt-BR": "Redefinir todo o progresso?",
    },
    "settings.reset.all_footer": {
        "es": "Restablece todo a cero.",
        "pt-BR": "Zera todo o progresso no app.",
    },
    "settings.reset.all_progress": {
        "es": "Restablecer todo el progreso",
        "pt-BR": "Redefinir todo o progresso",
    },
    "travel.quick.shopping_mall": {
        "es": "Centro comercial",
        "pt-BR": "Shopping",
    },
    "travel.route.situation_label": {
        "es": "Palabras para turistas",
        "pt-BR": "Palavras para turistas",
    },
    "travel.section.journey_route": {
        "es": "Ruta por China",
        "pt-BR": "Rota pela China",
    },
    "travel.section.tourist_words": {
        "es": "Palabras para turistas",
        "pt-BR": "Palavras para turistas",
    },
    "travel.section.tourist_words.subtitle": {
        "es": "Frases para situaciones reales: aeropuerto, taxi, compras y más.",
        "pt-BR": "Frases para situações reais — aeroporto, táxi, compras e mais.",
    },
    "汉": {"en": "汉", "ru": "汉", "es": "汉", "pt-BR": "汉"},
    "游": {"en": "游", "ru": "游", "es": "游", "pt-BR": "游"},
    "+": {"en": "+", "ru": "+", "es": "+", "pt-BR": "+"},
    "•": {"en": "•", "ru": "•", "es": "•", "pt-BR": "•"},
}


def unit(value: str) -> dict:
    return {"stringUnit": {"state": "translated", "value": value}}


def main() -> None:
    catalog = json.loads(XCSTRINGS.read_text(encoding="utf-8"))
    strings = catalog.setdefault("strings", {})
    patched = 0

    for key, locales in PATCHES.items():
        entry = strings.setdefault(key, {"extractionState": "manual", "localizations": {}})
        locs = entry.setdefault("localizations", {})
        for locale, value in locales.items():
            locs[locale] = unit(value)
            patched += 1

    XCSTRINGS.write_text(json.dumps(catalog, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"Patched {patched} localization entries.")


if __name__ == "__main__":
    main()
