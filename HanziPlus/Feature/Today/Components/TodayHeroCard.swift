//
//  TodayHeroCard.swift
//  HanziPlus
//

import SwiftUI

struct TodayHeroCard: View {

    let content: TodayHeroContent
    let tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top, spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(tint.opacity(0.14))
                        .frame(width: 52, height: 52)

                    Image(systemName: content.icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(tint)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text(content.title)
                        .font(.title3.weight(.bold))
                        .fixedSize(horizontal: false, vertical: true)

                    Text(content.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Text(content.buttonTitle)
                .font(.body.weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Capsule(style: .continuous).fill(tint))
                .foregroundStyle(.white)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [tint.opacity(0.08), .clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
        }
        .studyCardShadow()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(content.title). \(content.subtitle)")
        .accessibilityHint(content.buttonTitle)
        .accessibilityAddTraits(.isButton)
    }
}
