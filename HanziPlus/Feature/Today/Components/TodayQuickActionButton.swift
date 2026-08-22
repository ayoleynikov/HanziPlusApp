//
//  TodayQuickActionButton.swift
//  HanziPlus
//

import SwiftUI

struct TodayQuickActionButton: View {

    let title: String
    let icon: String
    let tint: Color

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(tint.opacity(0.14))
                    .frame(width: 48, height: 48)

                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(tint)
            }

            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.85)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .padding(.horizontal, 8)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
    }
}
