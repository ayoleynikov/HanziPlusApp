//
//  SentenceBuilderView.swift
//  HanziPlus
//

import SwiftUI

struct SentenceBuilderView: View {

    let studySet: StudySet
    let difficulty: GameDifficulty

    @State private var viewModel: SentenceBuilderViewModel

    @Environment(\.dismiss) private var dismiss
    @Environment(GameScoreStore.self) private var scoreStore
    @Environment(StatisticsStore.self) private var statisticsStore

    private let game = GameDefinition.definition(for: .sentenceBuilder)

    init(studySet: StudySet, difficulty: GameDifficulty = .medium) {
        self.studySet = studySet
        self.difficulty = difficulty
        _viewModel = State(initialValue: SentenceBuilderViewModel(studySet: studySet, difficulty: difficulty))
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
            } else if !viewModel.hasPuzzles {
                ContentUnavailableView(
                    "No Sentences Available",
                    systemImage: "text.word.spacing",
                    description: Text("This study set doesn't have enough example sentences yet.")
                )
            } else {
                gameplay
            }
        }
        .navigationTitle(game.localizedTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var gameplay: some View {
        VStack(spacing: AppSpacing.medium) {
            progressSection

            if let puzzle = viewModel.currentPuzzle {
                englishHint(puzzle.english)

                buildArea
                    .dropDestination(for: String.self) { items, _ in
                        guard let token = items.first else { return false }
                        viewModel.moveToBuilt(token)
                        return true
                    }

                Text("Drag words to build the sentence")
                    .font(.caption)
                    .foregroundStyle(.tertiary)

                wordBank

                if viewModel.isPuzzleComplete && !viewModel.showResult {
                    Button("Check Sentence") {
                        viewModel.checkAnswer()
                        if viewModel.wasCorrect {
                            HapticService.success()
                        } else {
                            HapticService.rigid()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(game.color)
                }

                if viewModel.showResult {
                    resultBanner(correct: viewModel.wasCorrect, puzzle: puzzle)
                }
            }

            Spacer(minLength: AppSpacing.small)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.bottom, AppSpacing.medium)
        .onChange(of: viewModel.showResult) { _, showResult in
            guard showResult else { return }

            Task {
                try? await Task.sleep(for: .seconds(1.2))

                await MainActor.run {
                    if viewModel.currentIndex >= viewModel.puzzles.count - 1 {
                        viewModel.finish(scoreStore: scoreStore, statisticsStore: statisticsStore)
                    } else {
                        viewModel.nextPuzzle()
                    }
                }
            }
        }
    }

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(viewModel.currentIndex + 1) / \(viewModel.puzzles.count)")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)

                Spacer()

                Text("\(viewModel.correctCount) correct")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(game.color)
            }

            AnimatedProgressBar(progress: viewModel.progress, tint: game.color)
        }
        .padding(.top, AppSpacing.small)
    }

    private func englishHint(_ text: String) -> some View {
        Text(text)
            .font(.title3.weight(.medium))
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.medium)
    }

    private var buildArea: some View {
        FlowLayout(spacing: 10) {
            ForEach(Array(viewModel.builtTokens.enumerated()), id: \.offset) { index, token in
                SentenceTokenChip(
                    text: token,
                    style: viewModel.showResult
                        ? (viewModel.wasCorrect ? .correct : .incorrect)
                        : .placed
                )
                .draggable(token)
                .onTapGesture {
                    viewModel.moveToBank(token)
                }
                .dropDestination(for: String.self) { items, _ in
                    guard let dropped = items.first else { return false }
                    viewModel.insertBuilt(dropped, at: index)
                    return true
                }
            }

            if viewModel.builtTokens.isEmpty {
                Text("Drop words here")
                    .font(.subheadline)
                    .foregroundStyle(.tertiary)
                    .frame(maxWidth: .infinity, minHeight: 56)
            }
        }
        .padding(AppSpacing.medium)
        .frame(maxWidth: .infinity, minHeight: 88, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                        .strokeBorder(
                            viewModel.showResult
                                ? (viewModel.wasCorrect ? Color.green.opacity(0.4) : Color.red.opacity(0.4))
                                : Color.primary.opacity(0.06),
                            lineWidth: viewModel.showResult ? 1.5 : 0.5
                        )
                }
        }
        .animation(.spring(response: 0.38, dampingFraction: 0.78), value: viewModel.builtTokens)
        .studyCardShadow()
    }

    private var wordBank: some View {
        FlowLayout(spacing: 10) {
            ForEach(viewModel.bankTokens, id: \.self) { token in
                SentenceTokenChip(text: token, style: .bank)
                    .draggable(token)
                    .onTapGesture {
                        viewModel.moveToBuilt(token)
                    }
            }
        }
        .padding(AppSpacing.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.tertiarySystemGroupedBackground))
        }
    }

    private func resultBanner(correct: Bool, puzzle: SentencePuzzle) -> some View {
        VStack(spacing: 6) {
            Label(
                correct ? "Correct!" : "Not quite",
                systemImage: correct ? "checkmark.circle.fill" : "xmark.circle.fill"
            )
            .font(.headline.weight(.semibold))
            .foregroundStyle(correct ? .green : .red)

            if !correct {
                Text(puzzle.hanzi)
                    .font(.title3.weight(.semibold))
            }
        }
        .transition(.scale.combined(with: .opacity))
        .animation(.spring(response: 0.4, dampingFraction: 0.72), value: correct)
    }
}

private struct SentenceTokenChip: View {

    enum Style {
        case bank
        case placed
        case correct
        case incorrect
    }

    let text: String
    let style: Style

    var body: some View {
        Text(text)
            .font(.title3.weight(.semibold))
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background {
                Capsule(style: .continuous)
                    .fill(backgroundColor)
            }
            .overlay {
                Capsule(style: .continuous)
                    .strokeBorder(borderColor, lineWidth: 0.5)
            }
    }

    private var backgroundColor: Color {
        switch style {
        case .bank: Color(.secondarySystemGroupedBackground)
        case .placed: Color.accentColor.opacity(0.1)
        case .correct: Color.green.opacity(0.16)
        case .incorrect: Color.red.opacity(0.16)
        }
    }

    private var borderColor: Color {
        switch style {
        case .bank: Color.primary.opacity(0.08)
        case .placed: Color.accentColor.opacity(0.25)
        case .correct: Color.green.opacity(0.4)
        case .incorrect: Color.red.opacity(0.4)
        }
    }
}

/// Simple wrapping layout for sentence tokens.
private struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrange(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrange(proposal: proposal, subviews: subviews)

        for (index, position) in result.positions.enumerated() {
            subviews[index].place(
                at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
                proposal: ProposedViewSize(result.sizes[index])
            )
        }
    }

    private func arrange(proposal: ProposedViewSize, subviews: Subviews) -> Arrangement {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var sizes: [CGSize] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)

            if x + size.width > maxWidth, x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }

            positions.append(CGPoint(x: x, y: y))
            sizes.append(size)
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }

        let totalHeight = y + rowHeight
        return Arrangement(
            positions: positions,
            sizes: sizes,
            size: CGSize(width: maxWidth, height: totalHeight)
        )
    }

    private struct Arrangement {
        let positions: [CGPoint]
        let sizes: [CGSize]
        let size: CGSize
    }
}

#Preview {
    NavigationStack {
        SentenceBuilderView(studySet: SampleStudySets.all[0])
    }
    .environment(GameScoreStore())
    .environment(StatisticsStore())
}
