//
//  PathChapterActivityFactory.swift
//  HanziPlus
//

import Foundation

enum PathChapterActivityFactory {

    private static let fillBlankParticles = Set(["吗", "不", "很", "也", "的", "了", "呢"])

    private static let lexicalBlocks = [
        "怎么样", "为什么", "什么时候", "什么地方", "多少钱", "对不起", "不客气", "没关系", "很高兴", "认识你",
        "什么", "名字", "老师", "学生", "我们", "你们", "他们", "她们", "小姐", "先生", "谢谢", "再见",
        "今天", "明天", "昨天", "现在", "时候", "地方", "中国", "美国", "日本", "韩国", "英国", "法国",
        "人民币", "美元", "电话", "手机", "电脑", "学校", "医院", "饭店", "商店", "银行", "邮局",
        "怎么样", "有点儿", "一点儿", "一下", "可以", "应该", "需要", "喜欢", "觉得", "知道", "认识",
    ]

    static func makeActivities(
        lessonNumber: Int,
        chapterNumber: Int,
        sections: [PathLessonSection]
    ) -> [PathChapterActivity] {
        let vocabulary = sections.compactMap { section -> [PathVocabularyItem]? in
            if case .vocabulary(let group) = section { return group.items }
            return nil
        }.flatMap { $0 }
        var activities: [PathChapterActivity] = []
        var seenIDs = Set<String>()

        for section in sections {
            guard case .dialogue(let dialogue, _, _) = section else { continue }
            guard isDialogueOrderCandidate(dialogue) else { continue }

            let orderID = "l\(lessonNumber)_c\(chapterNumber)_do_\(dialogue.id)"
            if seenIDs.insert(orderID).inserted {
                activities.append(
                    dialogueOrderActivity(
                        from: dialogue,
                        id: orderID,
                        lessonNumber: lessonNumber,
                        chapterNumber: chapterNumber
                    )
                )
            }
        }

        for section in sections {
            guard case .dialogue(let dialogue, _, _) = section else { continue }
            guard let line = dialogue.lines.first(where: isSentenceBuilderCandidate) else { continue }

            let builderID = "l\(lessonNumber)_c\(chapterNumber)_sb_\(dialogue.id)"
            guard seenIDs.insert(builderID).inserted else { continue }

            activities.append(
                sentenceBuilder(
                    from: line,
                    id: builderID,
                    lessonNumber: lessonNumber,
                    chapterNumber: chapterNumber,
                    vocabulary: vocabulary
                )
            )
        }

        for section in sections {
            switch section {
            case .dialogue(let dialogue, _, _):
                for line in dialogue.lines {
                    guard let fillBlank = fillBlankFromDialogueLine(
                        line,
                        lessonNumber: lessonNumber,
                        chapterNumber: chapterNumber,
                        dialogueID: dialogue.id,
                        seenIDs: &seenIDs
                    ) else { continue }
                    activities.append(fillBlank)
                    if activities.filter(isFillBlank).count >= 2 { break }
                }
            case .vocabulary(let group):
                for item in group.items where fillBlankParticles.contains(item.hanzi) {
                    guard let fillBlank = fillBlankFromParticle(
                        item,
                        lessonNumber: lessonNumber,
                        chapterNumber: chapterNumber,
                        seenIDs: &seenIDs
                    ) else { continue }
                    activities.append(fillBlank)
                }
            default:
                break
            }
        }

        return Array(activities.prefix(4))
    }

    // MARK: - Sentence builder

    nonisolated private static func isSentenceBuilderCandidate(_ line: PathDialogueLine) -> Bool {
        let stripped = line.hanzi.trimmingCharacters(in: CharacterSet(charactersIn: "！？。，、"))
        return (2 ... 12).contains(stripped.count)
    }

    private static func sentenceBuilder(
        from line: PathDialogueLine,
        id: String,
        lessonNumber: Int,
        chapterNumber: Int,
        vocabulary: [PathVocabularyItem]
    ) -> PathChapterActivity {
        let pieces = sentenceBuilderPieces(from: line.hanzi, vocabulary: vocabulary)
        let tokens = pieces.enumerated().map { index, text in
            PathSentenceBuilderToken(id: "\(id)_t\(index)", text: text)
        }
        let correctOrder = tokens.map(\.id)
        let shuffled = DailyLessonPlanner.seededShuffle(tokens, seed: seed(lessonNumber, chapterNumber, id.hashValue))
        let activity = PathSentenceBuilderActivity(
            id: id,
            prompt: tr("Собери предложение.", "Build the sentence.", "Forma la frase.", "Monte a frase."),
            tokens: shuffled,
            correctOrder: correctOrder,
            resultHanzi: line.hanzi,
            resultPinyin: line.pinyin,
            resultTranslation: line.translation ?? tr(line.hanzi, line.hanzi, line.hanzi, line.hanzi),
            explanation: PathActivityExplanationBuilder.sentenceBuilder(resultHanzi: line.hanzi)
        )
        return .sentenceBuilder(activity)
    }

    // MARK: - Fill blank

    private static func fillBlankFromDialogueLine(
        _ line: PathDialogueLine,
        lessonNumber: Int,
        chapterNumber: Int,
        dialogueID: String,
        seenIDs: inout Set<String>
    ) -> PathChapterActivity? {
        let hanzi = line.hanzi

        if hanzi.contains("吗"), let range = hanzi.range(of: "吗") {
            return makeFillBlank(
                id: "l\(lessonNumber)_c\(chapterNumber)_fb_\(dialogueID)_ma",
                template: hanzi.replacingCharacters(in: range, with: "___"),
                blankToken: "___",
                correctOption: "吗",
                resultHanzi: hanzi,
                resultPinyin: line.pinyin,
                resultTranslation: line.translation ?? tr(hanzi, hanzi, hanzi, hanzi),
                options: ["吗", "的", "很", "也"],
                relatedVocabularyID: nil,
                explanation: PathActivityExplanationBuilder.fillBlank(correctOption: "吗", resultHanzi: hanzi),
                seenIDs: &seenIDs
            )
        }

        if hanzi.hasPrefix("不"), hanzi.count >= 2 {
            let rest = String(hanzi.dropFirst())
            let correct = String(rest.prefix(while: { $0 != "？" && $0 != "。" && $0 != "！" }))
            return makeFillBlank(
                id: "l\(lessonNumber)_c\(chapterNumber)_fb_\(dialogueID)_bu",
                template: "不___",
                blankToken: "___",
                correctOption: correct,
                resultHanzi: hanzi,
                resultPinyin: line.pinyin,
                resultTranslation: line.translation ?? tr(hanzi, hanzi, hanzi, hanzi),
                options: [String(rest.prefix(2)), "很", "吗", "也"],
                relatedVocabularyID: nil,
                explanation: PathActivityExplanationBuilder.fillBlank(correctOption: "不", resultHanzi: hanzi),
                seenIDs: &seenIDs
            )
        }

        return nil
    }

    private static func fillBlankFromParticle(
        _ item: PathVocabularyItem,
        lessonNumber: Int,
        chapterNumber: Int,
        seenIDs: inout Set<String>
    ) -> PathChapterActivity? {
        guard fillBlankParticles.contains(item.hanzi) else { return nil }

        let template: String
        let resultHanzi: String
        let resultPinyin: String

        switch item.hanzi {
        case "吗":
            template = "你好___？"
            resultHanzi = "你好吗？"
            resultPinyin = "Nǐ hǎo ma?"
        case "很":
            template = "___好"
            resultHanzi = "很好"
            resultPinyin = "Hěn hǎo"
        case "不":
            template = "___好"
            resultHanzi = "不好"
            resultPinyin = "Bù hǎo"
        default:
            return nil
        }

        return makeFillBlank(
            id: "l\(lessonNumber)_c\(chapterNumber)_fb_\(item.id)",
            template: template,
            blankToken: "___",
            correctOption: item.hanzi,
            resultHanzi: resultHanzi,
            resultPinyin: resultPinyin,
            resultTranslation: item.translation,
            options: ["吗", "很", "不", "也"],
            relatedVocabularyID: item.id,
            explanation: PathActivityExplanationBuilder.fillBlank(
                correctOption: item.hanzi,
                resultHanzi: resultHanzi
            ),
            seenIDs: &seenIDs
        )
    }

    private static func makeFillBlank(
        id: String,
        template: String,
        blankToken: String,
        correctOption: String,
        resultHanzi: String,
        resultPinyin: String,
        resultTranslation: PathLocalizedText,
        options: [String],
        relatedVocabularyID: String?,
        explanation: PathLocalizedText,
        seenIDs: inout Set<String>
    ) -> PathChapterActivity? {
        guard seenIDs.insert(id).inserted else { return nil }
        guard options.contains(correctOption) else { return nil }

        let activity = PathFillBlankActivity(
            id: id,
            prompt: tr("Выбери подходящее слово.", "Choose the correct word.", "Elige la palabra correcta.", "Escolha a palavra correta."),
            template: template,
            blankToken: blankToken,
            options: options,
            correctOption: correctOption,
            resultHanzi: resultHanzi,
            resultPinyin: resultPinyin,
            resultTranslation: resultTranslation,
            explanation: explanation,
            relatedVocabularyID: relatedVocabularyID
        )
        return .fillBlank(activity)
    }

    // MARK: - Dialogue order

    private static func isDialogueOrderCandidate(_ dialogue: PathDialogue) -> Bool {
        guard dialogue.lines.count >= 2 else { return false }
        let normalizedLines = dialogue.lines.map { normalizeDialogueHanzi($0.hanzi) }
        return Set(normalizedLines).count >= 2
    }

    private static func normalizeDialogueHanzi(_ hanzi: String) -> String {
        hanzi.trimmingCharacters(in: CharacterSet(charactersIn: "！？。，、 \n\t"))
    }

    private static func dialogueOrderActivity(
        from dialogue: PathDialogue,
        id: String,
        lessonNumber: Int,
        chapterNumber: Int
    ) -> PathChapterActivity {
        let lines = dialogue.lines.prefix(4).map { line in
            PathDialogueOrderActivity.PathDialogueOrderLine(
                id: line.id,
                speaker: line.speaker,
                hanzi: line.hanzi,
                pinyin: line.pinyin,
                translation: line.translation
            )
        }
        let correctOrder = lines.map(\.id)
        let orderedLines = correctOrder.compactMap { id in lines.first(where: { $0.id == id }) }
        let activity = PathDialogueOrderActivity(
            id: id,
            prompt: tr("Расставь реплики по порядку.", "Put the lines in order.", "Ordena las réplicas.", "Ordene as falas."),
            lines: DailyLessonPlanner.seededShuffle(Array(lines), seed: seed(lessonNumber, chapterNumber, id.hashValue)),
            correctOrder: correctOrder,
            resultHanzi: orderedLines.map(\.hanzi).joined(separator: "\n"),
            resultPinyin: orderedLines.map(\.pinyin).joined(separator: " / "),
            resultTranslation: orderedLines.first?.translation,
            explanation: PathActivityExplanationBuilder.dialogueOrder(lines: Array(lines), correctOrder: correctOrder)
        )
        return .dialogueOrder(activity)
    }

    // MARK: - Helpers

    private static func sentenceBuilderPieces(
        from hanzi: String,
        vocabulary: [PathVocabularyItem]
    ) -> [String] {
        let stripped = hanzi.trimmingCharacters(in: CharacterSet(charactersIn: "！？。，、"))
        let lexical = tokenizeLexically(hanzi, vocabulary: vocabulary)
        let meaningful = lexical.filter {
            !$0.unicodeScalars.allSatisfy { CharacterSet(charactersIn: "！？。，、").contains($0) }
        }
        if meaningful.count >= 2 {
            return lexical
        }
        if (2 ... 4).contains(stripped.count) {
            return tokenizeByCharacter(hanzi)
        }
        return lexical
    }

    private static func tokenizeByCharacter(_ hanzi: String) -> [String] {
        hanzi.map { String($0) }
    }

    private static func tokenizeLexically(_ hanzi: String, vocabulary: [PathVocabularyItem]) -> [String] {
        let punctuation = CharacterSet(charactersIn: "！？。，、")
        let dictionary = Array(
            Set(lexicalBlocks + vocabulary.map(\.hanzi))
                .sorted { $0.count > $1.count }
        )

        var tokens: [String] = []
        var index = hanzi.startIndex

        while index < hanzi.endIndex {
            let remaining = String(hanzi[index...])
            let character = String(hanzi[index])

            if character.unicodeScalars.allSatisfy({ punctuation.contains($0) }) {
                tokens.append(character)
                index = hanzi.index(after: index)
                continue
            }

            let matched = dictionary.first { remaining.hasPrefix($0) } ?? character
            tokens.append(matched)
            index = hanzi.index(index, offsetBy: matched.count)
        }

        return tokens.isEmpty ? [hanzi] : tokens
    }

    private static func seed(_ lesson: Int, _ chapter: Int, _ salt: Int) -> UInt64 {
        UInt64(bitPattern: Int64(lesson &* 10_000 + chapter &* 100 + (salt & 0x7FFF)))
    }

    nonisolated private static func isFillBlank(_ activity: PathChapterActivity) -> Bool {
        if case .fillBlank = activity { return true }
        return false
    }

    private static func tr(_ ru: String, _ en: String, _ es: String, _ pt: String) -> PathLocalizedText {
        PathLocalizedText(values: ["ru": ru, "en": en, "es": es, "pt-BR": pt])
    }
}
