//
//  GamesHubSections.swift
//  HanziPlus
//

import SwiftUI

// MARK: - Continue Playing

struct GameContinuePlayingCard: View {

    let session: ActiveGameSession

    private var game: GameDefinition {
        GameDefinition.definition(for: session.gameKind)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            NavigationLink {
                GameContinueDestinationView(session: session)
            } label: {
                HStack(spacing: 0) {
                    CinematicGameArtwork(game: game, height: 100, cornerRadius: AppRadius.medium)
                        .frame(width: 130)
                        .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous))

                    VStack(alignment: .leading, spacing: 8) {
                        Text(game.title)
                            .font(.headline.weight(.bold))
                            .foregroundStyle(.primary)

                        Text(session.progressLabel)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        AnimatedProgressBar(progress: session.progressValue, tint: game.color)
                            .frame(height: 5)

                        Label("Continue", systemImage: "arrow.right")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(game.color)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)

                    Spacer(minLength: 0)
                }
                .background {
                    RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                }
                .studyCardShadow()
            }
            .buttonStyle(GameCardButtonStyle())
        }
    }
}

struct GameContinueDestinationView: View {
    let session: ActiveGameSession

    var body: some View {
        if let studySet = SampleStudySets.all.first(where: { $0.fileName == session.studySetFileName }) {
            GameRouter.destination(
                for: GameDefinition.definition(for: session.gameKind),
                studySet: studySet,
                difficulty: session.difficulty,
                memoryMode: session.memoryMode
            )
        } else {
            ContentUnavailableView("Session Expired", systemImage: "clock.arrow.circlepath")
        }
    }
}

// MARK: - Daily Recommendation

struct GameDailyRecommendationCard: View {

    let game: GameDefinition
    var statistics: GameStatistics = GameStatistics()

    var body: some View {
        NavigationLink {
            GameDetailView(game: game)
        } label: {
            GamePremiumCard(
                game: game,
                statistics: statistics,
                badges: [.recommended],
                style: .featured
            )
        }
        .buttonStyle(GameCardButtonStyle())
    }
}

// MARK: - Daily Challenge Mission

struct GameDailyChallengeCard: View {

    let tasks: [DailyChallengeTask]
    let completedIDs: Set<String>
    let xpReward: Int

    private let game = GameDefinition.definition(for: .dailyChallenge)

    var body: some View {
        NavigationLink {
            DailyChallengeView()
        } label: {
            VStack(alignment: .leading, spacing: 16) {
                Text("Daily Challenge")
                    .font(.headline.weight(.bold))
                    .foregroundStyle(.primary)

                VStack(alignment: .leading, spacing: 10) {
                    ForEach(tasks) { task in
                        missionRow(task)
                    }
                }

                HStack {
                    Text("Reward")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("+\(xpReward) XP")
                        .font(.headline.weight(.bold))
                        .foregroundStyle(.purple)
                }
            }
            .padding(20)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
            }
            .studyCardShadow()
        }
        .buttonStyle(GameCardButtonStyle())
    }

    private func missionRow(_ task: DailyChallengeTask) -> some View {
        let isDone = completedIDs.contains(task.id)
        let taskGame = GameDefinition.definition(for: task.kind)

        return HStack(spacing: 10) {
            Image(systemName: isDone ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(isDone ? Color.green : Color.secondary.opacity(0.4))
                .font(.body.weight(.semibold))

            Text("\(taskGame.emoji) \(task.title)")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(isDone ? .secondary : .primary)
                .strikethrough(isDone, color: .secondary)
        }
    }
}

// MARK: - Player Stats (Apple Fitness style)

struct GamesPlayerStatsSection: View {

    let todayXP: Int
    let weeklyXP: Int
    let streak: Int
    let gamesPlayed: Int
    let accuracy: Int

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("Player Stats")
                .font(.title2.weight(.bold))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.small) {
                    fitnessRingCard(
                        title: "Today's XP",
                        value: "\(todayXP)",
                        icon: "sparkles",
                        tint: .purple,
                        progress: min(Double(todayXP) / 500.0, 1.0)
                    )
                    fitnessRingCard(
                        title: "Weekly XP",
                        value: "\(weeklyXP)",
                        icon: "calendar",
                        tint: .blue,
                        progress: min(Double(weeklyXP) / 2000.0, 1.0)
                    )
                    fitnessStatCard(title: "Current Streak", value: "\(streak)", icon: "flame.fill", tint: .orange)
                    fitnessStatCard(title: "Games Played", value: "\(gamesPlayed)", icon: "gamecontroller.fill", tint: .green)
                    fitnessStatCard(title: "Accuracy", value: "\(accuracy)%", icon: "target", tint: .mint)
                }
                .padding(.vertical, 4)
            }
        }
    }

    private func fitnessRingCard(title: String, value: String, icon: String, tint: Color, progress: Double) -> some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .stroke(tint.opacity(0.15), lineWidth: 6)
                    .frame(width: 56, height: 56)

                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(tint, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .frame(width: 56, height: 56)
                    .rotationEffect(.degrees(-90))

                Image(systemName: icon)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(tint)
            }

            Text(value)
                .font(.title3.weight(.bold))

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 120)
        .padding(.vertical, 16)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
    }

    private func fitnessStatCard(title: String, value: String, icon: String, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: icon)
                .font(.title3.weight(.semibold))
                .foregroundStyle(tint)

            Text(value)
                .font(.title2.weight(.bold))

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 120, alignment: .leading)
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
    }
}

// MARK: - Section Header

struct GamesSectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.title2.weight(.bold))
    }
}
