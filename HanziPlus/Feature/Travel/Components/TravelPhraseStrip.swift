//
//  TravelPhraseStrip.swift
//  HanziPlus
//

import SwiftUI

struct TravelPhraseStrip: View {
    enum ListSource {
        case favorites
        case recent
    }

    let title: String
    let phrases: [TravelPhrase]
    let emptyTitle: String
    let emptySystemImage: String
    let emptyDescription: String
    var listSource: ListSource?

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            HStack {
                Text(title)
                    .font(.title3.weight(.semibold))

                Spacer()

                if let listSource, !phrases.isEmpty {
                    NavigationLink {
                        listView(for: listSource)
                    } label: {
                        Text(l10n: "travel.see_all")
                            .font(.subheadline.weight(.semibold))
                    }
                    .accessibilityLabel(L10n.string( "travel.a11y.see_all \(title)"))
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
                            NavigationLink {
                                TravelPhraseDetailView(phrase: phrase)
                            } label: {
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

    @ViewBuilder
    private func listView(for source: ListSource) -> some View {
        switch source {
        case .favorites:
            TravelPhraseListView(
                title: L10n.string("travel.favorites"),
                source: .favorites,
                emptyTitle: L10n.string("travel.favorites.empty_title"),
                emptySystemImage: "heart",
                emptyDescription: L10n.string("travel.favorites.empty_desc")
            )
        case .recent:
            TravelPhraseListView(
                title: L10n.string("travel.recent"),
                source: .recent,
                emptyTitle: L10n.string("travel.recent.empty_title"),
                emptySystemImage: "clock",
                emptyDescription: L10n.string("travel.recent.empty_desc")
            )
        }
    }
}
