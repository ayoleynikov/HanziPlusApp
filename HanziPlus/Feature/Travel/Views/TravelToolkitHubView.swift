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
                        title: "Favorites",
                        phrases: Array(phraseStore.favoritePhrases.prefix(12)),
                        emptyTitle: "No favorites yet",
                        emptySystemImage: "heart",
                        emptyDescription: "Heart a phrase to keep it ready offline.",
                        seeAllRoute: .favorites
                    )
                    TravelPhraseStrip(
                        title: "Recently Used",
                        phrases: Array(phraseStore.recentPhrases.prefix(12)),
                        emptyTitle: "No recent phrases",
                        emptySystemImage: "clock",
                        emptyDescription: "Opened or played phrases will appear here.",
                        seeAllRoute: .recent
                    )
                    tripEssentialsSection
                    studyWordsLink
                }
            }
            .padding(.bottom, AppSpacing.extraLarge)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Travel Toolkit")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $query, prompt: "Chinese, pinyin, English, tags")
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Works fully offline — find a phrase, play it, or show your phone.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.top, 4)
    }

    private var quickAccessSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("Quick Access")
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
            Text("Categories")
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
            Text("Trip Essentials")
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
            Text("Vocabulary Study")
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
                        Text("Study Travel Words")
                            .font(.headline)
                        Text("Flashcards from the Travel study set")
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
            .accessibilityLabel("Study Travel Words")
        }
    }

    private var searchResultsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("Results")
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
