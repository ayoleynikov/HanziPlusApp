//
//  TravelTripEssentialsPanel.swift
//  HanziPlus
//

import SwiftUI

struct TravelTripEssentialsPanel: View {
    let phrases: [TravelPhrase]
    var onSelect: (String) -> Void

    var body: some View {
        VStack(spacing: 0) {
            ForEach(phrases) { phrase in
                Button {
                    onSelect(phrase.id)
                } label: {
                    TravelTripEssentialRow(phrase: phrase)
                }
                .buttonStyle(.plain)

                if phrase.id != phrases.last?.id {
                    Divider()
                        .padding(.leading, 16)
                }
            }
        }
        .background {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .fill(.ultraThinMaterial)
        }
        .overlay {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .strokeBorder(Color.primary.opacity(0.06), lineWidth: 0.5)
        }
        .studyCardShadow()
    }
}

private struct TravelTripEssentialRow: View {
    let phrase: TravelPhrase

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text(phrase.simplifiedChinese)
                    .font(.system(size: 26, weight: .bold, design: .serif))
                    .foregroundStyle(.primary)

                Text(phrase.pinyin)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)

                Text(phrase.localizedTranslation())
                    .font(.subheadline)
                    .foregroundStyle(.primary.opacity(0.8))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(phrase.simplifiedChinese), \(phrase.pinyin), \(phrase.localizedTranslation())")
        .accessibilityAddTraits(.isButton)
    }
}
