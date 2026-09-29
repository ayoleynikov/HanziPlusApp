//
//  PathLessonRow.swift
//  HanziPlus
//

import SwiftUI

struct PathLessonRow: View {

    let lesson: PathLessonSummary
    let status: PathLessonStatus
    let isUnlocked: Bool
    let chapterProgress: Double

    private var isComingSoon: Bool { !lesson.isAvailable }

    private var lessonMeta: (chapters: Int, minutes: Int)? {
        guard let contentFile = lesson.contentFile,
              let loaded = PathCourseLoader.loadLesson(fileName: contentFile) else { return nil }
        let minutes = loaded.chapters.reduce(0) { $0 + $1.estimatedMinutes }
        return (loaded.chapters.count, minutes)
    }

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
            lessonNumberBadge

            VStack(alignment: .leading, spacing: 8) {
                Text(lesson.chineseTitle)
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(isUnlocked ? .primary : .secondary)

                if let translation = lesson.localizedTranslationTitle {
                    Text(translation)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }

                if let meta = lessonMeta {
                    HStack(spacing: 10) {
                        Label(PathStrings.chaptersCountLabel(meta.chapters), systemImage: "map")
                        Label(PathStrings.estimatedMinutesLabel(meta.minutes), systemImage: "clock")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }

                if isUnlocked, chapterProgress > 0, status != .completed {
                    ProgressView(value: chapterProgress)
                        .tint(PathCourseAccent.primary)
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
                    .accessibilityLabel(isUnlocked ? statusLabel : lockLabel)
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
                .overlay {
                    if isUnlocked && status == .inProgress {
                        RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                            .strokeBorder(PathCourseAccent.primary.opacity(0.35), lineWidth: 1.5)
                    }
                }
        }
        .opacity(isUnlocked ? 1 : 0.82)
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("path_lesson_\(lesson.id)")
        .accessibilityAddTraits(isUnlocked ? .isButton : [])
    }

    private var lessonNumberBadge: some View {
        Text(PathStrings.lessonNumber(lesson.number))
            .font(.caption.weight(.bold))
            .foregroundStyle(isUnlocked ? PathCourseAccent.primary : .secondary)
            .frame(width: 40, height: 40)
            .background {
                Circle()
                    .fill(PathCourseAccent.primary.opacity(isUnlocked ? 0.14 : 0.08))
            }
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
            isUnlocked: true,
            chapterProgress: 0.5
        )
    }
    .padding()
}
