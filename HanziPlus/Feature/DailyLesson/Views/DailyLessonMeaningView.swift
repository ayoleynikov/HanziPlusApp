//
//  DailyLessonMeaningView.swift
//  HanziPlus
//

import SwiftUI

struct DailyLessonMeaningView: View {

    let word: Word
    let options: [String]
    let selectedAnswer: String?
    let showFeedback: Bool
    let onSelect: (String) -> Void
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            VStack(spacing: 10) {
                Text(word.hanzi)
                    .font(.system(size: 52, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .accessibilityLabel("Chinese character \(word.hanzi)")

                if showFeedback {
                    Text(word.pinyin)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .transition(.opacity)
                        .accessibilityLabel("Pinyin \(word.pinyin)")
                } else {
                    Text("Choose the English meaning")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.large)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
            }
            .studyCardShadow()

            VStack(spacing: AppSpacing.small) {
                ForEach(options, id: \.self) { option in
                    DailyLessonOptionButton(
                        text: option,
                        emphasizesHanzi: false,
                        isSelected: selectedAnswer == option,
                        isCorrect: option == word.english,
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
