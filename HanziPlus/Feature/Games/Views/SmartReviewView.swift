//
//  SmartReviewView.swift
//  HanziPlus
//

import SwiftUI

struct SmartReviewView: View {

    let studySet: StudySet

    @State private var viewModel: SmartReviewViewModel?
    @State private var hasStarted = false
    @State private var flashColor: Color = .clear

    @Environment(\.dismiss) private var dismiss
    @Environment(LearnedWordsStore.self) private var learnedStore
    @Environment(SmartReviewStore.self) private var smartReviewStore
    @Environment(GameScoreStore.self) private var scoreStore
    @Environment(StatisticsStore.self) private var statisticsStore
    @Environment(AchievementStore.self) private var achievementStore

    private let game = GameDefinition.definition(for: .smartReview)

    var body: some View {
        Group {
            if let viewModel, viewModel.isFinished, let result = viewModel.result {
                GameCompletionView(
                    game: game,
                    result: result,
                    onPlayAgain: {
                        self.viewModel = SmartReviewViewModel(
                            studySet: studySet,
                            learnedStore: learnedStore,
                            smartReviewStore: smartReviewStore
                        )
                        hasStarted = true
                    },
                    onBackToGames: { dismiss() }
                )
            } else if hasStarted, let viewModel {
                reviewSession(viewModel)
            } else {
                overview
            }
        }
        .navigationTitle("Smart Review")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if viewModel == nil {
                viewModel = SmartReviewViewModel(
                    studySet: studySet,
                    learnedStore: learnedStore,
                    smartReviewStore: smartReviewStore
                )
            }
        }
    }

    private var overview: some View {
        VStack(spacing: AppSpacing.large) {
            Spacer()

            Image(systemName: "brain.head.profile")
                .font(.system(size: 56, weight: .semibold))
                .foregroundStyle(game.color)

            Text("Today's Review")
                .font(.largeTitle.weight(.bold))

            if let viewModel {
                VStack(spacing: AppSpacing.small) {
                    overviewStat(title: "Words Due", value: "\(viewModel.dueCount)")
                    overviewStat(title: "Estimated Time", value: "~\(viewModel.estimatedMinutes) min")
                    overviewStat(title: "Session Size", value: "\(viewModel.words.count) words")
                }
                .padding(AppSpacing.medium)
                .background {
                    RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                }
                .studyCardShadow()
            }

            Button("Start Review") {
                hasStarted = true
            }
            .buttonStyle(.borderedProminent)
            .tint(game.color)
            .padding(.horizontal, AppSpacing.medium)

            Spacer()
        }
        .padding(.horizontal, AppSpacing.medium)
        .background(Color(.systemGroupedBackground))
    }

    private func overviewStat(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.headline.weight(.semibold))
        }
    }

    private func reviewSession(_ viewModel: SmartReviewViewModel) -> some View {
        VStack(spacing: AppSpacing.medium) {
            HStack {
                Text("Completion \(viewModel.completionPercent)%")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(game.color)
                Spacer()
                Text("\(viewModel.currentIndex + 1) / \(viewModel.words.count)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, AppSpacing.small)

            AnimatedProgressBar(progress: viewModel.progress, tint: game.color)

            if let word = viewModel.currentWord {
                Text(word.hanzi)
                    .font(.system(size: 64, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 28)
                    .background {
                        RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                            .fill(Color(.secondarySystemGroupedBackground))
                    }
            }

            VStack(spacing: AppSpacing.small) {
                ForEach(viewModel.options, id: \.self) { option in
                    GameOptionButton(
                        text: option,
                        isSelected: viewModel.selectedAnswer == option,
                        isCorrect: option == viewModel.currentWord?.localizedMeaning,
                        showResult: viewModel.showResult,
                        action: { select(option, viewModel: viewModel) }
                    )
                }
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.bottom, AppSpacing.medium)
        .background(flashColor.opacity(0.14).ignoresSafeArea())
        .gameRestartToolbar {
            self.viewModel?.restart()
        }
        .onChange(of: viewModel.showResult) { _, show in
            guard show else { return }
            advance(viewModel)
        }
    }

    private func select(_ option: String, viewModel: SmartReviewViewModel) {
        guard !viewModel.showResult else { return }
        viewModel.select(option)

        if option == viewModel.currentWord?.localizedMeaning {
            HapticService.success()
        } else {
            HapticService.rigid()
            if let word = viewModel.currentWord {
                smartReviewStore.recordWrong(word: word, studySet: studySet)
            }
        }

        withAnimation(.easeIn(duration: 0.15)) {
            flashColor = option == viewModel.currentWord?.localizedMeaning ? .green : .red
        }
    }

    private func advance(_ viewModel: SmartReviewViewModel) {
        Task {
            try? await Task.sleep(for: .seconds(0.65))
            await MainActor.run {
                withAnimation(.easeOut(duration: 0.2)) { flashColor = .clear }
                if viewModel.currentIndex >= viewModel.words.count - 1 {
                    viewModel.finish(
                        scoreStore: scoreStore,
                        statisticsStore: statisticsStore,
                        achievementStore: achievementStore,
                        smartReviewStore: smartReviewStore
                    )
                } else {
                    viewModel.nextQuestion()
                }
            }
        }
    }
}
