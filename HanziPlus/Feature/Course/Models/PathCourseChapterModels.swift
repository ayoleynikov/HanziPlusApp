//
//  PathCourseChapterModels.swift
//  HanziPlus
//

import Foundation

// MARK: - Chapter

struct PathLessonChapter: Codable, Equatable, Identifiable {
    let id: String
    let number: Int
    let title: PathLocalizedText
    let goal: PathLocalizedText?
    let estimatedMinutes: Int
    let toneGuide: PathToneGuide?
    let grammarCard: PathGrammarCard?
    let sections: [PathLessonSection]
    let activities: [PathChapterActivity]

    var newWordCount: Int {
        sections.reduce(0) { partial, section in
            if case .vocabulary(let group) = section {
                return partial + group.items.filter(\.countsInLessonTotal).count
            }
            return partial
        }
    }

    var vocabularyItems: [PathVocabularyItem] {
        sections.compactMap { section in
            if case .vocabulary(let group) = section { return group.items }
            return nil
        }.flatMap { $0 }
    }

    func enriching(lessonNumber: Int) -> PathLessonChapter {
        let withGrammar: PathLessonChapter
        if grammarCard == nil, let card = PathGrammarCardLibrary.card(lessonNumber: lessonNumber, chapterNumber: number) {
            withGrammar = PathLessonChapter(
                id: id,
                number: number,
                title: title,
                goal: goal,
                estimatedMinutes: estimatedMinutes,
                toneGuide: toneGuide,
                grammarCard: card,
                sections: sections,
                activities: activities
            )
        } else {
            withGrammar = self
        }
        return withGrammar.fillingDefaultActivities(lessonNumber: lessonNumber)
    }

    var examplesInSections: [PathExample] {
        sections.flatMap { section -> [PathExample] in
            if case .examples(let items) = section { return items }
            return []
        }
        .filter { $0.group != "additional" }
    }

    var hasQuizableVocabulary: Bool {
        !vocabularyItems.filter(\.countsInLessonTotal).isEmpty
    }

    func fillingDefaultActivities(lessonNumber: Int) -> PathLessonChapter {
        guard activities.isEmpty else { return self }
        let generated = PathChapterActivityFactory.makeActivities(
            lessonNumber: lessonNumber,
            chapterNumber: number,
            sections: sections
        )
        guard !generated.isEmpty else { return self }
        return PathLessonChapter(
            id: id,
            number: number,
            title: title,
            goal: goal,
            estimatedMinutes: estimatedMinutes,
            toneGuide: toneGuide,
            grammarCard: grammarCard,
            sections: sections,
            activities: generated
        )
    }
}

// MARK: - Tone guide

struct PathToneGuide: Codable, Equatable, Identifiable {
    let id: String
    let title: PathLocalizedText
    let introduction: PathLocalizedText
    let tones: [PathToneExample]
    let neutralToneNote: PathLocalizedText?
    let toneMarkNote: PathLocalizedText?

    struct PathToneExample: Codable, Equatable, Identifiable {
        var id: String { syllable }
        let syllable: String
        let pinyin: String
        let toneNumber: Int
        let meaning: PathLocalizedText
        let contourDescription: PathLocalizedText
    }
}

// MARK: - Grammar

struct PathGrammarCard: Codable, Equatable, Identifiable {
    let id: String
    let title: PathLocalizedText
    let explanation: PathLocalizedText
    let formula: PathLocalizedText?
    let positiveExample: PathGrammarExample
    let questionExample: PathGrammarExample?
    let negativeExample: PathGrammarExample?
    let practicePrompt: PathLocalizedText?

    struct PathGrammarExample: Codable, Equatable {
        let hanzi: String
        let pinyin: String
        let translation: PathLocalizedText
    }
}

// MARK: - Activities

enum PathChapterActivity: Codable, Equatable, Identifiable {
    case sentenceBuilder(PathSentenceBuilderActivity)
    case fillBlank(PathFillBlankActivity)
    case dialogueOrder(PathDialogueOrderActivity)

    var id: String {
        switch self {
        case .sentenceBuilder(let activity): return activity.id
        case .fillBlank(let activity): return activity.id
        case .dialogueOrder(let activity): return activity.id
        }
    }

    private enum CodingKeys: String, CodingKey {
        case kind
    }

    private enum ActivityKind: String, Codable {
        case sentenceBuilder
        case fillBlank
        case dialogueOrder
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let kind = try container.decode(ActivityKind.self, forKey: .kind)
        switch kind {
        case .sentenceBuilder:
            self = .sentenceBuilder(try PathSentenceBuilderActivity(from: decoder))
        case .fillBlank:
            self = .fillBlank(try PathFillBlankActivity(from: decoder))
        case .dialogueOrder:
            self = .dialogueOrder(try PathDialogueOrderActivity(from: decoder))
        }
    }

    func encode(to encoder: Encoder) throws {
        switch self {
        case .sentenceBuilder(let activity):
            try activity.encode(to: encoder)
        case .fillBlank(let activity):
            try activity.encode(to: encoder)
        case .dialogueOrder(let activity):
            try activity.encode(to: encoder)
        }
    }
}

struct PathSentenceBuilderToken: Codable, Equatable, Identifiable, Hashable {
    let id: String
    let text: String
}

struct PathSentenceBuilderActivity: Codable, Equatable, Identifiable {
    let kind: String
    let id: String
    let prompt: PathLocalizedText
    let tokens: [PathSentenceBuilderToken]
    let correctOrder: [String]
    let resultHanzi: String
    let resultPinyin: String
    let resultTranslation: PathLocalizedText
    let explanation: PathLocalizedText?

    init(
        id: String,
        prompt: PathLocalizedText,
        tokens: [PathSentenceBuilderToken],
        correctOrder: [String],
        resultHanzi: String,
        resultPinyin: String,
        resultTranslation: PathLocalizedText,
        explanation: PathLocalizedText?
    ) {
        kind = "sentenceBuilder"
        self.id = id
        self.prompt = prompt
        self.tokens = tokens
        self.correctOrder = correctOrder
        self.resultHanzi = resultHanzi
        self.resultPinyin = resultPinyin
        self.resultTranslation = resultTranslation
        self.explanation = explanation
    }
}

struct PathFillBlankActivity: Codable, Equatable, Identifiable {
    let kind: String
    let id: String
    let prompt: PathLocalizedText
    let template: String
    let blankToken: String
    let options: [String]
    let correctOption: String
    let resultHanzi: String
    let resultPinyin: String
    let resultTranslation: PathLocalizedText
    let explanation: PathLocalizedText?
    let relatedVocabularyID: String?

    init(
        id: String,
        prompt: PathLocalizedText,
        template: String,
        blankToken: String,
        options: [String],
        correctOption: String,
        resultHanzi: String,
        resultPinyin: String,
        resultTranslation: PathLocalizedText,
        explanation: PathLocalizedText?,
        relatedVocabularyID: String?
    ) {
        kind = "fillBlank"
        self.id = id
        self.prompt = prompt
        self.template = template
        self.blankToken = blankToken
        self.options = options
        self.correctOption = correctOption
        self.resultHanzi = resultHanzi
        self.resultPinyin = resultPinyin
        self.resultTranslation = resultTranslation
        self.explanation = explanation
        self.relatedVocabularyID = relatedVocabularyID
    }
}

struct PathDialogueOrderActivity: Codable, Equatable, Identifiable {
    let kind: String
    let id: String
    let prompt: PathLocalizedText
    let lines: [PathDialogueOrderLine]
    let correctOrder: [String]
    let resultHanzi: String
    let resultPinyin: String
    let resultTranslation: PathLocalizedText?
    let explanation: PathLocalizedText?

    init(
        id: String,
        prompt: PathLocalizedText,
        lines: [PathDialogueOrderLine],
        correctOrder: [String],
        resultHanzi: String,
        resultPinyin: String,
        resultTranslation: PathLocalizedText?,
        explanation: PathLocalizedText?
    ) {
        kind = "dialogueOrder"
        self.id = id
        self.prompt = prompt
        self.lines = lines
        self.correctOrder = correctOrder
        self.resultHanzi = resultHanzi
        self.resultPinyin = resultPinyin
        self.resultTranslation = resultTranslation
        self.explanation = explanation
    }

    struct PathDialogueOrderLine: Codable, Equatable, Identifiable {
        let id: String
        let speaker: String?
        let hanzi: String
        let pinyin: String
        let translation: PathLocalizedText?
    }
}

// MARK: - Mistakes & progress

enum PathMistakeKind: String, Codable, Equatable {
    case vocabulary
    case grammar
    case sentenceBuilder
    case fillBlank
    case dialogueOrder
    case quizChinese
    case quizTranslation
}

struct PathCourseMistake: Codable, Equatable, Identifiable {
    let id: String
    let lessonID: String
    let chapterID: String
    let vocabularyID: String?
    let hanzi: String
    let pinyin: String
    let translation: PathLocalizedText
    let kind: PathMistakeKind
    var occurredAt: Date
    var mistakeCount: Int
    var isRemediated: Bool
}

struct PathChapterProgress: Codable, Equatable {
    var chapterID: String
    var stepIndex: Int
    var quizChineseIndex: Int
    var quizTranslationIndex: Int
    var exampleIndex: Int
    var activityIndex: Int
    var chineseQuizResults: [String: Bool]
    var translationQuizResults: [String: Bool]
    var isCompleted: Bool
    var completedAt: Date?

    static func fresh(chapterID: String) -> PathChapterProgress {
        PathChapterProgress(
            chapterID: chapterID,
            stepIndex: 0,
            quizChineseIndex: 0,
            quizTranslationIndex: 0,
            exampleIndex: 0,
            activityIndex: 0,
            chineseQuizResults: [:],
            translationQuizResults: [:],
            isCompleted: false,
            completedAt: nil
        )
    }
}

enum PathChapterStatus: Equatable {
    case locked
    case available
    case inProgress
    case completed
}
