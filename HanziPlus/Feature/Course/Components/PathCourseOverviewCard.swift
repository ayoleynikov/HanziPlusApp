//
//  PathCourseOverviewCard.swift
//  HanziPlus
//

import SwiftUI

struct PathCourseOverviewCard: View {

    let course: PathCourse
    let onShowDetails: () -> Void

    private let chineseRed = Color(red: 0.78, green: 0.14, blue: 0.16)
    private let chineseGold = Color(red: 0.86, green: 0.66, blue: 0.22)
    private let tint = Color.teal

    var body: some View {
        Button(action: onShowDetails) {
            VStack(alignment: .leading, spacing: 14) {
                HStack(alignment: .top, spacing: 12) {
                    sealBadge

                    VStack(alignment: .leading, spacing: 5) {
                        Text(course.localizedSubtitle)
                            .font(.headline.weight(.bold))
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)

                        Text(course.localizedSummary)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(2)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    Spacer(minLength: 0)

                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.tertiary)
                        .padding(.top, 4)
                }

                HStack(spacing: 8) {
                    metaChip(
                        icon: "book.pages.fill",
                        text: PathStrings.courseLessonsLabel(
                            available: course.availableLessonCount,
                            total: course.totalLessons
                        )
                    )

                    metaChip(icon: "bubble.left.and.text.bubble.right.fill", text: PathStrings.courseFormatLabel)
                }

                HStack(spacing: 6) {
                    Text(PathStrings.readMore)
                        .font(.caption.weight(.semibold))
                    Image(systemName: "arrow.up.right")
                        .font(.caption2.weight(.bold))
                }
                .foregroundStyle(tint)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(cardBackground)
            .studyCardShadow()
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(PathStrings.aboutCourse)
    }

    private var sealBadge: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 9, style: .continuous)
                .fill(chineseRed.opacity(0.14))
                .frame(width: 44, height: 44)
                .overlay {
                    RoundedRectangle(cornerRadius: 9, style: .continuous)
                        .strokeBorder(chineseRed.opacity(0.38), lineWidth: 1.5)
                }
                .rotationEffect(.degrees(-8))

            Text("汉")
                .font(.system(size: 22, weight: .medium, design: .serif))
                .foregroundStyle(chineseRed)
                .rotationEffect(.degrees(-8))
        }
        .frame(width: 44, height: 44)
        .accessibilityHidden(true)
    }

    private func metaChip(icon: String, text: String) -> some View {
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

    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
            .fill(Color(.secondarySystemGroupedBackground))
            .overlay {
                RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                chineseRed.opacity(0.04),
                                tint.opacity(0.05),
                                chineseGold.opacity(0.03)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .overlay {
                RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                    .strokeBorder(chineseGold.opacity(0.22), lineWidth: 1)
            }
    }
}

#Preview {
    PathCourseOverviewCard(course: PathCourseLoader.previewCourse(), onShowDetails: {})
        .padding()
}
