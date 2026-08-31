//
//  PathCourseModels.swift
//  HanziPlus
//

import Foundation

struct PathCourse: Codable, Equatable {
    let id: String
    let title: String
    let subtitle: String
    let summary: String
    let description: String
    let volumeCount: Int
    let totalLessons: Int
    let lessons: [PathLessonSummary]

    var availableLessonCount: Int {
        lessons.filter(\.isAvailable).count
    }
}

struct PathLessonSummary: Codable, Equatable, Identifiable {
    let id: String
    let number: Int
    let sourceLessonNumbers: [Int]
    let chineseTitle: String
    let pinyinTitle: String?
    let translationTitle: PathLocalizedText?
    let vocabularyCount: Int
    let contentFile: String?
    let isAvailable: Bool

    init(
        id: String,
        number: Int,
        sourceLessonNumbers: [Int],
        chineseTitle: String,
        pinyinTitle: String?,
        translationTitle: PathLocalizedText?,
        vocabularyCount: Int,
        contentFile: String?,
        isAvailable: Bool
    ) {
        self.id = id
        self.number = number
        self.sourceLessonNumbers = sourceLessonNumbers
        self.chineseTitle = chineseTitle
        self.pinyinTitle = pinyinTitle
        self.translationTitle = translationTitle
        self.vocabularyCount = vocabularyCount
        self.contentFile = contentFile
        self.isAvailable = isAvailable
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        number = try container.decode(Int.self, forKey: .number)
        sourceLessonNumbers = try container.decode([Int].self, forKey: .sourceLessonNumbers)
        chineseTitle = try container.decode(String.self, forKey: .chineseTitle)
        pinyinTitle = try container.decodeIfPresent(String.self, forKey: .pinyinTitle)
        translationTitle = PathLocalizedText.sanitized(
            try container.decodeIfPresent(PathLocalizedText.self, forKey: .translationTitle)
        )
        vocabularyCount = try container.decode(Int.self, forKey: .vocabularyCount)
        contentFile = try container.decodeIfPresent(String.self, forKey: .contentFile)
        isAvailable = try container.decode(Bool.self, forKey: .isAvailable)
    }

    private enum CodingKeys: String, CodingKey {
        case id, number, sourceLessonNumbers, chineseTitle, pinyinTitle, translationTitle
        case vocabularyCount, contentFile, isAvailable
    }
}

struct PathLesson: Codable, Equatable, Identifiable {
    let id: String
    let number: Int
    let sourceLessonNumbers: [Int]
    let chineseTitle: String
    let chineseSubtitle: String?
    let pinyinTitle: String?
    let translationTitle: PathLocalizedText?
    let sections: [PathLessonSection]

    init(
        id: String,
        number: Int,
        sourceLessonNumbers: [Int],
        chineseTitle: String,
        chineseSubtitle: String?,
        pinyinTitle: String?,
        translationTitle: PathLocalizedText?,
        sections: [PathLessonSection]
    ) {
        self.id = id
        self.number = number
        self.sourceLessonNumbers = sourceLessonNumbers
        self.chineseTitle = chineseTitle
        self.chineseSubtitle = chineseSubtitle
        self.pinyinTitle = pinyinTitle
        self.translationTitle = translationTitle
        self.sections = sections
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        number = try container.decode(Int.self, forKey: .number)
        sourceLessonNumbers = try container.decode([Int].self, forKey: .sourceLessonNumbers)
        chineseTitle = try container.decode(String.self, forKey: .chineseTitle)
        chineseSubtitle = try container.decodeIfPresent(String.self, forKey: .chineseSubtitle)
        pinyinTitle = try container.decodeIfPresent(String.self, forKey: .pinyinTitle)
        translationTitle = PathLocalizedText.sanitized(
            try container.decodeIfPresent(PathLocalizedText.self, forKey: .translationTitle)
        )
        sections = try container.decode([PathLessonSection].self, forKey: .sections)
    }

    private enum CodingKeys: String, CodingKey {
        case id, number, sourceLessonNumbers, chineseTitle, chineseSubtitle, pinyinTitle
        case translationTitle, sections
    }

    var allVocabulary: [PathVocabularyItem] {
        sections.compactMap { section in
            if case .vocabulary(let group) = section {
                return group.items
            }
            return nil
        }.flatMap { $0 }
    }

    var quizVocabulary: [PathVocabularyItem] {
        allVocabulary
    }

    var countedVocabulary: [PathVocabularyItem] {
        allVocabulary.filter(\.countsInLessonTotal)
    }

    var countedVocabularyTotal: Int {
        countedVocabulary.count
    }

    var dialogues: [PathDialogue] {
        sections.compactMap { section in
            switch section {
            case .dialogue(let dialogue, _, _):
                return dialogue
            case .dialogueRepeat(let dialogue, _):
                return dialogue
            default:
                return nil
            }
        }
    }

    var examples: [PathExample] {
        for section in sections {
            if case .examples(let items) = section {
                return items
            }
        }
        return []
    }

    var vocabularyGroups: [PathVocabularyGroup] {
        sections.compactMap { section in
            if case .vocabulary(let group) = section {
                return group
            }
            return nil
        }
    }

    func resolvedVocabularySummaryGroups() -> [PathVocabularyGroup] {
        let groupsByID = Dictionary(uniqueKeysWithValues: vocabularyGroups.map { ($0.id, $0) })

        for section in sections {
            if case .vocabularySummary(let groups) = section {
                return groups.map { placeholder in
                    groupsByID[placeholder.id] ?? placeholder
                }
            }
        }

        return vocabularyGroups
    }
}

enum PathLessonSection: Codable, Equatable {
    case dialogue(PathDialogue, continueButtonTitle: String, showLessonHeader: Bool)
    case vocabulary(PathVocabularyGroup)
    case transition(String)
    case vocabularySummary([PathVocabularyGroup])
    case dialogueRepeat(PathDialogue, title: String)
    case quizChineseToTranslation
    case quizTranslationToChinese
    case examples([PathExample])
    case completion

    private enum CodingKeys: String, CodingKey {
        case kind
        case dialogue
        case continueButtonTitle
        case showLessonHeader
        case vocabulary
        case text
        case groups
        case title
        case items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let kind = try container.decode(String.self, forKey: .kind)

        switch kind {
        case "dialogue":
            let dialogue = try container.decode(PathDialogue.self, forKey: .dialogue)
            let continueTitle = try container.decode(String.self, forKey: .continueButtonTitle)
            let showHeader = try container.decodeIfPresent(Bool.self, forKey: .showLessonHeader) ?? false
            self = .dialogue(dialogue, continueButtonTitle: continueTitle, showLessonHeader: showHeader)
        case "vocabulary":
            let group = try container.decode(PathVocabularyGroup.self, forKey: .vocabulary)
            self = .vocabulary(group)
        case "transition":
            let text = try container.decode(String.self, forKey: .text)
            self = .transition(text)
        case "vocabularySummary":
            let groups = try container.decode([PathVocabularyGroup].self, forKey: .groups)
            self = .vocabularySummary(groups)
        case "dialogueRepeat":
            let dialogue = try container.decode(PathDialogue.self, forKey: .dialogue)
            let title = try container.decode(String.self, forKey: .title)
            self = .dialogueRepeat(dialogue, title: title)
        case "quizChineseToTranslation":
            self = .quizChineseToTranslation
        case "quizTranslationToChinese":
            self = .quizTranslationToChinese
        case "examples":
            let items = try container.decode([PathExample].self, forKey: .items)
            self = .examples(items)
        case "completion":
            self = .completion
        default:
            throw DecodingError.dataCorruptedError(
                forKey: .kind,
                in: container,
                debugDescription: "Unknown section kind: \(kind)"
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .dialogue(let dialogue, let continueTitle, let showHeader):
            try container.encode("dialogue", forKey: .kind)
            try container.encode(dialogue, forKey: .dialogue)
            try container.encode(continueTitle, forKey: .continueButtonTitle)
            try container.encode(showHeader, forKey: .showLessonHeader)
        case .vocabulary(let group):
            try container.encode("vocabulary", forKey: .kind)
            try container.encode(group, forKey: .vocabulary)
        case .transition(let text):
            try container.encode("transition", forKey: .kind)
            try container.encode(text, forKey: .text)
        case .vocabularySummary(let groups):
            try container.encode("vocabularySummary", forKey: .kind)
            try container.encode(groups, forKey: .groups)
        case .dialogueRepeat(let dialogue, let title):
            try container.encode("dialogueRepeat", forKey: .kind)
            try container.encode(dialogue, forKey: .dialogue)
            try container.encode(title, forKey: .title)
        case .quizChineseToTranslation:
            try container.encode("quizChineseToTranslation", forKey: .kind)
        case .quizTranslationToChinese:
            try container.encode("quizTranslationToChinese", forKey: .kind)
        case .examples(let items):
            try container.encode("examples", forKey: .kind)
            try container.encode(items, forKey: .items)
        case .completion:
            try container.encode("completion", forKey: .kind)
        }
    }
}

struct PathVocabularyGroup: Codable, Equatable, Identifiable {
    let id: String
    let title: PathLocalizedText
    let items: [PathVocabularyItem]
}

struct PathDialogue: Codable, Equatable, Identifiable {
    let id: String
    let title: String?
    let lines: [PathDialogueLine]
}

struct PathDialogueLine: Codable, Equatable, Identifiable {
    var id: String { "\(speaker ?? "line")-\(hanzi)" }
    let speaker: String?
    let hanzi: String
    let pinyin: String
    let translation: PathLocalizedText?
    let audioKey: String?

    var speechText: String {
        hanzi.trimmingCharacters(in: CharacterSet(charactersIn: "！？。，、"))
    }

    var displayTranslation: String? {
        translation?.localizedValueOrNil()
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        speaker = try container.decodeIfPresent(String.self, forKey: .speaker)
        hanzi = try container.decode(String.self, forKey: .hanzi)
        pinyin = try container.decode(String.self, forKey: .pinyin)
        translation = PathLocalizedText.sanitized(
            try container.decodeIfPresent(PathLocalizedText.self, forKey: .translation)
        )
        audioKey = try container.decodeIfPresent(String.self, forKey: .audioKey)
    }

    private enum CodingKeys: String, CodingKey {
        case speaker, hanzi, pinyin, translation, audioKey
    }

    fileprivate static func sanitizedTranslation(_ raw: String?) -> String? {
        guard let raw else { return nil }
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        if trimmed.uppercased().hasPrefix("TODO") { return nil }
        return trimmed
    }
}

struct PathVocabularyItem: Codable, Equatable, Identifiable {
    let id: String
    let hanzi: String
    let pinyin: String
    let translation: PathLocalizedText
    let audioKey: String?
    let countsInLessonTotal: Bool
    let isPhraseExample: Bool

    var speechText: String { hanzi }

    var displayLabel: String {
        "\(hanzi) — \(pinyin) — \(localizedTranslation)"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        hanzi = try container.decode(String.self, forKey: .hanzi)
        pinyin = try container.decode(String.self, forKey: .pinyin)
        translation = try container.decode(PathLocalizedText.self, forKey: .translation)
        audioKey = try container.decodeIfPresent(String.self, forKey: .audioKey)
        countsInLessonTotal = try container.decodeIfPresent(Bool.self, forKey: .countsInLessonTotal) ?? true
        isPhraseExample = try container.decodeIfPresent(Bool.self, forKey: .isPhraseExample) ?? false
    }

    private enum CodingKeys: String, CodingKey {
        case id, hanzi, pinyin, translation, audioKey, countsInLessonTotal, isPhraseExample
    }
}

struct PathExample: Codable, Equatable, Identifiable {
    let id: String
    let hanzi: String
    let pinyin: String
    let translation: PathLocalizedText?
    let group: String?

    init(
        id: String,
        hanzi: String,
        pinyin: String,
        translation: PathLocalizedText? = nil,
        group: String? = nil
    ) {
        self.id = id
        self.hanzi = hanzi
        self.pinyin = pinyin
        self.translation = translation
        self.group = group
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        hanzi = try container.decode(String.self, forKey: .hanzi)
        pinyin = try container.decode(String.self, forKey: .pinyin)
        translation = PathLocalizedText.sanitized(
            try container.decodeIfPresent(PathLocalizedText.self, forKey: .translation)
        )
        group = try container.decodeIfPresent(String.self, forKey: .group)
    }

    private enum CodingKeys: String, CodingKey {
        case id, hanzi, pinyin, translation, group
    }

    var speechText: String {
        hanzi.trimmingCharacters(in: CharacterSet(charactersIn: "！？。，、"))
    }

    var hasTranslation: Bool {
        localizedTranslation != nil
    }
}

enum PathResolvedStep: Equatable {
    case dialogue(PathDialogue, continueTitle: String, showLessonHeader: Bool)
    case transition(String)
    case vocabularyItem(PathVocabularyItem, groupTitle: String, index: Int, total: Int)
    case vocabularySummary([PathVocabularyGroup])
    case dialogueRepeat(PathDialogue, title: String)
    case quizChineseToTranslation
    case quizTranslationToChinese
    case examples
    case completion
}

enum PathLessonStatus: Equatable {
    case notStarted
    case inProgress
    case completed
}

struct PathLessonProgress: Codable, Equatable {
    var lessonID: String
    var stepIndex: Int
    var quizChineseIndex: Int
    var quizTranslationIndex: Int
    var exampleIndex: Int
    var chineseQuizResults: [String: Bool]
    var translationQuizResults: [String: Bool]
    var isCompleted: Bool
    var completedAt: Date?

    static func fresh(lessonID: String) -> PathLessonProgress {
        PathLessonProgress(
            lessonID: lessonID,
            stepIndex: 0,
            quizChineseIndex: 0,
            quizTranslationIndex: 0,
            exampleIndex: 0,
            chineseQuizResults: [:],
            translationQuizResults: [:],
            isCompleted: false,
            completedAt: nil
        )
    }
}

struct PathCourseProgress: Codable, Equatable {
    var currentLessonID: String?
    var lessonProgress: [String: PathLessonProgress]

    static let empty = PathCourseProgress(currentLessonID: nil, lessonProgress: [:])
}

enum PathLessonFlowResolver {

    static func resolve(_ lesson: PathLesson) -> [PathResolvedStep] {
        var steps: [PathResolvedStep] = []

        for section in lesson.sections {
            switch section {
            case .dialogue(let dialogue, let continueTitle, let showHeader):
                steps.append(
                    .dialogue(
                        dialogue,
                        continueTitle: PathLessonContentLocalizer.localized(continueTitle),
                        showLessonHeader: showHeader
                    )
                )

            case .vocabulary(let group):
                for (index, item) in group.items.enumerated() {
                    steps.append(
                        .vocabularyItem(
                            item,
                            groupTitle: group.localizedTitle,
                            index: index,
                            total: group.items.count
                        )
                    )
                }

            case .transition(let text):
                steps.append(.transition(PathLessonContentLocalizer.localized(text)))

            case .vocabularySummary(let groups):
                steps.append(.vocabularySummary(groups))

            case .dialogueRepeat(let dialogue, let title):
                steps.append(.dialogueRepeat(dialogue, title: PathLessonContentLocalizer.localized(title)))

            case .quizChineseToTranslation:
                steps.append(.quizChineseToTranslation)

            case .quizTranslationToChinese:
                steps.append(.quizTranslationToChinese)

            case .examples:
                steps.append(.examples)

            case .completion:
                steps.append(.completion)
            }
        }

        return steps
    }
}
