//
//  PathMistakeReviewView.swift
//  HanziPlus
//

import SwiftUI

struct PathMistakeReviewView: View {

    let mistakes: [PathCourseMistake]
    let item: PathVocabularyItem
    let options: [String]
    let selectedAnswer: String?
    let showFeedback: Bool
    let wasCorrect: Bool
    let explanation: String?
    let onSelect: (String) -> Void
    let onContinue: () -> Void

    private var remainingCount: Int {
        mistakes.filter { !$0.isRemediated }.count
    }

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            Text(PathStrings.mistakeReviewTitle)
                .font(.headline.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(PathStrings.mistakesRemaining(remainingCount))
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(item.hanzi)
                .font(.system(size: 42, weight: .bold))
            Text(item.pinyin)
                .font(.title3)
                .foregroundStyle(.secondary)

            VStack(spacing: 10) {
                ForEach(options, id: \.self) { option in
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
                    resultHanzi: item.hanzi,
                    resultPinyin: item.pinyin,
                    resultTranslation: item.localizedTranslation,
                    explanation: explanation,
                    onContinue: onContinue
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.86), value: showFeedback)
        .accessibilityIdentifier("path_mistake_review")
    }

    private func optionBackground(_ option: String) -> Color {
        guard showFeedback else {
            return option == selectedAnswer ? Color.teal.opacity(0.18) : Color(.secondarySystemGroupedBackground)
        }
        if option == item.localizedTranslation { return Color.green.opacity(0.18) }
        if option == selectedAnswer { return Color.red.opacity(0.18) }
        return Color(.secondarySystemGroupedBackground)
    }
}

struct PathChapterCompleteView: View {

    let chapter: PathLessonChapter
    let wordCount: Int
    let mistakesReviewed: Int
    let onContinue: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 64))
                .foregroundStyle(.green)
                .symbolEffect(.bounce, value: reduceMotion ? false : true)
                .accessibilityHidden(true)

            VStack(spacing: 8) {
                Text(PathStrings.chapterCompleteTitle)
                    .font(.title2.weight(.bold))
                Text(chapter.localizedTitle)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            VStack(spacing: 10) {
                summaryRow(icon: "character.book.closed", text: PathStrings.chapterWordsLearned(wordCount))
                if mistakesReviewed > 0 {
                    summaryRow(icon: "lightbulb.fill", text: PathStrings.mistakesFixedLabel(mistakesReviewed))
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
            }

            Spacer()

            PathContinueButton(
                title: PathStrings.backToChapterMap,
                accessibilityID: "path_chapter_complete_button",
                action: onContinue
            )
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("path_chapter_complete")
    }

    private func summaryRow(icon: String, text: String) -> some View {
        Label(text, systemImage: icon)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private extension PathLessonChapter {
    var localizedTitle: String { title.localizedValue() }
}
