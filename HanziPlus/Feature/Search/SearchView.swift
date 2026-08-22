//
//  SearchView.swift
//  HanziPlus
//

import SwiftUI

struct SearchView: View {

    private let collapsedSearchCount = 3

    @Environment(WordCatalog.self) private var catalog
    @Environment(HistoryStore.self) private var history
    @Environment(LearnedWordsStore.self) private var learnedStore
    @EnvironmentObject private var favoritesStore: FavoritesStore
    @State private var viewModel: SearchViewModel?
    @State private var showAllRecentSearches = false

    var body: some View {
        Group {
            if let viewModel {
                searchContent(viewModel: viewModel)
            } else {
                ProgressView()
            }
        }
        .navigationTitle("Search")
        .onAppear { setupViewModelIfNeeded() }
        .onChange(of: favoritesStore.favorites) { _, favorites in
            viewModel?.updateFavoriteHanzi(favorites)
        }
        .onChange(of: learnedStore.learnedIDs) { _, ids in
            viewModel?.updateLearnedKeys(ids)
        }
    }

    private func setupViewModelIfNeeded() {
        guard viewModel == nil else { return }
        let model = SearchViewModel(catalog: catalog)
        model.updateFavoriteHanzi(favoritesStore.favorites)
        model.updateLearnedKeys(learnedStore.learnedIDs)
        viewModel = model
    }

    @ViewBuilder
    private func searchContent(viewModel: SearchViewModel) -> some View {
        @Bindable var viewModel = viewModel

        VStack(spacing: 0) {
            filterBar(viewModel: viewModel)

            Group {
                if viewModel.query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    if viewModel.filters.wordFilter != .all {
                        browseList(viewModel: viewModel)
                    } else {
                        historyContent(viewModel: viewModel)
                    }
                } else if viewModel.results.isEmpty {
                    ContentUnavailableView(
                        "No words found",
                        systemImage: "magnifyingglass",
                        description: Text("Try a different search term or filter.")
                    )
                } else {
                    resultsList(viewModel: viewModel)
                }
            }
        }
        .searchable(
            text: $viewModel.query,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Chinese or English"
        )
        .onSubmit(of: .search) {
            history.addSearch(viewModel.query)
        }
    }

    private func filterBar(viewModel: SearchViewModel) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(SearchWordFilter.allCases) { filter in
                    Button {
                        withAnimation(.spring(response: 0.32, dampingFraction: 0.78)) {
                            viewModel.setWordFilter(filter)
                        }
                    } label: {
                        HStack(spacing: 6) {
                            if filter == .favorites {
                                Image(systemName: filter.icon)
                                    .font(.caption.weight(.bold))
                            } else if filter == .learned {
                                Image(systemName: filter.icon)
                                    .font(.caption.weight(.bold))
                            }
                            Text(filter.rawValue)
                                .font(.subheadline.weight(.semibold))
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 9)
                        .background {
                            Capsule(style: .continuous)
                                .fill(
                                    viewModel.filters.wordFilter == filter
                                        ? Color.accentColor.opacity(0.15)
                                        : Color(.secondarySystemGroupedBackground)
                                )
                        }
                        .foregroundStyle(
                            viewModel.filters.wordFilter == filter ? Color.accentColor : .primary
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.vertical, AppSpacing.small)
        }
        .background(Color(.systemGroupedBackground))
    }

    private func resultsList(viewModel: SearchViewModel) -> some View {
        List {
            Section("\(viewModel.results.count) Results") {
                ForEach(viewModel.results) { entry in
                    wordRow(entry: entry, viewModel: viewModel)
                }
            }
        }
        .listStyle(.insetGrouped)
    }

    private func browseList(viewModel: SearchViewModel) -> some View {
        Group {
            if viewModel.results.isEmpty {
                ContentUnavailableView(
                    viewModel.filters.wordFilter == .favorites ? "No Favorites" : "No Learned Words",
                    systemImage: viewModel.filters.wordFilter == .favorites ? "heart" : "checkmark.circle",
                    description: Text(
                        viewModel.filters.wordFilter == .favorites
                            ? "Tap the heart on any word to save it here."
                            : "Words you mark as learned in Study will appear here."
                    )
                )
            } else {
                List {
                    Section("\(viewModel.results.count) \(viewModel.filters.wordFilter.rawValue)") {
                        ForEach(viewModel.results) { entry in
                            wordRow(entry: entry, viewModel: viewModel)
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
    }

    private func wordRow(entry: IndexedWord, viewModel: SearchViewModel) -> some View {
        NavigationLink {
            WordDetailView(
                word: entry.word,
                entryID: entry.id,
                searchQuery: viewModel.query
            )
        } label: {
            SearchResultRow(
                entry: entry,
                isFavorite: favoritesStore.isFavorite(entry.word),
                onFavoriteToggle: { favoritesStore.toggle(entry.word) }
            )
        }
    }

    @ViewBuilder
    private func historyContent(viewModel: SearchViewModel) -> some View {
        let recentWords = history.recentWords(from: catalog)
        let displayedSearches = showAllRecentSearches
            ? history.recentSearches
            : Array(history.recentSearches.prefix(collapsedSearchCount))
        let hasMoreSearches = history.recentSearches.count > collapsedSearchCount

        if history.recentSearches.isEmpty && recentWords.isEmpty {
            ContentUnavailableView(
                "Search",
                systemImage: "magnifyingglass",
                description: Text("Search by Chinese or English, or browse Favorites and Learned.")
            )
        } else {
            List {
                if !history.recentSearches.isEmpty {
                    Section("Recent Searches") {
                        ForEach(displayedSearches, id: \.self) { term in
                            Button { viewModel.query = term } label: {
                                Label(term, systemImage: "clock.arrow.circlepath")
                                    .foregroundStyle(.primary)
                            }
                        }
                        .onDelete { indexSet in
                            indexSet
                                .map { displayedSearches[$0] }
                                .forEach { history.removeSearch($0) }
                        }

                        if hasMoreSearches {
                            Button {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    showAllRecentSearches.toggle()
                                }
                            } label: {
                                Label(
                                    showAllRecentSearches ? "Show Less" : "Show More",
                                    systemImage: showAllRecentSearches ? "chevron.up" : "chevron.down"
                                )
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                }

                if !recentWords.isEmpty {
                    Section("Recently Viewed") {
                        ForEach(recentWords) { entry in
                            NavigationLink {
                                WordDetailView(word: entry.word, entryID: entry.id)
                            } label: {
                                SearchResultRow(
                                    entry: entry,
                                    isFavorite: favoritesStore.isFavorite(entry.word),
                                    onFavoriteToggle: { favoritesStore.toggle(entry.word) }
                                )
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
    .environment(WordCatalog())
    .environment(HistoryStore())
    .environment(LearnedWordsStore())
    .environmentObject(FavoritesStore())
}
