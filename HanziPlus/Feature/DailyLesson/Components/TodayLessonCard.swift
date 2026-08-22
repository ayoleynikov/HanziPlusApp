//
//  TodayLessonCard.swift
//  HanziPlus
//

import SwiftUI

struct TodayLessonCard: View {

    let setTitle: String
    let wordCount: Int
    let status: DailyLessonStatus
    let isReviewLesson: Bool

    private var statusLabel: String {
        switch status {
        case .notStarted: String(localized: "lesson.card.status.not_started")
        case .inProgress: String(localized: "lesson.card.status.in_progress")
        case .complete: String(localized: "lesson.card.status.complete")
        }
    }

    private var buttonTitle: String {
        switch status {
        case .notStarted: String(localized: "common.start")
        case .inProgress: String(localized: "common.continue")
        case .complete: String(localized: "common.review")
        }
    }

    private var tint: Color {
        switch status {
        case .notStarted: .orange
        case .inProgress: .blue
        case .complete: .green
        }
    }

    private var metaLine: String {
        var parts = [L10n.words(wordCount), statusLabel]
        if isReviewLesson {
            parts.append(String(localized: "common.review"))
        }
        return parts.joined(separator: " · ")
    }

    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(tint.opacity(0.14))
                    .frame(width: 48, height: 48)

                Image(systemName: status == .complete ? "checkmark.circle.fill" : "sun.max.fill")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(tint)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("lesson.card.title")
                    .font(.headline)

                Text(setTitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(metaLine)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.tertiary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)

            Text(buttonTitle)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .frame(minHeight: 44)
                .background(Capsule(style: .continuous).fill(tint))
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(String(localized: "lesson.card.title")). \(setTitle). \(L10n.words(wordCount)). \(statusLabel)")
        .accessibilityHint(buttonTitle)
        .accessibilityAddTraits(.isButton)
    }
}
