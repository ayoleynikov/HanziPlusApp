//
//  StudyViewModel.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import Foundation
import Observation

enum StudyNavigationDirection {
    case next
    case previous
}

@Observable
final class StudyViewModel {

    let studySet: StudySet
    let sessionKey: String
    let words: [Word]

    private(set) var currentIndex = 0
    private let sessionStore: StudySessionStore

    init(
        studySet: StudySet,
        studySection: StudySetSection? = nil,
        sessionStore: StudySessionStore
    ) {
        self.studySet = studySet
        self.sessionStore = sessionStore

        if let studySection {
            sessionKey = SectionedVocabulary.sessionKey(
                fileName: studySet.fileName,
                section: studySection
            )
        } else {
            sessionKey = studySet.fileName
        }

        let loadedWords = Self.loadWords(studySet: studySet, studySection: studySection)
        let restored = sessionStore.restoreWords(from: loadedWords, fileName: sessionKey)

        self.words = restored.words
        self.currentIndex = restored.words.isEmpty ? 0 : restored.index

        if !restored.words.isEmpty {
            sessionStore.setLastActive(sessionKey)
            persistSession()
        }
    }

    var hasWords: Bool {
        !words.isEmpty
    }

    var currentWord: Word? {
        guard hasWords, words.indices.contains(currentIndex) else { return nil }
        return words[currentIndex]
    }

    var sessionProgress: Double {
        guard !words.isEmpty else { return 0 }
        return Double(currentIndex + 1) / Double(words.count)
    }

    var canGoNext: Bool {
        currentIndex < words.count - 1
    }

    var canGoPrevious: Bool {
        currentIndex > 0
    }

    @discardableResult
    func go(to direction: StudyNavigationDirection) -> Bool {
        guard hasWords else { return false }

        switch direction {
        case .next:
            guard canGoNext else { return false }
            currentIndex += 1
            persistSession()
            return true

        case .previous:
            guard canGoPrevious else { return false }
            currentIndex -= 1
            persistSession()
            return true
        }
    }

    func persistSession() {
        guard hasWords else { return }

        sessionStore.save(
            fileName: sessionKey,
            wordOrder: words.map(\.hanzi),
            currentIndex: currentIndex
        )
        sessionStore.setLastActive(sessionKey)
    }

    private static func loadWords(studySet: StudySet, studySection: StudySetSection?) -> [Word] {
        let loadedWords = WordLoader.load(fileName: studySet.fileName)
        guard let studySection else { return loadedWords }
        return loadedWords.filter { $0.section == studySection.id }
    }
}
