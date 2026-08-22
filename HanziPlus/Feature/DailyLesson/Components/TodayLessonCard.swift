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
        case .notStarted: "Not Started"
        case .inProgress: "In Progress"
        case .complete: "Complete"
        }
    }

    private var buttonTitle: String {
        switch status {
        case .notStarted: "Start"
        case .inProgress: "Continue"
        case .complete: "Review"
        }
    }

    private var tint: Color {
        switch status {
        case .notStarted: .orange
        case .inProgress: .blue
        case .complete: .green
        }
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

                Text("\(wordCount) words · \(statusLabel)\(isReviewLesson ? " · Review" : "")")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.tertiary)
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
        .accessibilityLabel("Today’s Lesson. \(setTitle). \(wordCount) words. \(statusLabel)")
        .accessibilityHint(buttonTitle)
        .accessibilityAddTraits(.isButton)
    }
}
