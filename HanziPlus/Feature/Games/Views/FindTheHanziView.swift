//
//  FindTheHanziView.swift
//  HanziPlus
//

import SwiftUI

struct FindTheHanziView: View {

    let studySet: StudySet
    let difficulty: GameDifficulty

    @State private var viewModel: FindTheHanziViewModel
    @State private var flashColor: Color = .clear

    @Environment(\.dismiss) private var dismiss
    @Environment(GameScoreStore.self) private var scoreStore
    @Environment(StatisticsStore.self) private var statisticsStore
    @Environment(AchievementStore.self) private var achievementStore
    @Environment(SmartReviewStore.self) private var smartReviewStore

    private let game = GameDefinition.definition(for: .findTheHanzi)

    init(studySet: StudySet, difficulty: GameDifficulty = .medium) {
        self.studySet = studySet
        self.difficulty = difficulty
        _viewModel = State(initialValue: FindTheHanziViewModel(studySet: studySet, difficulty: difficulty))
    }

    var body: some View {
        Group {
            if viewModel.isFinished, let result = viewModel.result {
                GameCompletionView(
                    game: game,
                    result: result,
                    onPlayAgain: { viewModel.restart() },
                    onBackToGames: { dismiss() }
                )
            } else {
                gameplay
            }
        }
        .navigationTitle(game.title)
        .navigationBarTitleDisplayMode(.inline)
        .gameRestartToolbar { viewModel.restart() }
    }

    private var gameplay: some View {
        VStack(spacing: AppSpacing.medium) {
            AnimatedProgressBar(progress: viewModel.progress, tint: game.color)
                .padding(.top, AppSpacing.small)

            if let word = viewModel.currentWord {
                VStack(spacing: 8) {
                    Text("Find the Hanzi for")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text(word.english)
                        .font(.largeTitle.weight(.bold))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppSpacing.large)
                .background {
                    RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                }
                .studyCardShadow()
            }

            let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: difficulty.gridDimension)

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.gridOptions, id: \.self) { hanzi in
                    GameHanziOptionButton(
                        hanzi: hanzi,
                        isSelected: viewModel.selectedAnswer == hanzi,
                        isCorrect: hanzi == viewModel.currentWord?.hanzi,
                        showResult: viewModel.showResult,
                        action: { select(hanzi) }
                    )
                }
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.bottom, AppSpacing.medium)
        .background(flashColor.opacity(0.14).ignoresSafeArea())
        .onChange(of: viewModel.showResult) { _, show in
            guard show else { return }
            advance()
        }
    }

    private func select(_ hanzi: String) {
        guard !viewModel.showResult else { return }
        viewModel.select(hanzi)

        if hanzi == viewModel.currentWord?.hanzi {
            HapticService.success()
            SoundService.success()
        } else {
            HapticService.rigid()
            SoundService.error()
            if let word = viewModel.currentWord {
                smartReviewStore.recordWrong(word: word, studySet: studySet)
            }
        }

        withAnimation(.easeIn(duration: 0.15)) {
            flashColor = hanzi == viewModel.currentWord?.hanzi ? .green : .red
        }
    }

    private func advance() {
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
