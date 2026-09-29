//
//  PathLessonChapterSplitter.swift
//  HanziPlus
//

import Foundation

/// Splits legacy flat `sections` into bite-sized chapters when JSON has no explicit chapters.
enum PathLessonChapterSplitter {

    static let maxNewWordsPerChapter = 12
    static let targetNewWordsPerChapter = 8

    static func split(
        lessonID: String,
        lessonNumber: Int,
        sections: [PathLessonSection]
    ) -> [PathLessonChapter] {
        if sections.isEmpty { return [] }

        var chapters: [PathLessonChapter] = []
        var buffer: [PathLessonSection] = []
        var vocabCount = 0
        var chapterNumber = 0

        func flush(titleKey: String, grammar: PathGrammarCard?) {
            guard !buffer.isEmpty else { return }
            chapterNumber += 1
            let activities = PathChapterActivityFactory.makeActivities(
                lessonNumber: lessonNumber,
                chapterNumber: chapterNumber,
                sections: buffer
            )
            chapters.append(
                PathLessonChapter(
                    id: "\(lessonID)_ch\(String(format: "%02d", chapterNumber))",
                    number: chapterNumber,
                    title: defaultChapterTitle(lessonNumber: lessonNumber, chapterNumber: chapterNumber, key: titleKey),
                    goal: nil,
                    estimatedMinutes: estimatedMinutes(for: buffer, activities: activities),
                    toneGuide: nil,
                    grammarCard: grammar,
                    sections: finalizeChapterSections(buffer),
                    activities: activities
                )
            )
            buffer = []
            vocabCount = 0
        }

        var pendingGrammar: PathGrammarCard?
        for section in sections {
            switch section {
            case .completion:
                flush(titleKey: "wrap_up", grammar: pendingGrammar)
                pendingGrammar = nil
                if !chapters.isEmpty {
                    let last = chapters.removeLast()
                    let mergedSections = finalizeChapterSections(last.sections)
                    chapters.append(
                        PathLessonChapter(
                            id: last.id,
                            number: last.number,
                            title: last.title,
                            goal: last.goal,
                            estimatedMinutes: last.estimatedMinutes,
                            toneGuide: last.toneGuide,
                            grammarCard: last.grammarCard,
                            sections: mergedSections,
                            activities: last.activities
                        )
                    )
                }
            case .vocabulary(let group):
                let itemCount = group.items.filter(\.countsInLessonTotal).count
                if vocabCount > 0, vocabCount + itemCount > maxNewWordsPerChapter {
                    flush(titleKey: "vocabulary", grammar: pendingGrammar)
                    pendingGrammar = nil
                }
                buffer.append(section)
                vocabCount += itemCount
                if vocabCount >= targetNewWordsPerChapter {
                    flush(titleKey: "practice", grammar: pendingGrammar)
                    pendingGrammar = PathGrammarCardLibrary.card(lessonNumber: lessonNumber, chapterNumber: chapterNumber + 1)
                }
            case .dialogue, .dialogueRepeat, .transition:
                if vocabCount >= targetNewWordsPerChapter {
                    flush(titleKey: "dialogue", grammar: pendingGrammar)
                    pendingGrammar = nil
                }
                buffer.append(section)
            case .vocabularySummary, .quizChineseToTranslation, .quizTranslationToChinese, .examples:
                buffer.append(section)
            case .toneGuide, .grammar, .sentenceBuilder, .fillBlank, .dialogueOrder, .mistakeReview, .chapterComplete:
                buffer.append(section)
            }
        }

        if !buffer.isEmpty {
            flush(titleKey: "continue", grammar: pendingGrammar)
        }

        return chapters
    }

    private static func finalizeChapterSections(_ sections: [PathLessonSection]) -> [PathLessonSection] {
        var result = sections
        if !result.contains(where: { if case .completion = $0 { return true }; return false }) {
            result.append(.completion)
        }
        return result
    }

    private static func estimatedMinutes(for sections: [PathLessonSection], activities: [PathChapterActivity]) -> Int {
        var minutes = 4
        for section in sections {
            switch section {
            case .dialogue(let dialogue, _, _):
                minutes += max(2, dialogue.lines.count / 3)
            case .vocabulary(let group):
                minutes += max(2, group.items.count)
            case .examples(let items):
                minutes += min(4, max(1, items.count / 4))
            case .quizChineseToTranslation, .quizTranslationToChinese:
                minutes += 2
            default:
                break
            }
        }
        minutes += activities.count
        return min(12, max(7, minutes))
    }

    private static func defaultChapterTitle(
        lessonNumber: Int,
        chapterNumber: Int,
        key: String
    ) -> PathLocalizedText {
        let labels: [String: (String, String, String, String)] = [
            "main": ("Основная часть", "Main part", "Parte principal", "Parte principal"),
            "dialogue": ("Диалог", "Dialogue", "Diálogo", "Diálogo"),
            "vocabulary": ("Новые слова", "New words", "Palabras nuevas", "Palavras novas"),
            "practice": ("Практика", "Practice", "Práctica", "Prática"),
            "wrap_up": ("Итог", "Wrap-up", "Resumen", "Encerramento"),
            "continue": ("Продолжение", "Continue", "Continuación", "Continuação"),
        ]
        let label = labels[key] ?? ("Глава \(chapterNumber)", "Chapter \(chapterNumber)", "Capítulo \(chapterNumber)", "Capítulo \(chapterNumber)")
        return PathLocalizedText(values: [
            "ru": label.0,
            "en": label.1,
            "es": label.2,
            "pt-BR": label.3,
        ])
    }
}
