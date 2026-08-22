//
//  OnboardingOptionCard.swift
//  HanziPlus
//

import SwiftUI

struct OnboardingOptionCard: View {

    let title: String
    let subtitle: String
    let icon: String
    let isSelected: Bool
    let tint: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(isSelected ? tint.opacity(0.18) : Color(.tertiarySystemFill))
                        .frame(width: 48, height: 48)

                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(isSelected ? tint : .secondary)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)

                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                }

                Spacer(minLength: 0)

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundStyle(isSelected ? tint : Color.secondary.opacity(0.35))
            }
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
                    .overlay {
                        RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                            .strokeBorder(
                                isSelected ? tint.opacity(0.45) : Color.primary.opacity(0.06),
                                lineWidth: isSelected ? 1.5 : 0.5
                            )
                    }
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(title). \(subtitle)")
        .accessibilityAddTraits(isSelected ? [.isSelected, .isButton] : .isButton)
    }
}
