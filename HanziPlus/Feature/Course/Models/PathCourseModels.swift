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

struct PathLessonDestination: Hashable {
    let lessonID: String
    var autoResumeChapter: Bool = false
}

enum LearnDestination: Hashable {
    case pathCourse
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
    let chapters: [PathLessonChapter]

    var sections: [PathLessonSection] {
        chapters.flatMap(\.sections)
    }

    init(
        id: String,
        number: Int,
        sourceLessonNumbers: [Int],
        chineseTitle: String,
        chineseSubtitle: String?,
        pinyinTitle: String?,
        translationTitle: PathLocalizedText?,
        chapters: [PathLessonChapter]
    ) {
        self.id = id
        self.number = number
        self.sourceLessonNumbers = sourceLessonNumbers
        self.chineseTitle = chineseTitle
        self.chineseSubtitle = chineseSubtitle
        self.pinyinTitle = pinyinTitle
        self.translationTitle = translationTitle
        self.chapters = chapters
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

        let resolvedChapters: [PathLessonChapter]
        if let decodedChapters = try container.decodeIfPresent([PathLessonChapter].self, forKey: .chapters),
           !decodedChapters.isEmpty {
            var filled: [PathLessonChapter] = []
            filled.reserveCapacity(decodedChapters.count)
            for chapter in decodedChapters {
                filled.append(chapter.enriching(lessonNumber: number))
            }
            resolvedChapters = filled
        } else {
            let legacySections = try container.decode([PathLessonSection].self, forKey: .sections)
            resolvedChapters = PathLessonChapterSplitter.split(
                lessonID: id,
                lessonNumber: number,
                sections: legacySections
            )
        }
        chapters = resolvedChapters
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(number, forKey: .number)
        try container.encode(sourceLessonNumbers, forKey: .sourceLessonNumbers)
        try container.encode(chineseTitle, forKey: .chineseTitle)
        try container.encodeIfPresent(chineseSubtitle, forKey: .chineseSubtitle)
        try container.encodeIfPresent(pinyinTitle, forKey: .pinyinTitle)
        try container.encodeIfPresent(translationTitle, forKey: .translationTitle)
        try container.encode(chapters, forKey: .chapters)
        try container.encode(sections, forKey: .sections)
    }

    private enum CodingKeys: String, CodingKey {
        case id, number, sourceLessonNumbers, chineseTitle, chineseSubtitle, pinyinTitle
        case translationTitle, sections, chapters
    }

    func chapter(withID chapterID: String) -> PathLessonChapter? {
        chapters.first { $0.id == chapterID }
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
        var seen = Set<String>()
        return sections.compactMap { section -> PathDialogue? in
            let dialogue: PathDialogue?
            switch section {
            case .dialogue(let value, _, _):
                dialogue = value
            case .dialogueRepeat(let value, _):
                dialogue = value
            default:
                dialogue = nil
            }
            guard let dialogue, seen.insert(dialogue.id).inserted else { return nil }
            return dialogue
        }
    }

    var examples: [PathExample] {
        chapters.flatMap(\.examplesInSections)
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
    case toneGuide(PathToneGuide)
    case grammar(PathGrammarCard)
    case sentenceBuilder(PathSentenceBuilderActivity)
    case fillBlank(PathFillBlankActivity)
    case dialogueOrder(PathDialogueOrderActivity)
    case quizChineseToTranslation
    case quizTranslationToChinese
    case examples([PathExample])
    case mistakeReview
    case chapterComplete
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
        case toneGuide
        case grammar
        case activity
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
        case "toneGuide":
            self = .toneGuide(try container.decode(PathToneGuide.self, forKey: .toneGuide))
        case "grammar":
            self = .grammar(try container.decode(PathGrammarCard.self, forKey: .grammar))
        case "sentenceBuilder":
            self = .sentenceBuilder(try container.decode(PathSentenceBuilderActivity.self, forKey: .activity))
        case "fillBlank":
            self = .fillBlank(try container.decode(PathFillBlankActivity.self, forKey: .activity))
        case "dialogueOrder":
            self = .dialogueOrder(try container.decode(PathDialogueOrderActivity.self, forKey: .activity))
        case "quizChineseToTranslation":
            self = .quizChineseToTranslation
        case "quizTranslationToChinese":
            self = .quizTranslationToChinese
        case "examples":
            let items = try container.decode([PathExample].self, forKey: .items)
            self = .examples(items)
        case "mistakeReview":
            self = .mistakeReview
        case "chapterComplete":
            self = .chapterComplete
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
        case .toneGuide(let guide):
            try container.encode("toneGuide", forKey: .kind)
            try container.encode(guide, forKey: .toneGuide)
        case .grammar(let card):
            try container.encode("grammar", forKey: .kind)
            try container.encode(card, forKey: .grammar)
        case .sentenceBuilder(let activity):
            try container.encode("sentenceBuilder", forKey: .kind)
            try container.encode(activity, forKey: .activity)
        case .fillBlank(let activity):
            try container.encode("fillBlank", forKey: .kind)
            try container.encode(activity, forKey: .activity)
        case .dialogueOrder(let activity):
            try container.encode("dialogueOrder", forKey: .kind)
            try container.encode(activity, forKey: .activity)
        case .quizChineseToTranslation:
            try container.encode("quizChineseToTranslation", forKey: .kind)
        case .quizTranslationToChinese:
            try container.encode("quizTranslationToChinese", forKey: .kind)
        case .examples(let items):
            try container.encode("examples", forKey: .kind)
            try container.encode(items, forKey: .items)
        case .mistakeReview:
            try container.encode("mistakeReview", forKey: .kind)
        case .chapterComplete:
            try container.encode("chapterComplete", forKey: .kind)
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
    case toneGuide(PathToneGuide)
    case dialogue(PathDialogue, continueTitle: String, showLessonHeader: Bool)
    case transition(String)
    case vocabularyItem(PathVocabularyItem, groupTitle: String, index: Int, total: Int)
    case vocabularySummary([PathVocabularyGroup])
    case dialogueRepeat(PathDialogue, title: String)
    case grammar(PathGrammarCard)
    case sentenceBuilder(PathSentenceBuilderActivity)
    case fillBlank(PathFillBlankActivity)
    case dialogueOrder(PathDialogueOrderActivity)
    case quizChineseToTranslation
    case quizTranslationToChinese
    case examples
    case mistakeReview
    case chapterComplete
    case completion
}

enum PathLessonStatus: Equatable {
    case notStarted
    case inProgress
    case completed
}

struct PathLessonProgress: Codable, Equatable {
    var lessonID: String
    var currentChapterID: String?
    var stepIndex: Int
    var quizChineseIndex: Int
    var quizTranslationIndex: Int
    var exampleIndex: Int
    var activityIndex: Int
    var chineseQuizResults: [String: Bool]
    var translationQuizResults: [String: Bool]
    var chapterProgress: [String: PathChapterProgress]
    var pendingMistakes: [PathCourseMistake]
    var isCompleted: Bool
    var completedAt: Date?

    static func fresh(lessonID: String) -> PathLessonProgress {
        PathLessonProgress(
            lessonID: lessonID,
            currentChapterID: nil,
            stepIndex: 0,
            quizChineseIndex: 0,
            quizTranslationIndex: 0,
            exampleIndex: 0,
            activityIndex: 0,
            chineseQuizResults: [:],
            translationQuizResults: [:],
            chapterProgress: [:],
            pendingMistakes: [],
            isCompleted: false,
            completedAt: nil
        )
    }

    init(
        lessonID: String,
        currentChapterID: String?,
        stepIndex: Int,
        quizChineseIndex: Int,
        quizTranslationIndex: Int,
        exampleIndex: Int,
        activityIndex: Int,
        chineseQuizResults: [String: Bool],
        translationQuizResults: [String: Bool],
        chapterProgress: [String: PathChapterProgress],
        pendingMistakes: [PathCourseMistake],
        isCompleted: Bool,
        completedAt: Date?
    ) {
        self.lessonID = lessonID
        self.currentChapterID = currentChapterID
        self.stepIndex = stepIndex
        self.quizChineseIndex = quizChineseIndex
        self.quizTranslationIndex = quizTranslationIndex
        self.exampleIndex = exampleIndex
        self.activityIndex = activityIndex
        self.chineseQuizResults = chineseQuizResults
        self.translationQuizResults = translationQuizResults
        self.chapterProgress = chapterProgress
        self.pendingMistakes = pendingMistakes
        self.isCompleted = isCompleted
        self.completedAt = completedAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lessonID = try container.decode(String.self, forKey: .lessonID)
        currentChapterID = try container.decodeIfPresent(String.self, forKey: .currentChapterID)
        stepIndex = try container.decodeIfPresent(Int.self, forKey: .stepIndex) ?? 0
        quizChineseIndex = try container.decodeIfPresent(Int.self, forKey: .quizChineseIndex) ?? 0
        quizTranslationIndex = try container.decodeIfPresent(Int.self, forKey: .quizTranslationIndex) ?? 0
        exampleIndex = try container.decodeIfPresent(Int.self, forKey: .exampleIndex) ?? 0
        activityIndex = try container.decodeIfPresent(Int.self, forKey: .activityIndex) ?? 0
        chineseQuizResults = try container.decodeIfPresent([String: Bool].self, forKey: .chineseQuizResults) ?? [:]
        translationQuizResults = try container.decodeIfPresent([String: Bool].self, forKey: .translationQuizResults) ?? [:]
        chapterProgress = try container.decodeIfPresent([String: PathChapterProgress].self, forKey: .chapterProgress) ?? [:]
        pendingMistakes = try container.decodeIfPresent([PathCourseMistake].self, forKey: .pendingMistakes) ?? []
        isCompleted = try container.decodeIfPresent(Bool.self, forKey: .isCompleted) ?? false
        completedAt = try container.decodeIfPresent(Date.self, forKey: .completedAt)
    }

    private enum CodingKeys: String, CodingKey {
        case lessonID, currentChapterID, stepIndex, quizChineseIndex, quizTranslationIndex
        case exampleIndex, activityIndex, chineseQuizResults, translationQuizResults
        case chapterProgress, pendingMistakes, isCompleted, completedAt
    }
}

struct PathCourseProgress: Codable, Equatable {
    var schemaVersion: Int
    var currentLessonID: String?
    var lessonProgress: [String: PathLessonProgress]

    static let currentSchemaVersion = 3
    static let empty = PathCourseProgress(schemaVersion: currentSchemaVersion, currentLessonID: nil, lessonProgress: [:])

    init(schemaVersion: Int = currentSchemaVersion, currentLessonID: String?, lessonProgress: [String: PathLessonProgress]) {
        self.schemaVersion = schemaVersion
        self.currentLessonID = currentLessonID
        self.lessonProgress = lessonProgress
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        schemaVersion = try container.decodeIfPresent(Int.self, forKey: .schemaVersion) ?? 2
        currentLessonID = try container.decodeIfPresent(String.self, forKey: .currentLessonID)
        let rawProgress = try container.decode([String: PathLessonProgress].self, forKey: .lessonProgress)
        lessonProgress = PathCourseProgressMigration.migrateLessonProgress(rawProgress, schemaVersion: schemaVersion)
        schemaVersion = PathCourseProgress.currentSchemaVersion
    }

    private enum CodingKeys: String, CodingKey {
        case schemaVersion, currentLessonID, lessonProgress
    }
}

enum PathLessonFlowResolver {

    static func resolve(_ lesson: PathLesson) -> [PathResolvedStep] {
        lesson.chapters.flatMap { resolveChapter($0, lesson: lesson) }
    }

    static func resolveChapter(_ chapter: PathLessonChapter, lesson: PathLesson) -> [PathResolvedStep] {
        var steps: [PathResolvedStep] = []

        if let toneGuide = chapter.toneGuide {
            steps.append(.toneGuide(toneGuide))
        }

        for section in chapter.sections {
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

            case .toneGuide(let guide):
                steps.append(.toneGuide(guide))

            case .grammar(let card):
                steps.append(.grammar(card))

            case .sentenceBuilder(let activity):
                steps.append(.sentenceBuilder(activity))

            case .fillBlank(let activity):
                steps.append(.fillBlank(activity))

            case .dialogueOrder(let activity):
                steps.append(.dialogueOrder(activity))

            case .quizChineseToTranslation, .quizTranslationToChinese, .examples, .completion,
                 .mistakeReview, .chapterComplete:
                break
            }
        }

        if let grammar = chapter.grammarCard,
           !steps.contains(where: { if case .grammar = $0 { return true }; return false }) {
            if let practiceIndex = steps.firstIndex(where: { isPracticeBoundary($0) }) {
                steps.insert(.grammar(grammar), at: practiceIndex)
            } else {
                steps.append(.grammar(grammar))
            }
        }

        let practiceInsertIndex = steps.firstIndex(where: { isPracticeBoundary($0) }) ?? steps.count
        var activitySteps: [PathResolvedStep] = []
        for activity in chapter.activities {
            switch activity {
            case .sentenceBuilder(let value):
                activitySteps.append(.sentenceBuilder(value))
            case .fillBlank(let value):
                activitySteps.append(.fillBlank(value))
            case .dialogueOrder(let value):
                activitySteps.append(.dialogueOrder(value))
            }
        }
        if !activitySteps.isEmpty {
            steps.insert(contentsOf: activitySteps, at: min(practiceInsertIndex, steps.count))
        }

        let hasQuiz = chapter.hasQuizableVocabulary
        let hasChineseQuiz = chapter.sections.contains { if case .quizChineseToTranslation = $0 { return true }; return false }
        let hasTranslationQuiz = chapter.sections.contains { if case .quizTranslationToChinese = $0 { return true }; return false }

        if hasQuiz {
            if hasChineseQuiz { steps.append(.quizChineseToTranslation) }
            if hasTranslationQuiz { steps.append(.quizTranslationToChinese) }
        }

        if !chapter.examplesInSections.isEmpty {
            steps.append(.examples)
        }

        steps.append(.mistakeReview)

        if chapter.number == lesson.chapters.count {
            steps.append(.completion)
        } else {
            steps.append(.chapterComplete)
        }

        return steps
    }

    private static func isPracticeBoundary(_ step: PathResolvedStep) -> Bool {
        switch step {
        case .quizChineseToTranslation, .quizTranslationToChinese, .examples, .mistakeReview:
            return true
        default:
            return false
        }
    }
}

private extension PathResolvedStep {
    var id: String {
        switch self {
        case .toneGuide(let guide): return guide.id
        case .dialogue(let dialogue, _, _): return dialogue.id
        case .transition: return "transition"
        case .vocabularyItem(let item, _, _, _): return item.id
        case .vocabularySummary: return "vocabularySummary"
        case .dialogueRepeat(let dialogue, _): return dialogue.id + "_repeat"
        case .grammar(let card): return card.id
        case .sentenceBuilder(let activity): return activity.id
        case .fillBlank(let activity): return activity.id
        case .dialogueOrder(let activity): return activity.id
        case .quizChineseToTranslation: return "quizChinese"
        case .quizTranslationToChinese: return "quizTranslation"
        case .examples: return "examples"
        case .mistakeReview: return "mistakeReview"
        case .chapterComplete: return "chapterComplete"
        case .completion: return "completion"
        }
    }
}
