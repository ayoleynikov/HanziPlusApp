//
//  DailyLessonModels.swift
//  HanziPlus
//

import Foundation

enum DailyLessonPhase: String, Codable, CaseIterable {
    case preview
    case meaning
    case listening
    case summary
    case reviewMistakes
}

enum DailyLessonStatus: Equatable {
    case notStarted
    case inProgress
    case complete
}

struct DailyLessonAnswerRecord: Codable, Equatable {
    var meaningCorrect: Bool?
    var listeningCorrect: Bool?
    var reviewMeaningCorrect: Bool?
}

struct DailyLessonSession: Codable, Equatable {
    var dateKey: String
    var lessonID: String
    var fileName: String
    var wordHanzi: [String]
    var isReviewLesson: Bool
    var phase: DailyLessonPhase
    var currentIndex: Int
    var answers: [String: DailyLessonAnswerRecord]
    var completed: Bool
    var completedAt: Date?
    var profileSignature: String

    var wordCount: Int { wordHanzi.count }

    var progressFraction: Double {
        guard !wordHanzi.isEmpty else { return 0 }
        switch phase {
        case .preview:
            return Double(currentIndex) / Double(wordHanzi.count * 3 + 1)
        case .meaning:
            return Double(wordHanzi.count + currentIndex) / Double(wordHanzi.count * 3 + 1)
        case .listening:
            return Double(wordHanzi.count * 2 + currentIndex) / Double(wordHanzi.count * 3 + 1)
        case .summary, .reviewMistakes:
            return 1
        }
    }

    func mistakeHanzi() -> [String] {
        wordHanzi.filter { hanzi in
            let record = answers[hanzi]
            let meaningBad = record?.meaningCorrect == false
            let listeningBad = record?.listeningCorrect == false
            return meaningBad || listeningBad
        }
    }

    func meaningAccuracy() -> Double {
        let graded = wordHanzi.compactMap { answers[$0]?.meaningCorrect }
        guard !graded.isEmpty else { return 0 }
        return Double(graded.filter { $0 }.count) / Double(graded.count)
    }

    func listeningAccuracy() -> Double {
        let graded = wordHanzi.compactMap { answers[$0]?.listeningCorrect }
        guard !graded.isEmpty else { return 0 }
        return Double(graded.filter { $0 }.count) / Double(graded.count)
    }

    func isFullyCorrect(hanzi: String) -> Bool {
        answers[hanzi]?.meaningCorrect == true && answers[hanzi]?.listeningCorrect == true
    }
}

enum DailyLessonPlanner {

    static func dateKey(for date: Date = .now, calendar: Calendar = .current) -> String {
        let comps = calendar.dateComponents([.year, .month, .day], from: date)
        return String(format: "%04d-%02d-%02d", comps.year ?? 0, comps.month ?? 0, comps.day ?? 0)
    }

    static func profileSignature(profile: UserProfile, fileName: String) -> String {
        "\(profile.primaryGoal.rawValue)|\(profile.chineseLevel.rawValue)|\(profile.dailyMinutes.rawValue)|\(fileName)"
    }

    static func recommendedFileName(for profile: UserProfile) -> String {
        switch profile.primaryGoal {
        case .travelToChina:
            return SampleStudySets.travel.fileName
        case .learnChinese, .both:
            return profile.chineseLevel.recommendedStudySet.fileName
        }
    }

    static func targetWordCount(for profile: UserProfile) -> Int {
        profile.dailyMinutes.lessonWordCount
    }

    /// Deterministic word selection for a given day.
    static func selectWords(
        fileName: String,
        targetCount: Int,
        learnedHanzi: Set<String>,
        dateKey: String,
        allWords: [Word]
    ) -> (hanzi: [String], isReviewLesson: Bool) {
        guard !allWords.isEmpty else { return ([], true) }

        let ordered = allWords.map(\.hanzi)
        let unlearned = ordered.filter { !learnedHanzi.contains($0) }
        let learned = ordered.filter { learnedHanzi.contains($0) }

        let seed = stableSeed("\(dateKey)|\(fileName)|\(targetCount)")

        if unlearned.isEmpty {
            let reviewPool = seededShuffle(learned.isEmpty ? ordered : learned, seed: seed)
            return (Array(reviewPool.prefix(min(targetCount, reviewPool.count))), true)
        }

        var selected: [String] = []
        let fresh = seededShuffle(unlearned, seed: seed)
        selected.append(contentsOf: fresh.prefix(targetCount))

        if selected.count < targetCount {
            let reviewFill = seededShuffle(learned, seed: seed &+ 17)
            for hanzi in reviewFill where !selected.contains(hanzi) {
                selected.append(hanzi)
                if selected.count == targetCount { break }
            }
        }

        if selected.count < targetCount {
            let extras = seededShuffle(ordered, seed: seed &+ 31)
            for hanzi in extras where !selected.contains(hanzi) {
                selected.append(hanzi)
                if selected.count == targetCount { break }
            }
        }

        return (selected, false)
    }

    static func englishOptions(
        correct: Word,
        pool: [Word],
        dateKey: String,
        count: Int = 4
    ) -> [String] {
        let language = LocalizedContent.currentLanguage
        let correctValue = correct.localizedTranslation(for: language)
        return uniqueOptions(
            correct: correctValue,
            candidates: pool
                .map { $0.localizedTranslation(for: language) }
                .filter { $0 != correctValue },
            seed: stableSeed("\(dateKey)|en|\(correct.hanzi)|\(language.rawValue)"),
            count: count
        )
    }

    static func hanziOptions(
        correct: Word,
        pool: [Word],
        dateKey: String,
        count: Int = 4
    ) -> [String] {
        uniqueOptions(
            correct: correct.hanzi,
            candidates: pool.map(\.hanzi).filter { $0 != correct.hanzi },
            seed: stableSeed("\(dateKey)|zh|\(correct.hanzi)"),
            count: count
        )
    }

    private static func uniqueOptions(
        correct: String,
        candidates: [String],
        seed: UInt64,
        count: Int
    ) -> [String] {
        var uniqueCandidates: [String] = []
        var seen = Set<String>()
        for value in seededShuffle(candidates, seed: seed) {
            if seen.insert(value).inserted {
                uniqueCandidates.append(value)
            }
            if uniqueCandidates.count >= max(0, count - 1) { break }
        }

        var options = uniqueCandidates
        options.append(correct)
        // Ensure uniqueness even if pool was tiny / duplicates existed.
        var final: [String] = []
        var finalSeen = Set<String>()
        for value in seededShuffle(options, seed: seed &+ 99) {
            if finalSeen.insert(value).inserted {
                final.append(value)
            }
        }
        if !final.contains(correct) {
            final.append(correct)
        }
        return Array(final.prefix(count))
    }

    static func stableSeed(_ string: String) -> UInt64 {
        var hash: UInt64 = 5381
        for byte in string.utf8 {
            hash = ((hash << 5) &+ hash) &+ UInt64(byte)
        }
        return hash == 0 ? 1 : hash
    }

    static func seededShuffle<T>(_ input: [T], seed: UInt64) -> [T] {
        guard input.count > 1 else { return input }
        var result = input
        var state = seed
        for i in stride(from: result.count - 1, through: 1, by: -1) {
            state = state &* 6364136223846793005 &+ 1
            let j = Int(state % UInt64(i + 1))
            result.swapAt(i, j)
        }
        return result
    }
}
