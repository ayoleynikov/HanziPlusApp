//
//  TodayDailyProgressCard.swift
//  HanziPlus
//

import SwiftUI

struct TodayDailyProgressCard: View {

    let lessonComplete: Bool
    let lessonInProgress: Bool
    let weakWordsCount: Int
    let dailyTasksCompleted: Int
    let dailyTasksTotal: Int
    let tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(l10n: "today.progress.title")
                .font(.headline.weight(.semibold))

            HStack(spacing: 12) {
                metric(
                    icon: lessonComplete ? "checkmark.circle.fill" : "text.book.closed.fill",
                    value: lessonValue,
                    title: L10n.string("today.action.learn"),
                    tint: lessonComplete ? .green : tint
                )

                metric(
                    icon: "arrow.triangle.2.circlepath",
                    value: "\(weakWordsCount)",
                    title: L10n.string("today.action.review"),
                    tint: .purple
                )

                if dailyTasksTotal > 0 {
                    metric(
                        icon: "gamecontroller.fill",
                        value: "\(dailyTasksCompleted)/\(dailyTasksTotal)",
                        title: L10n.string("games.section.today"),
                        tint: .indigo
                    )
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
    }

    private var lessonValue: String {
        if lessonComplete { return L10n.string("common.done") }
        if lessonInProgress { return L10n.string("today.progress.lesson_active") }
        return L10n.string("today.progress.lesson_pending")
    }

    private func metric(icon: String, value: String, title: String, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(systemName: icon)
                .font(.caption.weight(.semibold))
                .foregroundStyle(tint)

            Text(value)
                .font(.subheadline.weight(.bold))
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.tertiarySystemGroupedBackground))
        }
    }
}
