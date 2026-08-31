//
//  QuizMistakeFeedbackCard.swift
//  HanziPlus
//

import SwiftUI

struct QuizMistakeFeedbackCard: View {

    let word: Word
    let correctAnswer: String
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Label(L10n.string("quiz.mistake.title"), systemImage: "xmark.circle.fill")
                .font(.headline.weight(.semibold))
                .foregroundStyle(.red)

            VStack(spacing: 8) {
                Text(word.hanzi)
                    .font(.system(size: 48, weight: .bold))

                Text(word.pinyin)
                    .font(.title3.weight(.medium))
                    .foregroundStyle(.secondary)

                Text(correctAnswer)
                    .font(.body.weight(.semibold))
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)

            Button(action: onContinue) {
                Text(l10n: "common.continue")
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Capsule(style: .continuous).fill(Color.accentColor))
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
    }
}
