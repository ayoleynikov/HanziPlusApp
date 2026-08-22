//
//  HanziMemoryViewModel.swift
//  HanziPlus
//

import Foundation
import Observation

enum MemoryMatchMode: String, CaseIterable, Identifiable, Codable {
    case chineseEnglish
    case chinesePinyin
    case chineseAudio
    case englishChinese

    var id: String { rawValue }

    var label: String {
        switch self {
        case .chineseEnglish: "Chinese ↔ English"
        case .chinesePinyin: "Chinese ↔ Pinyin"
        case .chineseAudio: "Chinese ↔ Audio"
        case .englishChinese: "English ↔ Chinese"
        }
    }

    var isAvailable: Bool {
        switch self {
        case .chineseAudio: false
        default: true
        }
    }
}

struct MemoryCard: Identifiable {
    let id = UUID()
    let pairID: UUID
    let word: Word
    let face: MemoryCardFace
    var isFaceUp = false
    var isMatched = false

    enum MemoryCardFace: Equatable {
        case hanzi
        case english
        case pinyin
        case audio
    }

    var displayText: String {
        switch face {
        case .hanzi: word.hanzi
        case .english: word.english
        case .pinyin: word.pinyin
        case .audio: "🔊"
        }
    }
}

@Observable
final class HanziMemoryViewModel: GameSession {

    let studySet: StudySet
    let gameKind: GameKind = .hanziMemory
    let difficulty: GameDifficulty
    let matchMode: MemoryMatchMode

    private(set) var cards: [MemoryCard] = []
    private(set) var flippedIndices: [Int] = []
    private(set) var moves = 0
    private(set) var matchedPairs = 0
    private(set) var wrongCount = 0
    private(set) var isBusy = false
    private(set) var isFinished = false
    private(set) var result: GameResult?

    private var startedAt = Date()
    private let pairCount: Int

    init(studySet: StudySet, difficulty: GameDifficulty = .medium, matchMode: MemoryMatchMode = .chineseEnglish) {
        self.studySet = studySet
        self.difficulty = difficulty
        self.matchMode = matchMode
        self.pairCount = difficulty.memoryPairCount
        buildCards()
    }

    var totalPairs: Int { pairCount }

    var progress: Double {
        guard totalPairs > 0 else { return 0 }
        return Double(matchedPairs) / Double(totalPairs)
    }

    func flip(at index: Int) {
        guard cards.indices.contains(index), !isBusy else { return }
        guard !cards[index].isMatched, !cards[index].isFaceUp else { return }
        guard flippedIndices.count < 2 else { return }

        cards[index].isFaceUp = true
        flippedIndices.append(index)

        if flippedIndices.count == 2 {
            moves += 1
            evaluatePair()
        }
    }

    func finish(scoreStore: GameScoreStore, statisticsStore: StatisticsStore, achievementStore: AchievementStore) {
        result = GameSessionRecorder.finish(
            gameKind: gameKind,
            studySetFileName: studySet.fileName,
            correct: matchedPairs,
            wrong: wrongCount,
            comboPeak: 1,
            streak: 0,
            elapsedSeconds: Int(Date().timeIntervalSince(startedAt)),
            scoreStore: scoreStore,
            statisticsStore: statisticsStore,
            achievementStore: achievementStore
        )
        isFinished = true
    }

    func restart() {
        startedAt = Date()
        moves = 0
        matchedPairs = 0
        wrongCount = 0
        flippedIndices = []
        isBusy = false
        isFinished = false
        result = nil
        buildCards()
    }

    private func buildCards() {
        let words = Array(GameWordProvider.words(for: studySet).prefix(pairCount))
        var built: [MemoryCard] = []

        for word in words {
            let pairID = UUID()
            built.append(MemoryCard(pairID: pairID, word: word, face: .hanzi))
            built.append(MemoryCard(pairID: pairID, word: word, face: secondaryFace))
        }

        cards = built.shuffled()
    }

    private var secondaryFace: MemoryCard.MemoryCardFace {
        switch matchMode {
        case .chineseEnglish, .englishChinese: .english
        case .chinesePinyin: .pinyin
        case .chineseAudio: .audio
        }
    }

    private func evaluatePair() {
        guard flippedIndices.count == 2 else { return }
        isBusy = true

        let first = cards[flippedIndices[0]]
        let second = cards[flippedIndices[1]]
        let isMatch = first.pairID == second.pairID

        if isMatch {
            matchedPairs += 1
            for index in flippedIndices {
                cards[index].isMatched = true
            }
            flippedIndices = []
            isBusy = false
        } else {
            wrongCount += 1
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(0.65))
                for index in flippedIndices {
                    cards[index].isFaceUp = false
                }
                flippedIndices = []
                isBusy = false
            }
        }
    }
}
