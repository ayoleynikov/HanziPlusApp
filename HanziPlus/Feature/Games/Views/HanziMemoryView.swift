//
//  HanziMemoryView.swift
//  HanziPlus
//

import SwiftUI

struct HanziMemoryView: View {

    let studySet: StudySet
    let difficulty: GameDifficulty
    let matchMode: MemoryMatchMode

    @State private var viewModel: HanziMemoryViewModel

    @Environment(\.dismiss) private var dismiss
    @Environment(GameScoreStore.self) private var scoreStore
    @Environment(StatisticsStore.self) private var statisticsStore
    @Environment(AchievementStore.self) private var achievementStore
    @Environment(GameSessionStore.self) private var sessionStore
    @Environment(SmartReviewStore.self) private var smartReviewStore

    private let game = GameDefinition.definition(for: .hanziMemory)
    private let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    init(studySet: StudySet, difficulty: GameDifficulty = .medium, matchMode: MemoryMatchMode) {
        self.studySet = studySet
        self.difficulty = difficulty
        self.matchMode = matchMode
        _viewModel = State(initialValue: HanziMemoryViewModel(
            studySet: studySet,
            difficulty: difficulty,
            matchMode: matchMode
        ))
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
        .onAppear { persistActiveSession() }
        .onChange(of: viewModel.evaluationSerial) { _, _ in
            if let evaluation = viewModel.lastEvaluation {
                smartReviewStore.recordAttempt(
                    fileName: studySet.fileName,
                    hanzi: evaluation.word.hanzi,
                    correct: evaluation.correct
                )
            }
        }
        .onChange(of: viewModel.matchedPairs) { _, matched in
            persistActiveSession()
            if matched == viewModel.totalPairs {
                HapticService.success()
                SoundService.success()
                sessionStore.clear()
                viewModel.finish(
                    scoreStore: scoreStore,
                    statisticsStore: statisticsStore,
                    achievementStore: achievementStore
                )
            }
        }
        .onChange(of: viewModel.moves) { _, _ in
            persistActiveSession()
        }
        .onDisappear {
            if !viewModel.isFinished, viewModel.matchedPairs > 0 {
                persistActiveSession()
            }
        }
    }

    private func persistActiveSession() {
        guard !viewModel.isFinished else { return }
        sessionStore.save(
            ActiveGameSession(
                gameKind: .hanziMemory,
                studySetFileName: studySet.fileName,
                studySetTitle: studySet.localizedTitle,
                difficulty: difficulty,
                memoryMode: matchMode,
                progressLabel: "\(viewModel.matchedPairs) / \(viewModel.totalPairs) pairs",
                progressValue: viewModel.progress,
                savedAt: Date()
            )
        )
    }

    private var gameplay: some View {
        VStack(spacing: AppSpacing.medium) {
            HStack {
                Text(l10n: "games.memory.pairs_found")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)
                Text("\(viewModel.matchedPairs) / \(viewModel.totalPairs)")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(game.color)

                Spacer()

                Text(l10n: "games.memory.moves")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)
                Text("\(viewModel.moves)")
                    .font(.subheadline.weight(.semibold))
            }
            .padding(.top, AppSpacing.small)

            AnimatedProgressBar(progress: viewModel.progress, tint: game.color)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(Array(viewModel.cards.enumerated()), id: \.element.id) { index, card in
                    MemoryCardView(card: card) {
                        tapCard(at: index, card: card)
                    }
                }
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.bottom, AppSpacing.medium)
    }

    private func tapCard(at index: Int, card: MemoryCard) {
        guard !card.isMatched else { return }
        viewModel.flip(at: index)
        HapticService.light()

        if card.face == .audio, viewModel.cards[index].isFaceUp {
            SpeechService.shared.speak(card.word.hanzi)
        }
    }
}

private struct MemoryCardView: View {
    let card: MemoryCard
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(card.isMatched ? Color.green.opacity(0.16) : Color(.secondarySystemGroupedBackground))
                    .overlay {
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .strokeBorder(Color.primary.opacity(0.06), lineWidth: 0.5)
                    }

                if card.isFaceUp || card.isMatched {
                    Text(card.displayText)
                        .font(card.face == .hanzi ? .title2.weight(.bold) : .subheadline.weight(.semibold))
                        .multilineTextAlignment(.center)
                        .padding(8)
                } else {
                    Image(systemName: "character.book.closed.fill")
                        .font(.title3)
                        .foregroundStyle(.tertiary)
                }
            }
            .frame(height: 88)
            .rotation3DEffect(.degrees(card.isFaceUp || card.isMatched ? 0 : 180), axis: (x: 0, y: 1, z: 0))
            .animation(.spring(response: 0.42, dampingFraction: 0.78), value: card.isFaceUp)
            .animation(.spring(response: 0.42, dampingFraction: 0.78), value: card.isMatched)
        }
        .buttonStyle(.plain)
        .disabled(card.isMatched)
    }
}
