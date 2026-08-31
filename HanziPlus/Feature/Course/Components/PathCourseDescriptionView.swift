//
//  PathCourseDescriptionView.swift
//  HanziPlus
//

import SwiftUI

struct PathCourseDescriptionView: View {

    let course: PathCourse

    @Environment(\.dismiss) private var dismiss

    private let chineseRed = Color(red: 0.78, green: 0.14, blue: 0.16)
    private let chineseGold = Color(red: 0.86, green: 0.66, blue: 0.22)
    private let tint = Color.teal

    private var descriptionParagraphs: [String] {
        course.localizedDescription
            .components(separatedBy: "\n\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.large) {
                    hero

                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(Array(descriptionParagraphs.enumerated()), id: \.offset) { _, paragraph in
                            if paragraph.hasPrefix("•") || paragraph.contains("\n•") {
                                bulletBlock(paragraph)
                            } else {
                                Text(paragraph)
                                    .font(.body)
                                    .foregroundStyle(.primary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }

                    PathHowItWorksSection()

                    statsCard
                }
                .padding(.horizontal, AppSpacing.medium)
                .padding(.bottom, AppSpacing.extraLarge)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(PathStrings.aboutCourse)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(L10n.string("common.close")) { dismiss() }
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }

    private var hero: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 11, style: .continuous)
                    .fill(chineseRed.opacity(0.14))
                    .frame(width: 56, height: 56)
                    .overlay {
                        RoundedRectangle(cornerRadius: 11, style: .continuous)
                            .strokeBorder(chineseRed.opacity(0.4), lineWidth: 2)
                    }
                    .rotationEffect(.degrees(-8))

                VStack(spacing: 0) {
                    Text("汉")
                        .font(.system(size: 26, weight: .medium, design: .serif))
                        .foregroundStyle(chineseRed)
                    Text("+")
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .foregroundStyle(chineseGold)
                        .offset(y: -2)
                }
                .rotationEffect(.degrees(-8))
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(course.title)
                    .font(.title3.weight(.bold))

                Text(course.localizedSubtitle)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(tint)
                    .fixedSize(horizontal: false, vertical: true)

                Text(course.localizedSummary)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(AppSpacing.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                        .strokeBorder(chineseGold.opacity(0.2), lineWidth: 1)
                }
        }
    }

    private func bulletBlock(_ text: String) -> some View {
        let lines = text.components(separatedBy: "\n").filter { !$0.isEmpty }

        return VStack(alignment: .leading, spacing: 8) {
            ForEach(Array(lines.enumerated()), id: \.offset) { _, line in
                HStack(alignment: .top, spacing: 10) {
                    if line.hasPrefix("•") {
                        Text("•")
                            .font(.body.weight(.bold))
                            .foregroundStyle(tint)
                            .padding(.top, 1)
                        Text(String(line.dropFirst()).trimmingCharacters(in: .whitespaces))
                            .font(.body)
                            .foregroundStyle(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    } else {
                        Text(line)
                            .font(.body.weight(.semibold))
                            .foregroundStyle(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
        .padding(AppSpacing.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(tint.opacity(0.06))
        }
    }

    private var statsCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(
                PathStrings.courseLessonsLabel(
                    available: course.availableLessonCount,
                    total: course.totalLessons
                ),
                systemImage: "map.fill"
            )
            .font(.subheadline.weight(.semibold))

            Label(PathStrings.courseFormatLabel, systemImage: "text.book.closed.fill")
                .font(.footnote)
                .foregroundStyle(.secondary)

            if course.availableLessonCount < course.totalLessons {
                Text(PathStrings.courseInDevelopment)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(AppSpacing.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
    }
}

#Preview {
    PathCourseDescriptionView(course: PathCourseLoader.previewCourse())
}
