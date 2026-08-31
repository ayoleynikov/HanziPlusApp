//
//  TodayPlanActionRow.swift
//  HanziPlus
//

import SwiftUI

struct TodayPlanActionRow: View {

    let action: TodayPlanAction

    private var tint: Color {
        switch action.tintName {
        case "blue": .blue
        case "purple": .purple
        case "orange": .orange
        default: .accentColor
        }
    }

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(tint.opacity(0.14))
                    .frame(width: 44, height: 44)

                Image(systemName: action.icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(tint)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(action.title)
                    .font(.headline)

                Text(action.detail)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            Spacer(minLength: 0)

            if action.isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title3)
                    .foregroundStyle(.green)
                    .accessibilityLabel(L10n.string("Completed"))
            } else {
                Image(systemName: "chevron.right")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(action.title). \(action.detail)")
        .accessibilityAddTraits(.isButton)
    }
}
