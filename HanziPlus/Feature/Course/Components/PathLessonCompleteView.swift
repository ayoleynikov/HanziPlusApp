//
//  PathLessonCompleteView.swift
//  HanziPlus
//

import SwiftUI

struct PathLessonCompleteView: View {

    let lesson: PathLesson
    let onReplayDialogues: () -> Void
    let onRetryLesson: () -> Void
    let onNextLesson: (() -> Void)?

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.large) {
                VStack(spacing: 10) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(.green)

                    Text(PathStrings.lessonComplete)
                        .font(.title2.weight(.bold))

                    Text(PathStrings.lessonCompletedTitle(lesson.number))
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, AppSpacing.medium)

                lessonTitleCard

                studiedDialoguesSection

                VStack(alignment: .leading, spacing: 12) {
                    Text(PathStrings.newWordsLabel(lesson.countedVocabularyTotal))
                        .font(.headline.weight(.semibold))

                    ForEach(lesson.vocabularyGroups) { group in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(group.localizedTitle)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.secondary)

                            LazyVGrid(
                                columns: [GridItem(.adaptive(minimum: 44), spacing: 10)],
                                alignment: .leading,
                                spacing: 10
                            ) {
                                ForEach(group.items.filter(\.countsInLessonTotal)) { item in
                                    Text(item.hanzi)
                                        .font(.title3.weight(.semibold))
                                        .frame(minWidth: 44, minHeight: 44)
                                        .background {
                                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                                .fill(Color.teal.opacity(0.1))
                                        }
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(18)
                .background {
                    RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                }

                Button(action: onReplayDialogues) {
                    Label(PathStrings.replayDialogues, systemImage: "arrow.counterclockwise")
                        .font(.body.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .frame(minHeight: 44)
                        .background {
                            Capsule(style: .continuous)
                                .strokeBorder(Color.teal.opacity(0.35), lineWidth: 1)
                        }
                }
                .buttonStyle(.plain)

                Button(action: onRetryLesson) {
                    Label(PathStrings.retryLesson, systemImage: "arrow.counterclockwise")
                        .font(.body.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .frame(minHeight: 44)
                        .background {
                            Capsule(style: .continuous)
                                .strokeBorder(Color.teal.opacity(0.35), lineWidth: 1)
                        }
                }
                .buttonStyle(.plain)

                if let onNextLesson {
                    Button(action: onNextLesson) {
                        Text(PathStrings.nextLesson)
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
            .padding(.horizontal, AppSpacing.medium)
            .padding(.bottom, AppSpacing.extraLarge)
        }
    }

    private var lessonTitleCard: some View {
        VStack(spacing: 6) {
            Text(lesson.chineseTitle)
                .font(.largeTitle.weight(.bold))

            if let subtitle = lesson.chineseSubtitle {
                Text(subtitle)
                    .font(.title2.weight(.semibold))
            }

            if let translation = lesson.localizedTranslationTitle {
                Text(translation)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(18)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
    }

    private var studiedDialoguesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(PathStrings.studiedDialogues)
                .font(.headline.weight(.semibold))

            ForEach(lesson.dialogues) { dialogue in
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(dialogue.lines) { line in
                        Text(line.hanzi)
                            .font(.body.weight(.semibold))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(14)
                .background {
                    RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    PathLessonCompleteView(
        lesson: PathCourseLoader.previewLesson(),
        onReplayDialogues: {},
        onRetryLesson: {},
        onNextLesson: nil
    )
}
