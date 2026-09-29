//
//  PathCourseView.swift
//  HanziPlus
//

import SwiftUI

struct PathCourseView: View {

    @Environment(PathCourseStore.self) private var pathStore
    @Environment(DailyChallengeStore.self) private var dailyChallengeStore
    @Environment(LanguageSettingsStore.self) private var languageStore
    @State private var showsCourseDescription = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                if let course = pathStore.course {
                    PathCourseProgressHero(
                        course: course,
                        completedLessons: pathStore.completedLessonCount,
                        progressFraction: pathStore.courseCompletionPercent,
                        streakDays: dailyChallengeStore.streakDays,
                        showContinueCTA: pathStore.hasStartedCourse,
                        continueLesson: pathStore.currentLessonSummary,
                        onShowDetails: { showsCourseDescription = true }
                    )
                    .padding(.horizontal, AppSpacing.medium)
                    .padding(.top, AppSpacing.small)
                }

                lessonsSection
            }
            .padding(.bottom, AppSpacing.extraLarge)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(PathStrings.cardTitle)
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("path_course_view")
        .sheet(isPresented: $showsCourseDescription) {
            if let course = pathStore.course {
                PathCourseDescriptionView(course: course)
            }
        }
        .id(languageStore.refreshToken)
    }

    @ViewBuilder
    private func lessonDestination(for lessonID: String, autoResumeChapter: Bool) -> some View {
        if let summary = pathStore.course?.lessons.first(where: { $0.id == lessonID }),
           let contentFile = summary.contentFile,
           let lesson = PathCourseLoader.loadLesson(fileName: contentFile) {
            PathLessonFlowView(lesson: lesson, autoResumeChapter: autoResumeChapter)
        }
    }

    @ViewBuilder
    private var lessonsSection: some View {
        if let course = pathStore.course {
            VStack(alignment: .leading, spacing: AppSpacing.small) {
                Text(PathStrings.lessonsTitle)
                    .font(.title3.weight(.semibold))
                    .padding(.horizontal, AppSpacing.medium)

                VStack(spacing: AppSpacing.small) {
                    ForEach(course.lessons) { lesson in
                        lessonLink(for: lesson)
                    }
                }
                .padding(.horizontal, AppSpacing.medium)
            }
        }
    }

    @ViewBuilder
    private func lessonLink(for lesson: PathLessonSummary) -> some View {
        let status = pathStore.status(for: lesson)
        let unlocked = pathStore.isLessonUnlocked(lesson)
        let progress = pathStore.lessonChapterProgressFraction(lessonID: lesson.id, contentFile: lesson.contentFile)

        if unlocked {
            NavigationLink {
                lessonDestination(for: lesson.id, autoResumeChapter: false)
            } label: {
                PathLessonRow(
                    lesson: lesson,
                    status: status,
                    isUnlocked: true,
                    chapterProgress: progress
                )
                .accessibilityHidden(true)
            }
            .buttonStyle(.plain)
            .accessibilityIdentifier("path_lesson_\(lesson.id)")
            .accessibilityLabel(lesson.chineseTitle)
            .accessibilityAddTraits(.isButton)
        } else {
            PathLessonRow(
                lesson: lesson,
                status: status,
                isUnlocked: false,
                chapterProgress: progress
            )
        }
    }
}

#Preview {
    NavigationStack {
        PathCourseView()
            .environment(PathCourseStore())
            .environment(DailyChallengeStore())
    }
}
