//
//  DailyChallengeView.swift
//  HanziPlus
//

import SwiftUI

struct DailyChallengeView: View {

    @State private var studySet = SampleStudySets.all[0]
    @State private var viewModel: DailyChallengeViewModel?
    @State private var showCompletion = false

    @Environment(\.dismiss) private var dismiss
    @Environment(DailyChallengeStore.self) private var dailyStore
    @Environment(GameScoreStore.self) private var scoreStore
    @Environment(StatisticsStore.self) private var statisticsStore
    @Environment(AchievementStore.self) private var achievementStore

    private let game = GameDefinition.definition(for: .dailyChallenge)

    var body: some View {
        Group {
            if showCompletion, let viewModel, let result = viewModel.result {
                GameCompletionView(
                    game: game,
                    result: result,
                    onPlayAgain: {
                        dailyStore.refreshIfNeeded()
                        self.viewModel = DailyChallengeViewModel(studySet: studySet, dailyStore: dailyStore)
                        showCompletion = false
                    },
                    onBackToGames: { dismiss() }
                )
            } else {
                challengeHub
            }
        }
        .navigationTitle(String(localized: "games.daily_challenge"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            dailyStore.refreshIfNeeded()
            if viewModel == nil {
                viewModel = DailyChallengeViewModel(studySet: studySet, dailyStore: dailyStore)
            }
        }
    }

    private var challengeHub: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                headerCard

                if dailyStore.state.isFullyCompleted {
                    completedBanner
                }

                VStack(alignment: .leading, spacing: AppSpacing.medium) {
                    Text("games.daily.tasks_title")
                        .font(.title2.weight(.semibold))

                    ForEach(dailyStore.state.tasks) { task in
                        DailyTaskRow(
                            task: task,
                            isCompleted: dailyStore.state.completedTaskIDs.contains(task.id),
                            color: game.color
                        )
                    }
                }

                if let task = viewModel?.currentTask, !dailyStore.state.isFullyCompleted {
                    NavigationLink {
                        dailyTaskDestination(for: task)
                    } label: {
                        Text(String(localized: "games.daily.start_task \(task.localizedTitle)"))
                            .font(.body.weight(.semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Capsule().fill(game.color))
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(GamePressButtonStyle())
                }

                if dailyStore.state.isFullyCompleted {
                    Button(String(localized: "games.daily.claim_rewards")) {
                        viewModel?.finish(
                            scoreStore: scoreStore,
                            statisticsStore: statisticsStore,
                            achievementStore: achievementStore
                        )
                        showCompletion = true
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(game.color)
                }
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.bottom, AppSpacing.extraLarge)
        }
        .background(Color(.systemGroupedBackground))
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "calendar")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(game.color)

                VStack(alignment: .leading, spacing: 4) {
                    Text("games.daily_challenge")
                        .font(.title2.weight(.bold))
                    Text(dailyStore.state.dateKey)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("\(Int((dailyStore.state.completionProgress * 100).rounded()))%")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(game.color)
            }

            AnimatedProgressBar(progress: dailyStore.state.completionProgress, tint: game.color)

            HStack {
                Label("\(dailyStore.streakDays) day streak", systemImage: "flame.fill")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.orange)
                Spacer()
                Text("+\(dailyStore.state.xpAwarded > 0 ? dailyStore.state.xpAwarded : 150) XP")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.purple)
            }
        }
        .padding(AppSpacing.medium)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
    }

    private var completedBanner: some View {
        Label(String(localized: "games.daily.all_done"), systemImage: "checkmark.seal.fill")
            .font(.headline.weight(.semibold))
            .foregroundStyle(.green)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(AppSpacing.medium)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                    .fill(Color.green.opacity(0.12))
            }
    }

    @ViewBuilder
    private func dailyTaskDestination(for task: DailyChallengeTask) -> some View {
        switch task.kind {
        case .matchPairs:
            MatchPairsView(studySet: studySet, difficulty: .easy)
                .onDisappear { dailyStore.completeTask(task.id, xp: 25) }
        case .speedChallenge:
            SpeedChallengeView(studySet: studySet, difficulty: .easy)
                .onDisappear { dailyStore.completeTask(task.id, xp: 25) }
        case .listeningQuiz:
            ListeningQuizView(studySet: studySet, difficulty: .easy)
                .onDisappear { dailyStore.completeTask(task.id, xp: 25) }
        case .typingChallenge:
            TypingChallengeView(studySet: studySet, difficulty: .easy)
                .onDisappear { dailyStore.completeTask(task.id, xp: 25) }
        default:
            GameUnavailableView(game: GameDefinition.definition(for: task.kind))
        }
    }
}

private struct DailyTaskRow: View {
    let task: DailyChallengeTask
    let isCompleted: Bool
    let color: Color

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(isCompleted ? .green : .secondary)
                .font(.title3)

            VStack(alignment: .leading, spacing: 4) {
                Text(task.localizedTitle)
                    .font(.headline.weight(.semibold))
                Text("\(task.targetCount) items")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
    }
}
