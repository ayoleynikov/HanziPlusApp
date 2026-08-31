//
//  PathCourseView.swift
//  HanziPlus
//

import SwiftUI

struct PathCourseView: View {

    @Environment(PathCourseStore.self) private var pathStore
    @Environment(LanguageSettingsStore.self) private var languageStore
    @State private var showsCourseDescription = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                if let course = pathStore.course {
                    PathCourseOverviewCard(course: course) {
                        showsCourseDescription = true
                    }
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

        if unlocked, let contentFile = lesson.contentFile,
           let loadedLesson = PathCourseLoader.loadLesson(fileName: contentFile) {
            NavigationLink {
                PathLessonFlowView(lesson: loadedLesson)
            } label: {
                PathLessonRow(lesson: lesson, status: status, isUnlocked: true)
            }
            .buttonStyle(.plain)
        } else {
            PathLessonRow(lesson: lesson, status: status, isUnlocked: false)
        }
    }
}

#Preview {
    NavigationStack {
        PathCourseView()
            .environment(PathCourseStore())
    }
}
