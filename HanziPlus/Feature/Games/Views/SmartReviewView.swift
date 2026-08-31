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
    @State private var showMistakeFeedback = false

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
        .navigationTitle(L10n.string("Smart Review"))
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

            Text(l10n: "games.review.todays")
                .font(.largeTitle.weight(.bold))

            if let viewModel {
                VStack(spacing: AppSpacing.small) {
                    overviewStat(title: L10n.string("games.review.words_due"), value: "\(viewModel.dueCount)")
                    overviewStat(title: L10n.string("games.review.estimated_time"), value: L10n.string("games.review.approx_minutes \(viewModel.estimatedMinutes)"))
                    overviewStat(title: L10n.string("games.review.session_size"), value: L10n.words(viewModel.words.count))
                }
                .padding(AppSpacing.medium)
                .background {
                    RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                }
                .studyCardShadow()
            }

            Button(L10n.string( "games.review.start")) {
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
                Text("\(L10n.string("games.review.completion")) \(L10n.percent(viewModel.completionPercent))")
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
                ForEach(viewModel.options.indices, id: \.self) { index in
                    let option = viewModel.options[index]
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
        .overlay(alignment: .bottom) {
            if showMistakeFeedback, let word = viewModel.currentWord {
                QuizMistakeFeedbackCard(
                    word: word,
                    correctAnswer: word.localizedMeaning,
                    onContinue: { dismissMistakeAndAdvance(viewModel) }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.86), value: showMistakeFeedback)
        .gameRestartToolbar {
            self.viewModel?.restart()
        }
        .onChange(of: viewModel.showResult) { _, show in
            guard show else { return }
            handleResult(viewModel)
        }
    }

    private func select(_ option: String, viewModel: SmartReviewViewModel) {
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

        withAnimation(.easeIn(duration: 0.15)) {
            flashColor = option == word?.localizedMeaning ? .green : .red
        }
    }

    private func handleResult(_ viewModel: SmartReviewViewModel) {
        let isCorrect = viewModel.selectedAnswer == viewModel.currentWord?.localizedMeaning
        if isCorrect {
            Task {
                try? await Task.sleep(for: .seconds(0.65))
                await MainActor.run { advance(viewModel) }
            }
        } else {
            showMistakeFeedback = true
        }
    }

    private func dismissMistakeAndAdvance(_ viewModel: SmartReviewViewModel) {
        showMistakeFeedback = false
        withAnimation(.easeOut(duration: 0.2)) { flashColor = .clear }
        advance(viewModel)
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
