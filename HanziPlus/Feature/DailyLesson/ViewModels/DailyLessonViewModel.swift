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

    private let lessonStore: DailyLessonStore
    private let learnedStore: LearnedWordsStore

    /// Words currently being reviewed in Review Mistakes.
    private(set) var reviewQueue: [String] = []

    init(
        lessonStore: DailyLessonStore,
        learnedStore: LearnedWordsStore,
        profile: UserProfile
    ) {
        self.lessonStore = lessonStore
        self.learnedStore = learnedStore

        let ensured = lessonStore.ensureTodaySession(profile: profile, learnedStore: learnedStore)
        self.session = ensured

        let loaded = WordLoader.load(fileName: ensured.fileName)
        self.pool = loaded
        self.wordsByHanzi = Dictionary(uniqueKeysWithValues: loaded.map { ($0.hanzi, $0) })
    }

    var studySet: StudySet {
        SampleStudySets.studySet(fileName: session.fileName) ?? SampleStudySets.hsk1
    }

    var currentWord: Word? {
        let list = session.phase == .reviewMistakes ? reviewQueue : session.wordHanzi
        guard list.indices.contains(session.currentIndex) else { return nil }
        return wordsByHanzi[list[session.currentIndex]]
    }

    var phaseTitle: String {
        switch session.phase {
        case .preview: "Preview"
        case .meaning: "Meaning"
        case .listening: "Listening"
        case .summary: "Summary"
        case .reviewMistakes: "Review Mistakes"
        }
    }

    var statusText: String {
        if session.completed { return "Complete" }
        if session.phase == .preview && session.currentIndex == 0 && session.answers.isEmpty {
            return "Not Started"
        }
        return "In Progress"
    }

    var meaningOptions: [String] {
        guard let word = currentWord else { return [] }
        return DailyLessonPlanner.englishOptions(
            correct: word,
            pool: pool,
            dateKey: session.dateKey
        )
    }

    var listeningOptions: [String] {
        guard let word = currentWord else { return [] }
        return DailyLessonPlanner.hanziOptions(
            correct: word,
            pool: pool,
            dateKey: session.dateKey
        )
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
        }
    }

    func selectMeaning(_ answer: String) {
        guard session.phase == .meaning || session.phase == .reviewMistakes,
              let word = currentWord,
              selectedAnswer == nil
        else { return }

        let correct = answer == word.english
        selectedAnswer = answer
        showFeedback = true
        lastAnswerCorrect = correct
        HapticService.light()

        if session.phase == .meaning {
            mutate { session in
                var record = session.answers[word.hanzi] ?? DailyLessonAnswerRecord()
                record.meaningCorrect = correct
                session.answers[word.hanzi] = record
            }
        } else {
            mutate { session in
                var record = session.answers[word.hanzi] ?? DailyLessonAnswerRecord()
                record.reviewMeaningCorrect = correct
                session.answers[word.hanzi] = record
            }
            if correct, session.answers[word.hanzi]?.listeningCorrect == true {
                _ = learnedStore.markLearned(fileName: session.fileName, hanzi: word.hanzi)
            }
        }
    }

    func continueAfterMeaning() {
        guard showFeedback else { return }
        clearFeedback()

        if session.phase == .reviewMistakes {
            advanceReviewQueue()
            return
        }

        if session.currentIndex + 1 < session.wordHanzi.count {
            mutate { $0.currentIndex += 1 }
        } else {
            mutate {
                $0.phase = .listening
                $0.currentIndex = 0
            }
        }
    }

    func selectListening(_ answer: String) {
        guard session.phase == .listening,
              let word = currentWord,
              selectedAnswer == nil
        else { return }

        let correct = answer == word.hanzi
        selectedAnswer = answer
        showFeedback = true
        lastAnswerCorrect = correct
        HapticService.light()

        mutate { session in
            var record = session.answers[word.hanzi] ?? DailyLessonAnswerRecord()
            record.listeningCorrect = correct
            session.answers[word.hanzi] = record
        }

        if correct, session.answers[word.hanzi]?.meaningCorrect == true {
            _ = learnedStore.markLearned(fileName: session.fileName, hanzi: word.hanzi)
            HapticService.success()
        }
    }

    func continueAfterListening() {
        guard showFeedback else { return }
        clearFeedback()

        if session.currentIndex + 1 < session.wordHanzi.count {
            mutate { $0.currentIndex += 1 }
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

    func startReviewMistakes() {
        let mistakes = session.mistakeHanzi()
        guard !mistakes.isEmpty else { return }
        reviewQueue = mistakes
        clearFeedback()
        mutate {
            $0.phase = .reviewMistakes
            $0.currentIndex = 0
        }
    }

    private func advanceReviewQueue() {
        if session.currentIndex + 1 < reviewQueue.count {
            mutate { $0.currentIndex += 1 }
        } else {
            mutate {
                $0.phase = .summary
                $0.currentIndex = 0
            }
            reviewQueue = []
        }
    }

    private func clearFeedback() {
        selectedAnswer = nil
        showFeedback = false
        lastAnswerCorrect = false
    }

    private func mutate(_ transform: (inout DailyLessonSession) -> Void) {
        var copy = session
        transform(&copy)
        session = copy
        lessonStore.replace(copy)
    }
}
