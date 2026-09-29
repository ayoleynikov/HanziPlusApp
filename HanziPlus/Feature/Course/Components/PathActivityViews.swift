//
//  PathActivityViews.swift
//  HanziPlus
//

import SwiftUI

struct PathSentenceBuilderView: View {

    let activity: PathSentenceBuilderActivity
    let selectedTokenIDs: [String]
    let showFeedback: Bool
    let wasCorrect: Bool
    let explanation: String?
    let onToggleToken: (String) -> Void
    let onSubmit: () -> Void
    let onContinue: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var builtHanzi: String {
        selectedTokenIDs.compactMap { id in
            activity.tokens.first(where: { $0.id == id })?.text
        }.joined()
    }

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            Text(PathStrings.sentenceBuilderTitle)
                .font(.headline.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(activity.prompt.localizedValue())
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(builtHanzi)
                .font(.title2.weight(.bold))
                .frame(maxWidth: .infinity, minHeight: 56)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                }

            FlowTokenLayout(tokens: activity.tokens, selectedIDs: selectedTokenIDs, onTap: onToggleToken)

            if !showFeedback {
                Button(action: onSubmit) {
                    Text(PathStrings.checkAnswer)
                        .font(.body.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .frame(minHeight: 44)
                        .background(Capsule(style: .continuous).fill(Color.teal))
                        .foregroundStyle(.white)
                }
                .buttonStyle(.plain)
                .disabled(selectedTokenIDs.count != activity.correctOrder.count)
                .accessibilityIdentifier("path_sentence_builder_submit")
            }

            Spacer(minLength: 0)
        }
        .overlay(alignment: .bottom) {
            if showFeedback {
                PathActivityFeedbackCard(
                    wasCorrect: wasCorrect,
                    resultHanzi: activity.resultHanzi,
                    resultPinyin: activity.resultPinyin,
                    resultTranslation: activity.resultTranslation.localizedValue(),
                    explanation: explanation ?? activity.explanation?.localizedValue(),
                    onContinue: onContinue
                )
                .transition(PathMotion.feedbackTransition(reduceMotion: reduceMotion))
            }
        }
        .animation(PathMotion.springAnimation(reduceMotion: reduceMotion), value: showFeedback)
        .accessibilityIdentifier("path_sentence_builder")
    }
}

struct PathFillBlankView: View {

    let activity: PathFillBlankActivity
    let selectedAnswer: String?
    let showFeedback: Bool
    let wasCorrect: Bool
    let explanation: String?
    let onSelect: (String) -> Void
    let onContinue: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            Text(PathStrings.fillBlankTitle)
                .font(.headline.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(activity.template.replacingOccurrences(of: activity.blankToken, with: "___"))
                .font(.title.weight(.bold))
                .multilineTextAlignment(.center)

            VStack(spacing: 10) {
                ForEach(activity.options, id: \.self) { option in
                    Button {
                        onSelect(option)
                    } label: {
                        Text(option)
                            .font(.body.weight(.semibold))
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background {
                                RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                                    .fill(optionBackground(option))
                            }
                    }
                    .buttonStyle(.plain)
                    .disabled(showFeedback)
                }
            }

            Spacer(minLength: 0)
        }
        .overlay(alignment: .bottom) {
            if showFeedback {
                PathActivityFeedbackCard(
                    wasCorrect: wasCorrect,
                    resultHanzi: activity.resultHanzi,
                    resultPinyin: activity.resultPinyin,
                    resultTranslation: activity.resultTranslation.localizedValue(),
                    explanation: explanation ?? activity.explanation?.localizedValue(),
                    onContinue: onContinue
                )
                .transition(PathMotion.feedbackTransition(reduceMotion: reduceMotion))
            }
        }
        .animation(PathMotion.springAnimation(reduceMotion: reduceMotion), value: showFeedback)
        .accessibilityIdentifier("path_fill_blank")
    }

    private func optionBackground(_ option: String) -> Color {
        guard showFeedback else {
            return option == selectedAnswer ? Color.teal.opacity(0.18) : Color(.secondarySystemGroupedBackground)
        }
        if option == activity.correctOption { return Color.green.opacity(0.18) }
        if option == selectedAnswer { return Color.red.opacity(0.18) }
        return Color(.secondarySystemGroupedBackground)
    }
}

struct PathDialogueOrderView: View {

    let activity: PathDialogueOrderActivity
    let selectedOrder: [String]
    let showFeedback: Bool
    let wasCorrect: Bool
    let explanation: String?
    let onToggleLine: (String) -> Void
    let onSubmit: () -> Void
    let onContinue: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            Text(PathStrings.dialogueOrderTitle)
                .font(.headline.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(activity.prompt.localizedValue())
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 10) {
                ForEach(activity.lines) { line in
                    let position = selectedOrder.firstIndex(of: line.id).map { $0 + 1 }
                    Button {
                        onToggleLine(line.id)
                    } label: {
                        HStack {
                            if let position {
                                Text("\(position)")
                                    .font(.caption.weight(.bold))
                                    .foregroundStyle(.teal)
                                    .frame(width: 24, height: 24)
                                    .background(Circle().fill(Color.teal.opacity(0.15)))
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                if let speaker = line.speaker {
                                    Text(speaker)
                                        .font(.caption.weight(.semibold))
                                        .foregroundStyle(.secondary)
                                }
                                Text(line.hanzi)
                                    .font(.body.weight(.semibold))
                            }
                            Spacer()
                        }
                        .padding(12)
                        .frame(minHeight: 44)
                        .background {
                            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                                .fill(Color(.secondarySystemGroupedBackground))
                        }
                    }
                    .buttonStyle(.plain)
                    .disabled(showFeedback)
                }
            }

            if !showFeedback {
                Button(action: onSubmit) {
                    Text(PathStrings.checkAnswer)
                        .font(.body.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .frame(minHeight: 44)
                        .background(Capsule(style: .continuous).fill(Color.teal))
                        .foregroundStyle(.white)
                }
                .buttonStyle(.plain)
                .disabled(selectedOrder.count != activity.lines.count)
                .accessibilityIdentifier("path_dialogue_order_submit")
            }

            Spacer(minLength: 0)
        }
        .overlay(alignment: .bottom) {
            if showFeedback {
                PathActivityFeedbackCard(
                    wasCorrect: wasCorrect,
                    resultHanzi: activity.resultHanzi,
                    resultPinyin: activity.resultPinyin,
                    resultTranslation: activity.resultTranslation?.localizedValue(),
                    explanation: explanation ?? activity.explanation?.localizedValue(),
                    onContinue: onContinue
                )
                .transition(PathMotion.feedbackTransition(reduceMotion: reduceMotion))
            }
        }
        .animation(PathMotion.springAnimation(reduceMotion: reduceMotion), value: showFeedback)
        .accessibilityIdentifier("path_dialogue_order")
    }
}

private struct FlowTokenLayout: View {
    let tokens: [PathSentenceBuilderToken]
    let selectedIDs: [String]
    let onTap: (String) -> Void

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 56), spacing: 8)], spacing: 8) {
            ForEach(tokens) { token in
                let isSelected = selectedIDs.contains(token.id)
                Button {
                    onTap(token.id)
                } label: {
                    Text(token.text)
                        .font(.body.weight(.semibold))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .frame(minHeight: 44)
                        .background {
                            Capsule(style: .continuous)
                                .fill(isSelected ? Color.teal.opacity(0.2) : Color(.secondarySystemGroupedBackground))
                        }
                }
                .buttonStyle(.plain)
            }
        }
    }
}
