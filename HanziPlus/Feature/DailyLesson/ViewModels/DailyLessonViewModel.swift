//
//  DailyLessonViewModel.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
final class DailyLessonViewModel {

    private(set) var session: DailyLessonSession
    private(set) var wordsByHanzi: [String: Word]
    private(set) var pool: [Word]

    private(set) var selectedAnswer: String?
    private(set) var showFeedback = false
    private(set) var lastAnswerCorrect = false
    private(set) var cachedMeaningOptions: [String] = []

    private let lessonStore: DailyLessonStore
    private let learnedStore: LearnedWordsStore
    private let smartReviewStore: SmartReviewStore

    init(
        lessonStore: DailyLessonStore,
        learnedStore: LearnedWordsStore,
        smartReviewStore: SmartReviewStore,
        profile: UserProfile
    ) {
        self.lessonStore = lessonStore
        self.learnedStore = learnedStore
        self.smartReviewStore = smartReviewStore

        let ensured = lessonStore.todaySession
            ?? lessonStore.ensureTodaySession(profile: profile, learnedStore: learnedStore)
        self.session = ensured

        let loaded = WordLoader.load(fileName: ensured.fileName)
        self.pool = loaded
        self.wordsByHanzi = Dictionary(uniqueKeysWithValues: loaded.map { ($0.hanzi, $0) })
        refreshMeaningOptions()
    }

    var studySet: StudySet {
        SampleStudySets.studySet(fileName: session.fileName) ?? SampleStudySets.hsk1
    }

    var currentWord: Word? {
        guard session.wordHanzi.indices.contains(session.currentIndex) else { return nil }
        return wordsByHanzi[session.wordHanzi[session.currentIndex]]
    }

    var phaseTitle: String {
        switch session.phase {
        case .preview: L10n.string( "lesson.phase.preview")
        case .meaning: L10n.string( "lesson.phase.meaning")
        case .summary: L10n.string( "lesson.phase.summary")
        }
    }

    var statusText: String {
        if session.completed { return L10n.string( "lesson.card.status.complete") }
        if session.phase == .preview && session.currentIndex == 0 && session.answers.isEmpty {
            return L10n.string( "lesson.card.status.not_started")
        }
        return L10n.string( "lesson.card.status.in_progress")
    }

    var meaningOptions: [String] {
        cachedMeaningOptions
    }

    var mistakeWords: [Word] {
        session.mistakeHanzi().compactMap { wordsByHanzi[$0] }
    }

    var newlyLearnedCount: Int {
        session.wordHanzi.filter { session.isFullyCorrect(hanzi: $0) }.count
    }

    func advanceFromPreview() {
        guard session.phase == .preview else { return }
        clearFeedback()
        if session.currentIndex + 1 < session.wordHanzi.count {
            mutate { $0.currentIndex += 1 }
        } else {
            mutate {
                $0.phase = .meaning
                $0.currentIndex = 0
            }
            refreshMeaningOptions()
        }
    }

    func selectMeaning(_ answer: String) {
        guard session.phase == .meaning,
              let word = currentWord,
              selectedAnswer == nil
        else { return }

        let correct = answer == word.localizedMeaning
        selectedAnswer = answer
        showFeedback = true
        lastAnswerCorrect = correct
        HapticService.light()

        mutate { session in
            var record = session.answers[word.hanzi] ?? DailyLessonAnswerRecord()
            record.meaningCorrect = correct
            session.answers[word.hanzi] = record
        }
        smartReviewStore.recordAttempt(
            fileName: session.fileName,
            hanzi: word.hanzi,
            correct: correct
        )
        if correct {
            _ = learnedStore.markLearned(fileName: session.fileName, hanzi: word.hanzi)
        }
    }

    func continueAfterMeaning() {
        guard showFeedback else { return }
        clearFeedback()

        if session.currentIndex + 1 < session.wordHanzi.count {
            mutate { $0.currentIndex += 1 }
            refreshMeaningOptions()
        } else {
            completeLesson()
        }
    }

    func completeLesson() {
        mutate {
            $0.phase = .summary
            $0.completed = true
            $0.completedAt = Date()
            $0.currentIndex = 0
        }
        HapticService.success()
    }

    private func clearFeedback() {
        selectedAnswer = nil
        showFeedback = false
        lastAnswerCorrect = false
    }

    private func refreshMeaningOptions() {
        guard let word = currentWord else {
            cachedMeaningOptions = []
            return
        }
        cachedMeaningOptions = DailyLessonPlanner.englishOptions(
            correct: word,
            pool: pool,
            dateKey: session.dateKey
        )
    }

    private func mutate(_ transform: (inout DailyLessonSession) -> Void) {
        var copy = session
        transform(&copy)
        session = copy
        lessonStore.replace(copy)
    }
}
