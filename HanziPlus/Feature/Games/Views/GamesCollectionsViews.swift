//
//  GamesCollectionsViews.swift
//  HanziPlus
//

import SwiftUI

struct GamesCompletedView: View {

    let gamesCompleted: Int

    @Environment(GameScoreStore.self) private var scoreStore

    var body: some View {
        List {
            Section {
                HStack {
                    Text(l10n: "games.hub.total_sessions")
                    Spacer()
                    Text("\(gamesCompleted)")
                        .foregroundStyle(.secondary)
                }
            }

            Section(L10n.string("By Game")) {
                ForEach(GameDefinition.libraryGames) { game in
                    let stats = scoreStore.statistics(for: game.kind)
                    HStack {
                        Text("\(game.emoji) \(game.localizedTitle)")
                        Spacer()
                        Text("\(stats.gamesPlayed)")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle(L10n.string("Games Completed"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GamesAchievementsView: View {

    @Environment(AchievementStore.self) private var achievementStore

    var body: some View {
        List(achievementStore.achievements) { achievement in
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(achievement.isUnlocked ? Color.orange.opacity(0.15) : Color(.tertiarySystemFill))
                        .frame(width: 44, height: 44)

                    Image(systemName: achievement.icon)
                        .foregroundStyle(achievement.isUnlocked ? .orange : .secondary)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(achievement.title)
                        .font(.headline)
                        .foregroundStyle(achievement.isUnlocked ? .primary : .secondary)

                    Text(achievement.description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if achievement.isUnlocked {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(.orange)
                }
            }
            .opacity(achievement.isUnlocked ? 1 : 0.65)
        }
        .navigationTitle(L10n.string("Achievements"))
        .navigationBarTitleDisplayMode(.inline)
    }
}
