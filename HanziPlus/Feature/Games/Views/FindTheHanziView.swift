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
    @State private var showMistakeFeedback = false

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
        .navigationTitle(game.localizedTitle)
        .navigationBarTitleDisplayMode(.inline)
        .gameRestartToolbar { viewModel.restart() }
    }

    private var gameplay: some View {
        VStack(spacing: AppSpacing.medium) {
            AnimatedProgressBar(progress: viewModel.progress, tint: game.color)
                .padding(.top, AppSpacing.small)

            if let word = viewModel.currentWord {
                VStack(spacing: 8) {
                    Text(l10n: "games.find.prompt")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text(word.localizedMeaning)
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
                ForEach(viewModel.gridOptions.indices, id: \.self) { index in
                    let hanzi = viewModel.gridOptions[index]
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
        .overlay(alignment: .bottom) {
            if showMistakeFeedback, let word = viewModel.currentWord {
                QuizMistakeFeedbackCard(
                    word: word,
                    correctAnswer: word.hanzi,
                    onContinue: dismissMistakeAndAdvance
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.86), value: showMistakeFeedback)
        .onChange(of: viewModel.showResult) { _, show in
            guard show else { return }
            handleResult()
        }
    }

    private func select(_ hanzi: String) {
        guard !viewModel.showResult else { return }
        let word = viewModel.currentWord
        viewModel.select(hanzi)
        if let word {
            smartReviewStore.recordAttempt(
                fileName: studySet.fileName,
                hanzi: word.hanzi,
                correct: hanzi == word.hanzi
            )
        }

        if hanzi == word?.hanzi {
            HapticService.success()
            SoundService.success()
        } else {
            HapticService.rigid()
            SoundService.error()
        }

        withAnimation(.easeIn(duration: 0.15)) {
            flashColor = hanzi == word?.hanzi ? .green : .red
        }
    }

    private func handleResult() {
        let isCorrect = viewModel.selectedAnswer == viewModel.currentWord?.hanzi
        if isCorrect {
            Task {
                try? await Task.sleep(for: .seconds(0.65))
                await MainActor.run { advance() }
            }
        } else {
            showMistakeFeedback = true
        }
    }

    private func dismissMistakeAndAdvance() {
        showMistakeFeedback = false
        withAnimation(.easeOut(duration: 0.2)) { flashColor = .clear }
        advance()
    }

    private func advance() {
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
