//
//  ListeningQuizView.swift
//  HanziPlus
//

import SwiftUI

struct ListeningQuizView: View {

    let studySet: StudySet
    let difficulty: GameDifficulty

    @State private var viewModel: ListeningQuizViewModel
    @State private var flashColor: Color = .clear
    @State private var pulseAudio = false

    @Environment(\.dismiss) private var dismiss
    @Environment(GameScoreStore.self) private var scoreStore
    @Environment(StatisticsStore.self) private var statisticsStore
    @Environment(AchievementStore.self) private var achievementStore
    @Environment(SmartReviewStore.self) private var smartReviewStore

    private let game = GameDefinition.definition(for: .listeningQuiz)

    init(studySet: StudySet, difficulty: GameDifficulty = .medium) {
        self.studySet = studySet
        self.difficulty = difficulty
        _viewModel = State(initialValue: ListeningQuizViewModel(studySet: studySet, difficulty: difficulty))
    }

    var body: some View {
        Group {
            if viewModel.isFinished, let result = viewModel.result {
                GameCompletionView(
                    game: game,
                    result: result,
                    onPlayAgain: {
                        viewModel.restart()
                        playCurrentAudio()
                    },
                    onBackToGames: { dismiss() }
                )
            } else {
                gameplay
            }
        }
        .navigationTitle(game.title)
        .navigationBarTitleDisplayMode(.inline)
        .gameRestartToolbar { viewModel.restart(); playCurrentAudio() }
        .onAppear { playCurrentAudio() }
    }

    private var gameplay: some View {
        VStack(spacing: AppSpacing.medium) {
            progressHeader

            Spacer(minLength: AppSpacing.small)

            audioSection

            Text("Which Hanzi did you hear?")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: AppSpacing.small) {
                ForEach(viewModel.options, id: \.self) { hanzi in
                    GameHanziOptionButton(
                        hanzi: hanzi,
                        isSelected: viewModel.selectedAnswer == hanzi,
                        isCorrect: hanzi == viewModel.currentWord?.hanzi,
                        showResult: viewModel.showResult,
                        action: { select(hanzi) }
                    )
                }
            }

            scoreFooter
            Spacer(minLength: AppSpacing.small)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.bottom, AppSpacing.medium)
        .background(flashColor.opacity(0.14).ignoresSafeArea())
        .onChange(of: viewModel.showResult) { _, show in
            guard show else { return }
            handleAdvance()
        }
        .onChange(of: viewModel.currentIndex) { _, _ in
            playCurrentAudio()
        }
    }

    private var progressHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(viewModel.currentIndex + 1) / \(viewModel.words.count)")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)
                Spacer()
                Text(difficulty.label)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(difficulty.color)
            }
            AnimatedProgressBar(progress: viewModel.progress, tint: game.color)
        }
        .padding(.top, AppSpacing.small)
    }

    private var audioSection: some View {
        VStack(spacing: 16) {
            Button {
                playCurrentAudio()
            } label: {
                ZStack {
                    Circle()
                        .fill(game.color.opacity(0.14))
                        .frame(width: 120, height: 120)

                    Image(systemName: "speaker.wave.3.fill")
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundStyle(game.color)
                        .symbolEffect(.pulse, value: pulseAudio)
                }
            }
            .buttonStyle(.plain)

            Text("Tap to replay")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppSpacing.medium)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
    }

    private var scoreFooter: some View {
        HStack(spacing: 20) {
            Label("\(viewModel.correctCount)", systemImage: "checkmark.circle.fill").foregroundStyle(.green)
            Label("\(viewModel.wrongCount)", systemImage: "xmark.circle.fill").foregroundStyle(.red)
        }
        .font(.subheadline.weight(.semibold))
    }

    private func playCurrentAudio() {
        guard let word = viewModel.currentWord else { return }
        viewModel.markAudioPlayed()
        pulseAudio.toggle()
        SpeechService.shared.speak(word.hanzi)
        HapticService.light()
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

    private func handleAdvance() {
        Task {
            try? await Task.sleep(for: .seconds(0.7))
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
