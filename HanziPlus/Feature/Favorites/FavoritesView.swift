//
//  FavoritesView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(WordCatalog.self) private var catalog
    @EnvironmentObject private var favoritesStore: FavoritesStore

    private var favoriteEntries: [IndexedWord] {
        catalog.allWords().filter { favoritesStore.isFavorite($0.word) }
    }

    var body: some View {
        NavigationStack {
            if favoriteEntries.isEmpty {
                ContentUnavailableView(
                    "No Favorites",
                    systemImage: "heart"
                )
            } else {
                List(favoriteEntries) { entry in
                    NavigationLink {
                        WordDetailView(
                            word: entry.word,
                            entryID: entry.id
                        )
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(entry.word.hanzi)
                                    .font(.title2.bold())

                                Text(entry.word.pinyin)
                                    .foregroundStyle(.secondary)

                                Text(entry.word.translation)
                            }

                            Spacer()

                            Button {
                                favoritesStore.toggle(entry.word)
                            } label: {
                                Image(systemName: "heart.fill")
                                    .foregroundStyle(.red)
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            favoritesStore.toggle(entry.word)
                        } label: {
                            Label("Remove", systemImage: "trash")
                        }
                    }
                }
                .navigationTitle("Favorites")
            }
        }
    }
}

#Preview {
    FavoritesView()
        .environment(WordCatalog())
        .environment(HistoryStore())
        .environmentObject(FavoritesStore())
}
