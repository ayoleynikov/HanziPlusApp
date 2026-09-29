//
//  PathChapterMapView.swift
//  HanziPlus
//

import SwiftUI

struct PathChapterMapView: View {

    let lesson: PathLesson
    let onSelectChapter: (PathLessonChapter) -> Void
    let onContinue: () -> Void

    @Environment(PathCourseStore.self) private var pathStore
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var currentChapter: PathLessonChapter? {
        pathStore.currentChapter(for: lesson)
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.medium) {
                    lessonHeader

                    VStack(spacing: 0) {
                        ForEach(Array(lesson.chapters.enumerated()), id: \.element.id) { index, chapter in
                            chapterNode(chapter, number: index + 1, isLast: index == lesson.chapters.count - 1)
                        }
                    }
                }
                .padding(AppSpacing.medium)
                .padding(.bottom, AppSpacing.medium)
            }

            if currentChapter != nil {
                PathContinueButton(title: PathStrings.continueChapter, action: onContinue)
                    .padding(.horizontal, AppSpacing.medium)
                    .padding(.vertical, AppSpacing.small)
                    .background(.bar)
                    .accessibilityIdentifier("path_chapter_map_continue")
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .accessibilityIdentifier("path_chapter_map")
    }

    private var lessonHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(PathStrings.lessonPrefix) \(lesson.number)")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
            Text(lesson.chineseTitle)
                .font(.title2.weight(.bold))
            if let translation = lesson.localizedTranslationTitle {
                Text(translation)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
    }

    private func chapterNode(_ chapter: PathLessonChapter, number: Int, isLast: Bool) -> some View {
        let status = pathStore.chapterStatus(for: lesson, chapter: chapter)
        let isCurrent = currentChapter?.id == chapter.id
        let isInteractive = status != .locked

        return HStack(alignment: .top, spacing: 14) {
            VStack(spacing: 0) {
                chapterMarker(status: status, number: number, isCurrent: isCurrent)
                if !isLast {
                    Rectangle()
                        .fill(trailColor(for: status))
                        .frame(width: 3)
                        .frame(minHeight: 24)
                }
            }

            Button {
                guard isInteractive else { return }
                onSelectChapter(chapter)
            } label: {
                chapterCard(chapter, status: status, isCurrent: isCurrent, isInteractive: isInteractive)
                    .accessibilityHidden(true)
            }
            .buttonStyle(.plain)
            .disabled(!isInteractive)
            .accessibilityIdentifier("path_chapter_\(chapter.number)")
            .accessibilityLabel(chapter.localizedTitle)
            .accessibilityHint(isInteractive ? PathStrings.continueChapter : PathStrings.chapterLocked)
            .accessibilityAddTraits(.isButton)
        }
        .padding(.bottom, isLast ? 0 : AppSpacing.small)
        .animation(PathMotion.springAnimation(reduceMotion: reduceMotion), value: isCurrent)
    }

    private func chapterMarker(status: PathChapterStatus, number: Int, isCurrent: Bool) -> some View {
        ZStack {
            Circle()
                .fill(markerFill(status: status, isCurrent: isCurrent))
                .frame(width: isCurrent ? 34 : 28, height: isCurrent ? 34 : 28)

            switch status {
            case .completed:
                Image(systemName: "checkmark")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.green)
            case .locked:
                Image(systemName: "lock.fill")
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.secondary)
            case .available, .inProgress:
                Text("\(number)")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(PathCourseAccent.primary)
            }
        }
        .accessibilityHidden(true)
    }

    private func chapterCard(
        _ chapter: PathLessonChapter,
        status: PathChapterStatus,
        isCurrent: Bool,
        isInteractive: Bool
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(chapter.localizedTitle)
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.primary)
                    if let goal = chapter.goal?.localizedValueOrNil() {
                        Text(goal)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                }
                Spacer(minLength: 8)
                statusBadge(status)
            }

            HStack(spacing: 12) {
                Label("\(chapter.newWordCount)", systemImage: "character.book.closed")
                Label(PathStrings.estimatedMinutesLabel(chapter.estimatedMinutes), systemImage: "clock")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
                .overlay {
                    if isCurrent {
                        RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                            .strokeBorder(PathCourseAccent.primary, lineWidth: 2)
                    } else if status == .completed {
                        RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                            .strokeBorder(Color.green.opacity(0.35), lineWidth: 1)
                    }
                }
        }
        .opacity(isInteractive ? 1 : 0.78)
        .scaleEffect(isCurrent && !reduceMotion ? 1.01 : 1)
    }

    private func markerFill(status: PathChapterStatus, isCurrent: Bool) -> Color {
        switch status {
        case .completed: return Color.green.opacity(0.18)
        case .locked: return Color(.tertiarySystemFill)
        case .available: return PathCourseAccent.primary.opacity(0.12)
        case .inProgress: return PathCourseAccent.primary.opacity(isCurrent ? 0.28 : 0.18)
        }
    }

    private func trailColor(for status: PathChapterStatus) -> Color {
        status == .completed ? Color.green.opacity(0.35) : Color(.separator).opacity(0.5)
    }

    @ViewBuilder
    private func statusBadge(_ status: PathChapterStatus) -> some View {
        switch status {
        case .locked:
            Label(PathStrings.chapterLocked, systemImage: "lock.fill")
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.secondary)
        case .available:
            Label(PathStrings.chapterAvailable, systemImage: "circle")
                .font(.caption2.weight(.semibold))
                .foregroundStyle(PathCourseAccent.primary)
        case .inProgress:
            Label(PathStrings.chapterInProgress, systemImage: "play.circle.fill")
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.orange)
        case .completed:
            Label(PathStrings.chapterCompleted, systemImage: "checkmark.circle.fill")
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.green)
        }
    }
}

private extension PathLessonChapter {
    var localizedTitle: String {
        title.localizedValue()
    }
}
