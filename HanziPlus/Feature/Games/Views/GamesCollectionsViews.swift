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
                    Text("Total Sessions")
                    Spacer()
                    Text("\(gamesCompleted)")
                        .foregroundStyle(.secondary)
                }
            }

            Section("By Game") {
                ForEach(GameDefinition.libraryGames) { game in
                    let stats = scoreStore.statistics(for: game.kind)
                    HStack {
                        Text("\(game.emoji) \(game.title)")
                        Spacer()
                        Text("\(stats.gamesPlayed)")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Games Completed")
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
        .navigationTitle("Achievements")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GamesPerfectScoresView: View {

    @Environment(GameScoreStore.self) private var scoreStore
    @Environment(AchievementStore.self) private var achievementStore

    private var perfectScoreGames: [GameDefinition] {
        GameDefinition.libraryGames.filter { game in
            let stats = scoreStore.statistics(for: game.kind)
            return stats.averageAccuracy == 100 && stats.gamesPlayed > 0
        }
    }

    var body: some View {
        List {
            if perfectScoreGames.isEmpty {
                ContentUnavailableView(
                    "No Perfect Scores Yet",
                    systemImage: "star.circle",
                    description: Text("Finish a game with 100% accuracy to earn a perfect score.")
                )
            } else {
                ForEach(perfectScoreGames) { game in
                    HStack {
                        Text("\(game.emoji) \(game.title)")
                        Spacer()
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                    }
                }
            }

            Section("Related Badges") {
                ForEach(achievementStore.achievements.filter {
                    $0.id.contains("perfect") || $0.id.contains("master") || $0.id.contains("expert") || $0.id.contains("champion")
                }) { achievement in
                    HStack {
                        Text(achievement.title)
                        Spacer()
                        if achievement.isUnlocked {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        }
                    }
                }
            }
        }
        .navigationTitle("Perfect Scores")
        .navigationBarTitleDisplayMode(.inline)
    }
}
