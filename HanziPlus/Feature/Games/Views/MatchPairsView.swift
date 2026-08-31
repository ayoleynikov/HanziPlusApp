//
//  MatchPairsView.swift
//  HanziPlus
//

import SwiftUI

struct MatchPairsView: View {

    let studySet: StudySet
    let difficulty: GameDifficulty

    @State private var viewModel: MatchPairsViewModel
    @State private var flashColor: Color = .clear
    @State private var showMistakeFeedback = false

    @Environment(\.dismiss) private var dismiss
    @Environment(GameScoreStore.self) private var scoreStore
    @Environment(StatisticsStore.self) private var statisticsStore
    @Environment(SmartReviewStore.self) private var smartReviewStore

    private let game = GameDefinition.definition(for: .matchPairs)

    init(studySet: StudySet, difficulty: GameDifficulty = .medium) {
        self.studySet = studySet
        self.difficulty = difficulty
        _viewModel = State(initialValue: MatchPairsViewModel(studySet: studySet, difficulty: difficulty))
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
            progressSection

            Spacer(minLength: AppSpacing.small)

            if let word = viewModel.currentWord {
                chineseCard(word: word)
            }

            Image(systemName: "arrow.down")
                .font(.caption.weight(.bold))
                .foregroundStyle(.tertiary)

            Text(l10n: "games.match.prompt")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)

            VStack(spacing: AppSpacing.small) {
                ForEach(viewModel.options.indices, id: \.self) { index in
                    let option = viewModel.options[index]
                    GameOptionButton(
                        text: option,
                        isSelected: viewModel.selectedAnswer == option,
                        isCorrect: option == viewModel.currentWord?.localizedMeaning,
                        showResult: viewModel.showResult,
                        action: {
                            guard !viewModel.showResult else { return }
                            let word = viewModel.currentWord
                            viewModel.select(option)
                            if let word {
                                smartReviewStore.recordAttempt(
                                    fileName: studySet.fileName,
                                    hanzi: word.hanzi,
                                    correct: option == word.localizedMeaning
                                )
                            }
                            if option == word?.localizedMeaning {
                                HapticService.success()
                            } else {
                                HapticService.rigid()
                            }
                        }
                    )
                    .opacity(
                        viewModel.showResult &&
                        viewModel.selectedAnswer != option &&
                        option != viewModel.currentWord?.localizedMeaning ? 0.45 : 1
                    )
                }
            }

            scoreFooter

            Spacer(minLength: AppSpacing.small)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.bottom, AppSpacing.medium)
        .background(flashColor.opacity(0.14).ignoresSafeArea())
        .overlay(alignment: .bottom) {
            if showMistakeFeedback, let word = viewModel.currentWord {
                QuizMistakeFeedbackCard(
                    word: word,
                    correctAnswer: word.localizedMeaning,
                    onContinue: dismissMistakeAndAdvance
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.86), value: showMistakeFeedback)
        .onChange(of: viewModel.showResult) { _, showResult in
            guard showResult else { return }
            handleResultFeedback()
        }
    }

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(viewModel.currentIndex + 1) / \(viewModel.words.count)")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)

                Spacer()

                Text(L10n.string("\(viewModel.correctCount) correct"))
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(game.color)
            }

            AnimatedProgressBar(progress: viewModel.progress, tint: game.color)
        }
        .padding(.top, AppSpacing.small)
    }

    private func chineseCard(word: Word) -> some View {
        VStack(spacing: 10) {
            Text(word.hanzi)
                .font(.system(size: 72, weight: .bold, design: .rounded))
                .scaleEffect(viewModel.showResult ? 1.04 : 1)
                .animation(.spring(response: 0.35, dampingFraction: 0.72), value: viewModel.showResult)

            Text(word.pinyin)
                .font(.title3.weight(.medium))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
    }

    private var scoreFooter: some View {
        HStack(spacing: 20) {
            Label("\(viewModel.correctCount)", systemImage: "checkmark.circle.fill")
                .foregroundStyle(.green)
            Label("\(viewModel.wrongCount)", systemImage: "xmark.circle.fill")
                .foregroundStyle(.red)
        }
        .font(.subheadline.weight(.semibold))
    }

    private func handleResultFeedback() {
        let isCorrect = viewModel.selectedAnswer == viewModel.currentWord?.localizedMeaning

        withAnimation(.easeIn(duration: 0.15)) {
            flashColor = isCorrect ? .green : .red
        }

        if isCorrect {
            Task {
                try? await Task.sleep(for: .seconds(0.75))
                await MainActor.run {
                    withAnimation(.easeOut(duration: 0.25)) { flashColor = .clear }
                    advance()
                }
            }
        } else {
            showMistakeFeedback = true
        }
    }

    private func dismissMistakeAndAdvance() {
        showMistakeFeedback = false
        withAnimation(.easeOut(duration: 0.25)) { flashColor = .clear }
        advance()
    }

    private func advance() {
        if viewModel.currentIndex >= viewModel.words.count - 1 {
            viewModel.finish(scoreStore: scoreStore, statisticsStore: statisticsStore)
        } else {
            viewModel.nextQuestion()
        }
    }
}

#Preview {
    NavigationStack {
        MatchPairsView(studySet: SampleStudySets.all[0])
    }
    .environment(GameScoreStore())
    .environment(StatisticsStore())
    .environment(SmartReviewStore())
}
