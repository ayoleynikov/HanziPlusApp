//
//  PathActivityExplanationBuilder.swift
//  HanziPlus
//

import Foundation

enum PathActivityExplanationBuilder {

    static func fillBlank(correctOption: String, resultHanzi: String) -> PathLocalizedText {
        switch correctOption {
        case "吗":
            return tr(
                "Частица 吗 в конце превращает фразу в вопрос «да/нет». Получается: \(resultHanzi)",
                "吗 at the end turns the phrase into a yes/no question. Result: \(resultHanzi)",
                "吗 al final convierte la frase en una pregunta de sí/no. Resultado: \(resultHanzi)",
                "吗 no final transforma a frase em pergunta de sim/não. Resultado: \(resultHanzi)"
            )
        case "不":
            return tr(
                "不 перед прилагательным или глаголом даёт отрицание: \(resultHanzi)",
                "不 before an adjective or verb makes it negative: \(resultHanzi)",
                "不 antes de un adjetivo o verbo indica negación: \(resultHanzi)",
                "不 antes de um adjetivo ou verbo indica negação: \(resultHanzi)"
            )
        case "很":
            return tr(
                "很 ставится перед прилагательным и означает «очень»: \(resultHanzi)",
                "很 goes before an adjective and means “very”: \(resultHanzi)",
                "很 va antes del adjetivo y significa «muy»: \(resultHanzi)",
                "很 vem antes do adjetivo e significa «muito»: \(resultHanzi)"
            )
        case "也":
            return tr(
                "也 означает «тоже» и ставится перед глаголом или прилагательным: \(resultHanzi)",
                "也 means “also” and is placed before a verb or adjective: \(resultHanzi)",
                "也 significa «también» y va antes del verbo o adjetivo: \(resultHanzi)",
                "也 significa «também» e vem antes do verbo ou adjetivo: \(resultHanzi)"
            )
        case "的":
            return tr(
                "的 связывает определение и существительное: \(resultHanzi)",
                "的 links a modifier to a noun: \(resultHanzi)",
                "的 une un modificador con un sustantivo: \(resultHanzi)",
                "的 liga um modificador a um substantivo: \(resultHanzi)"
            )
        case "了":
            return tr(
                "了 показывает, что действие завершилось или ситуация изменилась: \(resultHanzi)",
                "了 shows that an action is completed or a situation changed: \(resultHanzi)",
                "了 indica que la acción terminó o la situación cambió: \(resultHanzi)",
                "了 indica que a ação terminou ou a situação mudou: \(resultHanzi)"
            )
        case "呢":
            return tr(
                "呢 в конце задаёт вопрос «а у тебя?» или смягчает тон: \(resultHanzi)",
                "呢 at the end asks “what about you?” or softens the tone: \(resultHanzi)",
                "呢 al final pregunta «¿y tú?» o suaviza el tono: \(resultHanzi)",
                "呢 no final pergunta «e você?» ou suaviza o tom: \(resultHanzi)"
            )
        default:
            return tr(
                "Правильный вариант — «\(correctOption)». Вся фраза: \(resultHanzi)",
                "The correct choice is “\(correctOption)”. Full phrase: \(resultHanzi)",
                "La opción correcta es «\(correctOption)». Frase completa: \(resultHanzi)",
                "A opção correta é «\(correctOption)». Frase completa: \(resultHanzi)"
            )
        }
    }

    static func sentenceBuilder(resultHanzi: String) -> PathLocalizedText {
        if resultHanzi.contains("吗") {
            return tr(
                "Вопрос строится так: сначала смысловая часть, потом 吗 в конце: \(resultHanzi)",
                "Questions are built with the meaning first, then 吗 at the end: \(resultHanzi)",
                "La pregunta se forma con el significado primero y 吗 al final: \(resultHanzi)",
                "A pergunta se forma com o significado primeiro e 吗 no final: \(resultHanzi)"
            )
        }
        if resultHanzi.contains("你好") {
            return tr(
                "Приветствие 你好 буквально «ты хороший» — стандартное «привет»: \(resultHanzi)",
                "你好 literally means “you good” — the standard greeting: \(resultHanzi)",
                "你好 significa literalmente «tú bien» — el saludo estándar: \(resultHanzi)",
                "你好 significa literalmente «você bem» — a saudação padrão: \(resultHanzi)"
            )
        }
        if resultHanzi.hasPrefix("不") {
            return tr(
                "Отрицание 不 ставится прямо перед словом, которое отрицаем: \(resultHanzi)",
                "The negation 不 is placed directly before the word it negates: \(resultHanzi)",
                "La negación 不 va justo antes de la palabra que niega: \(resultHanzi)",
                "A negação 不 vem logo antes da palavra negada: \(resultHanzi)"
            )
        }
        return tr(
            "В китайском порядок слов важен. Естественная фраза: \(resultHanzi)",
            "Word order matters in Chinese. The natural phrase is: \(resultHanzi)",
            "El orden de las palabras importa en chino. La frase natural es: \(resultHanzi)",
            "A ordem das palavras importa no chinês. A frase natural é: \(resultHanzi)"
        )
    }

    static func dialogueOrder(
        lines: [PathDialogueOrderActivity.PathDialogueOrderLine],
        correctOrder: [String]
    ) -> PathLocalizedText {
        let ordered = correctOrder.compactMap { id in lines.first(where: { $0.id == id }) }
        let preview = ordered.prefix(2).map(\.hanzi).joined(separator: " → ")
        return tr(
            "В диалоге реплики идут по логике разговора: \(preview)",
            "In a dialogue, lines follow the conversation flow: \(preview)",
            "En un diálogo, las réplicas siguen el flujo de la conversación: \(preview)",
            "Em um diálogo, as falas seguem o fluxo da conversa: \(preview)"
        )
    }

    static func vocabulary(item: PathVocabularyItem) -> PathLocalizedText {
        let ru = item.translation.localizedValue(language: .ru)
        let en = item.translation.localizedValue(language: .en)
        let es = item.translation.localizedValue(language: .es)
        let pt = item.translation.localizedValue(language: .ptBR)
        return tr(
            "\(item.hanzi) (\(item.pinyin)) — «\(ru)». Запомни написание и значение.",
            "\(item.hanzi) (\(item.pinyin)) means “\(en)”. Remember the character and meaning.",
            "\(item.hanzi) (\(item.pinyin)) significa «\(es)». Recuerda el carácter y el significado.",
            "\(item.hanzi) (\(item.pinyin)) significa «\(pt)». Lembre o caractere e o significado."
        )
    }

    private static func tr(_ ru: String, _ en: String, _ es: String, _ pt: String) -> PathLocalizedText {
        PathLocalizedText(values: ["ru": ru, "en": en, "es": es, "pt-BR": pt])
    }
}
