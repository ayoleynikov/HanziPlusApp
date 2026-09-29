//
//  PathVocabularySummaryView.swift
//  HanziPlus
//

import SwiftUI

struct PathVocabularySummaryView: View {

    let groups: [PathVocabularyGroup]
    let outsideDialogueWords: [PathVocabularyItem]
    let onContinue: () -> Void

    private var allItems: [PathVocabularyItem] {
        groups.flatMap(\.items).filter(\.countsInLessonTotal)
    }

    private var outsideDialogueIDs: Set<String> {
        Set(outsideDialogueWords.map(\.id))
    }

    private var totalWordCount: Int {
        allItems.count
    }

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.medium) {
                    header
                    hanziStrip
                    wordList
                }
            }

            continueButton
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .firstTextBaseline) {
                Text(PathStrings.lessonWords)
                    .font(.title3.weight(.bold))

                Spacer(minLength: 0)

                Text(PathStrings.wordCountLabel(totalWordCount))
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.teal)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background {
                        Capsule(style: .continuous)
                            .fill(Color.teal.opacity(0.12))
                    }
            }

            if !outsideDialogueWords.isEmpty {
                Text(PathStrings.otherLessonWordsNote)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var hanziStrip: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(allItems) { item in
                    Text(item.hanzi)
                        .font(.title3.weight(.semibold))
                        .frame(minWidth: 44, minHeight: 44)
                        .padding(.horizontal, 4)
                        .background {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(
                                    outsideDialogueIDs.contains(item.id)
                                        ? Color.orange.opacity(0.12)
                                        : Color.teal.opacity(0.12)
                                )
                        }
                }
            }
            .padding(.vertical, 2)
        }
    }

    @ViewBuilder
    private var wordList: some View {
        if groups.count == 1, let group = groups.first {
            wordGroupCard(group)
        } else {
            VStack(alignment: .leading, spacing: AppSpacing.small) {
                ForEach(groups) { group in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(group.localizedTitle)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.secondary)
                            .padding(.leading, 4)

                        wordGroupCard(group)
                    }
                }
            }
        }
    }

    private func wordGroupCard(_ group: PathVocabularyGroup) -> some View {
        VStack(spacing: 0) {
            ForEach(Array(group.items.enumerated()), id: \.element.id) { index, item in
                wordRow(item)

                if index < group.items.count - 1 {
                    Divider()
                        .padding(.leading, 62)
                }
            }
        }
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
    }

    private func wordRow(_ item: PathVocabularyItem) -> some View {
        let isOutsideDialogue = outsideDialogueIDs.contains(item.id)

        return HStack(alignment: .center, spacing: 14) {
            Text(item.hanzi)
                .font(.title2.weight(.bold))
                .frame(width: 48, height: 48)
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(
                            isOutsideDialogue
                                ? Color.orange.opacity(0.14)
                                : Color.teal.opacity(0.14)
                        )
                }

            VStack(alignment: .leading, spacing: 3) {
                Text(item.pinyin)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(item.localizedTranslation)
                    .font(.body.weight(.medium))
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
    }

    private var continueButton: some View {
        Button(action: onContinue) {
            Text(PathStrings.backToDialogue)
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

#Preview("Lesson 2") {
    let lesson = PathCourseLoader.loadLesson(fileName: "lesson_02") ?? PathCourseLoader.previewLesson()
    PathVocabularySummaryView(
        groups: lesson.resolvedVocabularySummaryGroups(),
        outsideDialogueWords: PathDialogueVocabularyHelper.vocabularyNotInDialogues(
            lesson: lesson,
            dialogues: lesson.dialogues
        ),
        onContinue: {}
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}
