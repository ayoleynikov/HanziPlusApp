//
//  PathQuizView.swift
//  HanziPlus
//

import SwiftUI

struct PathChineseQuizView: View {

    let item: PathVocabularyItem
    let options: [String]
    let selectedAnswer: String?
    let showFeedback: Bool
    let wasCorrect: Bool
    let explanation: String?
    let onSelect: (String) -> Void
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            VStack(spacing: 10) {
                Text(item.hanzi)
                    .font(.system(size: 52, weight: .bold))

                Text(item.pinyin)
                    .font(.title3)
                    .foregroundStyle(.secondary)

                Text(PathStrings.whatDoesWordMean)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
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
                        isCorrect: option == item.localizedTranslation,
                        showResult: showFeedback,
                        action: { onSelect(option) }
                    )
                }
            }

            if showFeedback {
                feedbackCard
            }

            Spacer(minLength: 0)

            if showFeedback {
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
            }
        }
        .animation(.easeInOut(duration: 0.2), value: showFeedback)
    }

    @ViewBuilder
    private var feedbackCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(
                wasCorrect ? PathStrings.correctAnswer : PathStrings.feedbackCorrectAnswerTitle,
                systemImage: wasCorrect ? "checkmark.circle.fill" : "lightbulb.fill"
            )
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(wasCorrect ? .green : .orange)

            Text(item.displayLabel)
                .font(.subheadline.weight(.semibold))

            if let explanation, !explanation.isEmpty {
                Text(explanation)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill((wasCorrect ? Color.green : Color.orange).opacity(0.12))
        }
    }
}

struct PathTranslationQuizView: View {

    let item: PathVocabularyItem
    let options: [PathVocabularyItem]
    let selectedAnswerID: String?
    let showFeedback: Bool
    let wasCorrect: Bool
    let explanation: String?
    let onSelect: (PathVocabularyItem) -> Void
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            VStack(spacing: 10) {
                Text(PathStrings.howToSayPrompt(item.localizedTranslation))
                    .font(.title3.weight(.semibold))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.large)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
            }
            .studyCardShadow()

            VStack(spacing: AppSpacing.small) {
                ForEach(options) { option in
                    DailyLessonOptionButton(
                        text: "\(option.hanzi) \(option.pinyin)",
                        emphasizesHanzi: true,
                        isSelected: selectedAnswerID == option.id,
                        isCorrect: option.id == item.id,
                        showResult: showFeedback,
                        action: { onSelect(option) }
                    )
                }
            }

            if showFeedback {
                feedbackCard
            }

            Spacer(minLength: 0)

            if showFeedback {
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
            }
        }
        .animation(.easeInOut(duration: 0.2), value: showFeedback)
    }

    @ViewBuilder
    private var feedbackCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(
                wasCorrect ? PathStrings.correctAnswer : PathStrings.feedbackCorrectAnswerTitle,
                systemImage: wasCorrect ? "checkmark.circle.fill" : "lightbulb.fill"
            )
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(wasCorrect ? .green : .orange)

            Text(item.displayLabel)
                .font(.subheadline.weight(.semibold))

            if let explanation, !explanation.isEmpty {
                Text(explanation)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill((wasCorrect ? Color.green : Color.orange).opacity(0.12))
        }
    }
}

#Preview {
    PathChineseQuizView(
        item: PathCourseLoader.previewLesson().allVocabulary.last!,
        options: ["лошадь", "белый", "один", "рот"],
        selectedAnswer: nil,
        showFeedback: false,
        wasCorrect: false,
        explanation: nil,
        onSelect: { _ in },
        onContinue: {}
    )
    .padding()
}
