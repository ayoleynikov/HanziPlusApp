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
    let wasCorrect: Bool
    let onSelect: (String) -> Void
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            VStack(spacing: 10) {
                Text(word.hanzi)
                    .font(.system(size: 52, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .accessibilityLabel(L10n.string("Chinese character \(word.hanzi)"))

                if showFeedback && wasCorrect {
                    Text(word.pinyin)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .transition(.opacity)
                        .accessibilityLabel(L10n.string("Pinyin \(word.pinyin)"))
                } else if !showFeedback {
                    Text(l10n: "lesson.meaning.prompt")
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
                ForEach(options.indices, id: \.self) { index in
                    let option = options[index]
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

            if showFeedback && wasCorrect {
                Button(action: onContinue) {
                    Text(l10n: "common.continue")
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
        .overlay(alignment: .bottom) {
            if showFeedback && !wasCorrect {
                QuizMistakeFeedbackCard(
                    word: word,
                    correctAnswer: word.localizedMeaning,
                    onContinue: onContinue
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.86), value: showFeedback)
    }
}
