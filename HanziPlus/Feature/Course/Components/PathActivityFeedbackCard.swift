//
//  PathActivityFeedbackCard.swift
//  HanziPlus
//

import SwiftUI

struct PathActivityFeedbackCard: View {

    let wasCorrect: Bool
    let resultHanzi: String
    let resultPinyin: String
    let resultTranslation: String?
    let explanation: String?
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: 14) {
            Label(
                wasCorrect ? PathStrings.correctAnswer : PathStrings.feedbackCorrectAnswerTitle,
                systemImage: wasCorrect ? "checkmark.circle.fill" : "lightbulb.fill"
            )
            .font(.headline.weight(.semibold))
            .foregroundStyle(wasCorrect ? .green : .orange)
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 6) {
                Text(resultHanzi)
                    .font(.title2.weight(.bold))
                    .multilineTextAlignment(.center)

                if !resultPinyin.isEmpty {
                    Text(resultPinyin)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }

                if let resultTranslation, !resultTranslation.isEmpty {
                    Text(resultTranslation)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity)

            if let explanation, !explanation.isEmpty {
                Text(explanation)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(12)
                    .background {
                        RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                            .fill(Color(.tertiarySystemGroupedBackground))
                    }
            }

            Button(action: onContinue) {
                Text(PathStrings.next)
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .frame(minHeight: 44)
                    .background(Capsule(style: .continuous).fill(Color.teal))
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
        .padding(.horizontal, AppSpacing.medium)
        .padding(.bottom, AppSpacing.medium)
        .accessibilityIdentifier("path_activity_feedback")
    }
}
