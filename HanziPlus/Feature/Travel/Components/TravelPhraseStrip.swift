//
//  TravelPhraseStrip.swift
//  HanziPlus
//

import SwiftUI

struct TravelPhraseStrip: View {
    let title: String
    let phrases: [TravelPhrase]
    let emptyTitle: String
    let emptySystemImage: String
    let emptyDescription: String
    var seeAllRoute: TravelToolkitRoute? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            HStack {
                Text(title)
                    .font(.title3.weight(.semibold))

                Spacer()

                if let seeAllRoute, !phrases.isEmpty {
                    NavigationLink(value: seeAllRoute) {
                        Text("travel.see_all")
                            .font(.subheadline.weight(.semibold))
                    }
                    .accessibilityLabel(String(localized: "travel.a11y.see_all \(title)"))
                }
            }
            .padding(.horizontal, AppSpacing.medium)

            if phrases.isEmpty {
                ContentUnavailableView(
                    emptyTitle,
                    systemImage: emptySystemImage,
                    description: Text(emptyDescription)
                )
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppSpacing.medium)
                .background {
                    RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                }
                .padding(.horizontal, AppSpacing.medium)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(phrases) { phrase in
                            NavigationLink(value: TravelToolkitRoute.phrase(phrase.id)) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(phrase.simplifiedChinese)
                                        .font(.headline)
                                        .lineLimit(1)

                                    Text(phrase.localizedTranslation())
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(2)
                                }
                                .padding(14)
                                .frame(width: 180, alignment: .leading)
                                .background {
                                    RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                                        .fill(Color(.secondarySystemGroupedBackground))
                                }
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("\(phrase.simplifiedChinese), \(phrase.localizedTranslation())")
                        }
                    }
                    .padding(.horizontal, AppSpacing.medium)
                }
            }
        }
    }
}
