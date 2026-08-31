//
//  GameRouter.swift
//  HanziPlus
//

import SwiftUI

enum GameRouter {

    @ViewBuilder
    static func destination(
        for game: GameDefinition,
        studySet: StudySet,
        difficulty: GameDifficulty = .medium,
        memoryMode: MemoryMatchMode? = nil
    ) -> some View {
        switch game.kind {
        case .matchPairs:
            MatchPairsView(studySet: studySet, difficulty: difficulty)
        case .speedChallenge:
            SpeedChallengeView(studySet: studySet, difficulty: difficulty)
        case .sentenceBuilder:
            SentenceBuilderView(studySet: studySet, difficulty: difficulty)
        case .listeningQuiz:
            ListeningQuizView(studySet: studySet, difficulty: difficulty)
        case .hanziMemory:
            HanziMemoryView(
                studySet: studySet,
                difficulty: difficulty,
                matchMode: memoryMode ?? .chineseEnglish
            )
        case .findTheHanzi:
            FindTheHanziView(studySet: studySet, difficulty: difficulty)
        case .typingChallenge:
            TypingChallengeView(studySet: studySet, difficulty: difficulty)
        case .dailyChallenge:
            DailyChallengeView()
        case .smartReview:
            SmartReviewView(studySet: studySet)
        }
    }
}

struct GameUnavailableView: View {
    let game: GameDefinition

    var body: some View {
        ContentUnavailableView {
            Label(game.localizedTitle, systemImage: "lock.fill")
        } description: {
            Text(l10n: "games.locked.message")
        }
        .navigationTitle(game.localizedTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}
