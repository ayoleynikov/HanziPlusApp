//
//  PathLessonRow.swift
//  HanziPlus
//

import SwiftUI

struct PathLessonRow: View {

    let lesson: PathLessonSummary
    let status: PathLessonStatus
    let isUnlocked: Bool

    private var isComingSoon: Bool { !lesson.isAvailable }

    private var statusLabel: String {
        switch status {
        case .notStarted: return PathStrings.statusStart
        case .inProgress: return PathStrings.statusInProgress
        case .completed: return PathStrings.statusCompleted
        }
    }

    private var lockLabel: String {
        isComingSoon ? PathStrings.statusComingSoon : PathStrings.statusRequiresPriorLesson
    }

    private var statusTint: Color {
        switch status {
        case .notStarted: return .secondary
        case .inProgress: return .orange
        case .completed: return .green
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Text(PathStrings.lessonNumber(lesson.number))
                .font(.title3.weight(.bold))
                .foregroundStyle(isUnlocked ? .primary : .secondary)
                .frame(width: 36, alignment: .leading)

            VStack(alignment: .leading, spacing: 6) {
                Text(lesson.chineseTitle)
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(isUnlocked ? .primary : .secondary)

                if let translation = lesson.localizedTranslationTitle {
                    Text(translation)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                if lesson.vocabularyCount > 0 {
                    Text(PathStrings.wordCountLabel(lesson.vocabularyCount))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Text(isUnlocked ? statusLabel : lockLabel)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(isUnlocked ? statusTint : .secondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background {
                        Capsule(style: .continuous)
                            .fill(statusTint.opacity(isUnlocked ? 0.12 : 0.08))
                    }
            }

            Spacer(minLength: 0)

            if isUnlocked {
                Image(systemName: "chevron.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.tertiary)
                    .padding(.top, 4)
            } else {
                Image(systemName: "lock.fill")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                    .padding(.top, 4)
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .opacity(isUnlocked ? 1 : 0.72)
        .accessibilityIdentifier("path_lesson_\(lesson.id)")
    }
}

#Preview {
    VStack(spacing: 12) {
        PathLessonRow(
            lesson: PathLessonSummary(
                id: "lesson_01",
                number: 1,
                sourceLessonNumbers: [1, 2],
                chineseTitle: "你好！",
                pinyinTitle: nil,
                translationTitle: PathLocalizedText(legacyRussian: "Привет!"),
                vocabularyCount: 25,
                contentFile: "lesson_01",
                isAvailable: true
            ),
            status: .inProgress,
            isUnlocked: true
        )
    }
    .padding()
}
