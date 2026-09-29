//
//  PathGrammarCardView.swift
//  HanziPlus
//

import SwiftUI

struct PathGrammarCardView: View {

    let card: PathGrammarCard
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    Text(PathStrings.grammarTitle)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)

                    Text(card.title.localizedValue())
                        .font(.title2.weight(.bold))

                    Text(card.explanation.localizedValue())
                        .font(.body)
                        .foregroundStyle(.secondary)

                    if let formula = card.formula?.localizedValueOrNil() {
                        Text(formula)
                            .font(.headline.monospaced())
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background {
                                RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                                    .fill(Color.teal.opacity(0.12))
                            }
                    }

                    Text(PathStrings.grammarExamplesTitle)
                        .font(.headline.weight(.semibold))
                        .padding(.top, 4)

                    grammarExample(card.positiveExample, label: nil)

                    if let question = card.questionExample {
                        grammarExample(question, label: "?")
                    }

                    if let negative = card.negativeExample {
                        grammarExample(negative, label: "−")
                    }

                    Text(PathStrings.grammarExamplesHint)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.top, 4)
                }
            }

            Button(action: onContinue) {
                Text(PathStrings.next)
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .frame(minHeight: 44)
                    .background(Capsule(style: .continuous).fill(Color.teal))
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)
            .accessibilityIdentifier("path_continue_button")
        }
        .accessibilityIdentifier("path_grammar_card")
    }

    private func grammarExample(_ example: PathGrammarCard.PathGrammarExample, label: String?) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            if let label {
                Text(label)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
            }
            Text(example.hanzi)
                .font(.title3.weight(.semibold))
            Text(example.pinyin)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(example.translation.localizedValue())
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
    }
}
