//
//  PathCourseChrome.swift
//  HanziPlus
//

import SwiftUI

enum PathCourseAccent {
    static let primary = Color.teal
    static let chineseRed = Color(red: 0.78, green: 0.14, blue: 0.16)
    static let chineseGold = Color(red: 0.86, green: 0.66, blue: 0.22)
}

enum PathMotion {

    static func feedbackTransition(reduceMotion: Bool) -> AnyTransition {
        guard !reduceMotion else {
            return .opacity
        }
        return .move(edge: .bottom).combined(with: .opacity)
    }

    static func stepAnimation<V: Equatable>(reduceMotion: Bool, value: V) -> Animation? {
        reduceMotion ? nil : .easeInOut(duration: 0.25)
    }

    static func springAnimation(reduceMotion: Bool) -> Animation? {
        reduceMotion ? nil : .spring(response: 0.4, dampingFraction: 0.86)
    }
}

struct PathContinueButton: View {

    let title: String
    var isEnabled: Bool = true
    var accessibilityID: String = "path_continue_button"
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.body.weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .frame(minHeight: 44)
                .background {
                    Capsule(style: .continuous)
                        .fill(isEnabled ? PathCourseAccent.primary : Color.gray.opacity(0.35))
                }
                .foregroundStyle(.white)
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .accessibilityIdentifier(accessibilityID)
    }
}

struct PathFlowStepHeader: View {

    let chapterTitle: String
    let progress: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(chapterTitle)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .lineLimit(2)

            ProgressView(value: progress)
                .tint(PathCourseAccent.primary)
                .accessibilityLabel(PathStrings.chapterInProgress)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("path_flow_step_header")
    }
}

struct PathStudyCard<Content: View>: View {

  @ViewBuilder let content: Content

    var body: some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.large)
            .padding(.horizontal, AppSpacing.medium)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
            }
            .studyCardShadow()
    }
}

struct PathWordProgressBadge: View {

    let index: Int
    let total: Int

    var body: some View {
        Text("\(index + 1) / \(total)")
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.secondary)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background {
                Capsule(style: .continuous)
                    .fill(Color(.tertiarySystemFill))
            }
            .accessibilityLabel(L10n.string("path.word_progress_a11y \(index + 1) \(total)"))
    }
}

struct PathCourseProgressHero: View {

    let course: PathCourse
    let completedLessons: Int
    let progressFraction: Double
    let streakDays: Int
    let showContinueCTA: Bool
    let continueLesson: PathLessonSummary?
    let onShowDetails: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            PathCourseOverviewCard(course: course, onShowDetails: onShowDetails)

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Label(
                        PathStrings.courseLessonsLabel(
                            available: course.availableLessonCount,
                            total: course.totalLessons
                        ),
                        systemImage: "book.pages.fill"
                    )
                    Spacer()
                    Text(L10n.percent(Int(progressFraction * 100)))
                        .font(.caption.weight(.bold))
                        .foregroundStyle(PathCourseAccent.primary)
                }
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

                ProgressView(value: progressFraction)
                    .tint(PathCourseAccent.primary)

                HStack(spacing: 8) {
                    metaPill(
                        icon: "checkmark.circle.fill",
                        text: PathStrings.completedLessonsLabel(completedLessons, course.totalLessons)
                    )
                    if streakDays > 0 {
                        metaPill(icon: "flame.fill", text: PathStrings.streakDaysLabel(streakDays))
                    }
                }

                if showContinueCTA,
                   let continueLesson,
                   let contentFile = continueLesson.contentFile,
                   let loadedLesson = PathCourseLoader.loadLesson(fileName: contentFile) {
                    NavigationLink {
                        PathLessonFlowView(lesson: loadedLesson, autoResumeChapter: true)
                            .accessibilityIdentifier("path_lesson_flow")
                    } label: {
                        continueLessonLabel(continueLesson)
                    }
                    .buttonStyle(.plain)
                    .accessibilityIdentifier("path_course_continue_button")
                }
            }
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
            }
            .studyCardShadow()
        }
    }

    private func continueLessonLabel(_ continueLesson: PathLessonSummary) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(PathStrings.continueCourse)
                    .font(.body.weight(.semibold))
                Text(continueLesson.chineseTitle)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.9))
            }
            Spacer()
            Image(systemName: "arrow.right.circle.fill")
                .font(.title3)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .frame(minHeight: 44)
        .background {
            Capsule(style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [PathCourseAccent.primary, PathCourseAccent.primary.opacity(0.82)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
        .foregroundStyle(.white)
    }

    private func metaPill(icon: String, text: String) -> some View {
        Label(text, systemImage: icon)
            .font(.caption2.weight(.medium))
            .foregroundStyle(.secondary)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background {
                Capsule(style: .continuous)
                    .fill(Color(.tertiarySystemFill))
            }
            .lineLimit(1)
            .minimumScaleFactor(0.85)
    }
}
