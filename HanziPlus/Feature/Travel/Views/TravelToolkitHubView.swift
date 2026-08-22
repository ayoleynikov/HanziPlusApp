//
//  TravelToolkitHubView.swift
//  HanziPlus
//

import SwiftUI

struct TravelToolkitHubView: View {

    @Environment(TravelPhraseStore.self) private var phraseStore
    @Binding var path: NavigationPath

    @State private var query = ""

    private var searchResults: [TravelPhrase] {
        TravelPhraseCatalog.search(query)
    }

    private var isSearching: Bool {
        !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                header

                if isSearching {
                    searchResultsSection
                } else {
                    quickAccessSection
                    categoriesSection
                    TravelPhraseStrip(
                        title: String(localized: "travel.favorites"),
                        phrases: Array(phraseStore.favoritePhrases.prefix(12)),
                        emptyTitle: String(localized: "travel.favorites.empty_title"),
                        emptySystemImage: "heart",
                        emptyDescription: String(localized: "travel.favorites.empty_desc"),
                        seeAllRoute: .favorites
                    )
                    TravelPhraseStrip(
                        title: String(localized: "travel.recent"),
                        phrases: Array(phraseStore.recentPhrases.prefix(12)),
                        emptyTitle: String(localized: "travel.recent.empty_title"),
                        emptySystemImage: "clock",
                        emptyDescription: String(localized: "travel.recent.empty_desc"),
                        seeAllRoute: .recent
                    )
                    tripEssentialsSection
                    studyWordsLink
                }
            }
            .padding(.bottom, AppSpacing.extraLarge)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(String(localized: "travel.nav_title"))
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $query, prompt: String(localized: "travel.search.prompt"))
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("travel.offline_blurb")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.top, 4)
    }

    private var quickAccessSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("travel.section.quick_access")
                .font(.title3.weight(.semibold))
                .padding(.horizontal, AppSpacing.medium)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(TravelQuickAccess.items) { item in
                        Button {
                            path.append(item.route)
                        } label: {
                            TravelQuickAccessChip(item: item)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, AppSpacing.medium)
            }
        }
    }

    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("travel.section.categories")
                .font(.title3.weight(.semibold))
                .padding(.horizontal, AppSpacing.medium)

            LazyVStack(spacing: 12) {
                ForEach(TravelPhraseCategories.all) { category in
                    Button {
                        path.append(TravelToolkitRoute.category(category.id))
                    } label: {
                        TravelCategoryCard(
                            category: category,
                            count: TravelPhraseCatalog.count(in: category.id)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, AppSpacing.medium)
        }
    }

    private var tripEssentialsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("travel.section.trip_essentials")
                .font(.title3.weight(.semibold))
                .padding(.horizontal, AppSpacing.medium)

            LazyVStack(spacing: 0) {
                ForEach(TravelPhraseCatalog.tripEssentials()) { phrase in
                    Button {
                        path.append(TravelToolkitRoute.phrase(phrase.id))
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(phrase.simplifiedChinese)
                                    .font(.headline)
                                Text(phrase.localizedTranslation())
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.tertiary)
                        }
                        .padding(.vertical, 12)
                    }
                    .buttonStyle(.plain)

                    if phrase.id != TravelPhraseCatalog.tripEssentials().last?.id {
                        Divider()
                    }
                }
            }
            .padding(.horizontal, 16)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
            }
            .padding(.horizontal, AppSpacing.medium)
        }
    }

    private var studyWordsLink: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("travel.section.vocab_study")
                .font(.title3.weight(.semibold))
                .padding(.horizontal, AppSpacing.medium)

            Button {
                path.append(TravelToolkitRoute.studyWords)
            } label: {
                HStack(spacing: 14) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color.orange.opacity(0.14))
                            .frame(width: 48, height: 48)
                        Image(systemName: "text.book.closed.fill")
                            .foregroundStyle(.orange)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("travel.study_words")
                            .font(.headline)
                        Text("travel.study_words.subtitle")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.tertiary)
                }
                .padding(16)
                .background {
                    RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                }
            }
            .buttonStyle(.plain)
            .padding(.horizontal, AppSpacing.medium)
            .accessibilityLabel(String(localized: "travel.study_words"))
        }
    }

    private var searchResultsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("travel.section.results")
                .font(.title3.weight(.semibold))
                .padding(.horizontal, AppSpacing.medium)

            if searchResults.isEmpty {
                ContentUnavailableView.search(text: query)
                    .padding(.top, AppSpacing.large)
            } else {
                LazyVStack(spacing: 0) {
                    ForEach(searchResults) { phrase in
                        TravelPhraseRow(
                            phrase: phrase,
                            isFavorite: phraseStore.isFavorite(phrase.id),
                            onFavorite: {
                                HapticService.light()
                                phraseStore.toggleFavorite(phrase.id)
                            },
                            onSpeak: {
                                phraseStore.markUsed(phrase.id)
                                HapticService.light()
                                SpeechService.shared.speak(phrase.simplifiedChinese)
                            }
                        )
                        .padding(.horizontal, AppSpacing.medium)
                        .padding(.vertical, 4)

                        Divider().padding(.leading, AppSpacing.medium)
                    }
                }
            }
        }
    }
}
