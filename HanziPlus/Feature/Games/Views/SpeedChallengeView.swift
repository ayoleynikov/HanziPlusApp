//
//  SpeedChallengeView.swift
//  HanziPlus
//

import SwiftUI

struct SpeedChallengeView: View {

    let studySet: StudySet
    let difficulty: GameDifficulty

    @State private var viewModel: SpeedChallengeViewModel
    @State private var flashColor: Color = .clear
    @State private var timerTask: Task<Void, Never>?

    @Environment(\.dismiss) private var dismiss
    @Environment(GameScoreStore.self) private var scoreStore
    @Environment(StatisticsStore.self) private var statisticsStore

    private let game = GameDefinition.definition(for: .speedChallenge)

    init(studySet: StudySet, difficulty: GameDifficulty = .medium) {
        self.studySet = studySet
        self.difficulty = difficulty
        _viewModel = State(initialValue: SpeedChallengeViewModel(studySet: studySet))
    }

    var body: some View {
        Group {
            if viewModel.isFinished, let result = viewModel.result {
                GameCompletionView(
                    game: game,
                    result: result,
                    onPlayAgain: {
                        viewModel.restart()
                        startTimerLoop()
                    },
                    onBackToGames: { dismiss() }
                )
            } else {
                gameplay
            }
        }
        .navigationTitle(game.localizedTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.startTimer()
            startTimerLoop()
        }
        .onDisappear {
            timerTask?.cancel()
        }
    }

    private var gameplay: some View {
        VStack(spacing: AppSpacing.medium) {
            timerSection

            HStack {
                comboBadge
                Spacer()
                accuracyBadge
            }

            Spacer(minLength: AppSpacing.small)

            if let word = viewModel.currentWord {
                chineseCard(word: word)
            }

            VStack(spacing: AppSpacing.small) {
                ForEach(viewModel.options, id: \.self) { option in
                    GameOptionButton(
                        text: option,
                        isSelected: viewModel.selectedAnswer == option,
                        isCorrect: option == viewModel.currentWord?.localizedMeaning,
                        showResult: viewModel.showResult,
                        action: {
                            guard !viewModel.showResult, viewModel.remainingSeconds > 0 else { return }
                            viewModel.select(option)
                            if option == viewModel.currentWord?.localizedMeaning {
                                HapticService.light()
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
        .onChange(of: viewModel.showResult) { _, showResult in
            guard showResult else { return }
            handleResultFeedback()
        }
        .onChange(of: viewModel.remainingSeconds) { _, remaining in
            if remaining == 0 {
                viewModel.finish(scoreStore: scoreStore, statisticsStore: statisticsStore)
            }
        }
    }

    private var timerSection: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: "timer")
                    .foregroundStyle(game.color)

                Text("\(viewModel.remainingSeconds)s")
                    .font(.title2.weight(.bold))
                    .monospacedDigit()
                    .contentTransition(.numericText())
                    .foregroundStyle(viewModel.remainingSeconds <= 10 ? .red : .primary)

                Spacer()

                Text("\(viewModel.correctCount) pts")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(game.color)
            }

            AnimatedProgressBar(progress: viewModel.timerProgress, tint: game.color, height: 6)
        }
        .padding(.top, AppSpacing.small)
        .animation(.spring(response: 0.4, dampingFraction: 0.86), value: viewModel.remainingSeconds)
    }

    private var comboBadge: some View {
        HStack(spacing: 6) {
            Image(systemName: "flame.fill")
                .foregroundStyle(.orange)
            Text(viewModel.combo > 1 ? "×\(viewModel.combo) Combo" : "No combo")
                .font(.caption.weight(.semibold))
                .foregroundStyle(viewModel.combo > 1 ? .orange : .secondary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Capsule().fill(Color(.tertiarySystemFill)))
        .animation(.spring(response: 0.32, dampingFraction: 0.72), value: viewModel.combo)
    }

    private var accuracyBadge: some View {
        let total = viewModel.correctCount + viewModel.wrongCount
        let accuracy = total > 0 ? Int(Double(viewModel.correctCount) / Double(total) * 100) : 100

        return Text("\(accuracy)%")
            .font(.caption.weight(.semibold))
            .foregroundStyle(.secondary)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Capsule().fill(Color(.tertiarySystemFill)))
    }

    private func chineseCard(word: Word) -> some View {
        Text(word.hanzi)
            .font(.system(size: 68, weight: .bold, design: .rounded))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 28)
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

        withAnimation(.easeIn(duration: 0.12)) {
            flashColor = isCorrect ? .green : .red
        }

        Task {
            try? await Task.sleep(for: .seconds(0.45))

            await MainActor.run {
                withAnimation(.easeOut(duration: 0.2)) {
                    flashColor = .clear
                }

                if viewModel.remainingSeconds > 0 {
                    viewModel.nextQuestion()
                }
            }
        }
    }

    private func startTimerLoop() {
        timerTask?.cancel()
        timerTask = Task { @MainActor in
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(1))
                guard !Task.isCancelled else { return }
                viewModel.tick()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SpeedChallengeView(studySet: SampleStudySets.all[0])
    }
    .environment(GameScoreStore())
    .environment(StatisticsStore())
}
