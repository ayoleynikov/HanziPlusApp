//
//  GamesTodaySection.swift
//  HanziPlus
//

import SwiftUI

struct GamesTodaySection: View {

    let recommendedGame: GameDefinition
    let tasks: [DailyChallengeTask]
    let completedTaskIDs: Set<String>
    let xpReward: Int
    let activeSession: ActiveGameSession?
    let recentlyPlayed: [GameKind]
    let statistics: (GameKind) -> GameStatistics

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.large) {
            Text("games.section.today")
                .font(.title2.weight(.bold))
                .padding(.horizontal, AppSpacing.medium)

            VStack(spacing: AppSpacing.medium) {
                if let session = activeSession {
                    GameContinuePlayingCard(session: session)
                }

                GameDailyRecommendationCard(
                    game: recommendedGame,
                    statistics: statistics(recommendedGame.kind)
                )

                GameDailyChallengeCard(
                    tasks: tasks,
                    completedIDs: completedTaskIDs,
                    xpReward: xpReward
                )

                if !recentlyPlayed.isEmpty {
                    recentlyPlayedRow
                }
            }
            .padding(.horizontal, AppSpacing.medium)
        }
    }

    private var recentlyPlayedRow: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("games.section.recently_played")
                .font(.headline.weight(.semibold))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.small) {
                    ForEach(recentlyPlayed, id: \.self) { kind in
                        let game = GameDefinition.definition(for: kind)
                        NavigationLink {
                            GameDetailView(game: game)
                        } label: {
                            GamePremiumCard(
                                game: game,
                                statistics: statistics(kind),
                                badges: [.recentlyPlayed],
                                style: .compact
                            )
                        }
                        .buttonStyle(GameCardButtonStyle())
                    }
                }
            }
        }
    }
}
