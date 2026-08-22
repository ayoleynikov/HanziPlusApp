//
//  DailyLessonProgressHeader.swift
//  HanziPlus
//

import SwiftUI

struct DailyLessonProgressHeader: View {

    let phaseTitle: String
    let stepLabel: String
    let progress: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(phaseTitle)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .accessibilityAddTraits(.isHeader)

                Spacer(minLength: 0)

                Text(stepLabel)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.tertiary)
            }

            ProgressView(value: min(max(progress, 0), 1))
                .tint(.orange)
                .accessibilityLabel("Lesson progress")
                .accessibilityValue("\(Int((min(max(progress, 0), 1)) * 100)) percent")
        }
        .padding(.top, AppSpacing.small)
    }
}
