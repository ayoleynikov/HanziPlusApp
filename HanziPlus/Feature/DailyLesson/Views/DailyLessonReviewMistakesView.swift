//
//  DailyLessonReviewMistakesView.swift
//  HanziPlus
//

import SwiftUI

struct DailyLessonReviewMistakesView: View {

    let word: Word
    let options: [String]
    let selectedAnswer: String?
    let showFeedback: Bool
    let onSelect: (String) -> Void
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            VStack(spacing: 12) {
                Text(word.hanzi)
                    .font(.system(size: 48, weight: .bold))
                    .minimumScaleFactor(0.5)

                Text(word.pinyin)
                    .font(.title3)
                    .foregroundStyle(.secondary)

                Text(word.localizedMeaning)
                    .font(.title3.weight(.semibold))
                    .multilineTextAlignment(.center)

                DailyLessonSpeakButton(text: word.hanzi)
            }
            .frame(maxWidth: .infinity)
            .padding(AppSpacing.large)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
            }
            .studyCardShadow()
            .accessibilityElement(children: .combine)
            .accessibilityLabel("\(word.hanzi), \(word.pinyin), \(word.localizedMeaning)")

            Text("Confirm the meaning")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: AppSpacing.small) {
                ForEach(options, id: \.self) { option in
                    DailyLessonOptionButton(
                        text: option,
                        emphasizesHanzi: false,
                        isSelected: selectedAnswer == option,
                        isCorrect: option == word.localizedMeaning,
                        showResult: showFeedback,
                        action: { onSelect(option) }
                    )
                }
            }

            Spacer(minLength: 0)

            if showFeedback {
                Button(action: onContinue) {
                    Text("Continue")
                        .font(.body.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .frame(minHeight: 44)
                        .background(Capsule(style: .continuous).fill(Color.orange))
                        .foregroundStyle(.white)
                }
                .buttonStyle(.plain)
            }
        }
    }
}
