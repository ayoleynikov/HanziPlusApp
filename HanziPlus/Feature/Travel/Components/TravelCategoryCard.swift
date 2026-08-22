//
//  TravelCategoryCard.swift
//  HanziPlus
//

import SwiftUI

struct TravelCategoryCard: View {
    let category: TravelPhraseCategory
    let count: Int

    private var tint: Color { TravelAccent.color(named: category.accentName) }

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(tint.opacity(0.14))
                    .frame(width: 48, height: 48)

                Image(systemName: category.icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(tint)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(category.title)
                    .font(.headline)

                Text(category.subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                Text("\(count) phrases")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.tertiary)
            }

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(category.title), \(count) phrases. \(category.subtitle)")
        .accessibilityAddTraits(.isButton)
    }
}
