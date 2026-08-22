//
//  TypingChallengeView.swift
//  HanziPlus
//

import SwiftUI

struct TypingChallengeView: View {

    let studySet: StudySet
    let difficulty: GameDifficulty

    @State private var viewModel: TypingChallengeViewModel
    @FocusState private var isInputFocused: Bool

    @Environment(\.dismiss) private var dismiss
    @Environment(GameScoreStore.self) private var scoreStore
    @Environment(StatisticsStore.self) private var statisticsStore
    @Environment(AchievementStore.self) private var achievementStore
    @Environment(SmartReviewStore.self) private var smartReviewStore

    private let game = GameDefinition.definition(for: .typingChallenge)

    init(studySet: StudySet, difficulty: GameDifficulty = .medium) {
        self.studySet = studySet
        self.difficulty = difficulty
        _viewModel = State(initialValue: TypingChallengeViewModel(studySet: studySet, difficulty: difficulty))
    }

    var body: some View {
        Group {
            if viewModel.isFinished, let result = viewModel.result {
                GameCompletionView(
                    game: game,
                    result: result,
                    onPlayAgain: { viewModel.restart(); isInputFocused = true },
                    onBackToGames: { dismiss() }
                )
            } else {
                gameplay
            }
        }
        .navigationTitle(game.localizedTitle)
        .navigationBarTitleDisplayMode(.inline)
        .gameRestartToolbar { viewModel.restart(); isInputFocused = true }
        .onAppear { isInputFocused = true }
    }

    private var gameplay: some View {
        VStack(spacing: AppSpacing.medium) {
            HStack {
                AnimatedProgressBar(progress: viewModel.progress, tint: game.color)
                if viewModel.streak > 1 {
                    Text("×\(viewModel.streak)")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.orange)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Capsule().fill(Color.orange.opacity(0.12)))
                }
            }
            .padding(.top, AppSpacing.small)

            if let word = viewModel.currentWord {
                VStack(spacing: 8) {
                    Text("Type the Hanzi for")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text(word.localizedMeaning)
                        .font(.largeTitle.weight(.bold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppSpacing.large)
                .background {
                    RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                }
            }

            TextField("Type Hanzi here", text: Binding(
                get: { viewModel.input },
                set: { viewModel.input = $0 }
            ))
                .font(.title.weight(.semibold))
                .multilineTextAlignment(.center)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                        .overlay {
                            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                                .strokeBorder(inputBorderColor, lineWidth: viewModel.showResult ? 1.5 : 0.5)
                        }
                }
                .focused($isInputFocused)
                .disabled(viewModel.showResult)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            if viewModel.showResult {
                resultFeedback
            }

            Button(viewModel.showResult ? "Next" : "Check") {
                if viewModel.showResult {
                    advance()
                } else {
                    submit()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(game.color)
            .disabled(!viewModel.showResult && viewModel.input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.bottom, AppSpacing.medium)
    }

    private var inputBorderColor: Color {
        guard viewModel.showResult else { return Color.primary.opacity(0.08) }
        return viewModel.wasCorrect ? .green.opacity(0.5) : .red.opacity(0.5)
    }

    @ViewBuilder
    private var resultFeedback: some View {
        if viewModel.wasCorrect {
            Label("Perfect!", systemImage: "checkmark.circle.fill")
                .foregroundStyle(.green)
                .font(.headline.weight(.semibold))
        } else if let word = viewModel.currentWord {
            VStack(spacing: 4) {
                Label("Correct answer", systemImage: "xmark.circle.fill")
                    .foregroundStyle(.red)
                    .font(.subheadline.weight(.semibold))

                Text(word.hanzi)
                    .font(.title.weight(.bold))
            }
        }
    }

    private func submit() {
        viewModel.submit()

        if viewModel.wasCorrect {
            HapticService.success()
            SoundService.success()
        } else {
            HapticService.rigid()
            SoundService.error()
            if let word = viewModel.currentWord {
                smartReviewStore.recordWrong(word: word, studySet: studySet)
            }
        }
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
            isInputFocused = true
        }
    }
}
