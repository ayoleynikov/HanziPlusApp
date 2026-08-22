//
//  TravelCategoryView.swift
//  HanziPlus
//

import SwiftUI

struct TravelCategoryView: View {
    let category: TravelPhraseCategory

    @Environment(TravelPhraseStore.self) private var phraseStore
    @State private var query = ""

    private var phrases: [TravelPhrase] {
        TravelPhraseCatalog.search(query, in: TravelPhraseCatalog.phrases(in: category.id))
    }

    var body: some View {
        List {
            if phrases.isEmpty {
                ContentUnavailableView.search(text: query)
            } else {
                ForEach(phrases) { phrase in
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
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(category.title)
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $query, prompt: "Search in \(category.title)")
    }
}
