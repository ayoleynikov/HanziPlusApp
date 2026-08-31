//
//  TravelPhraseListView.swift
//  HanziPlus
//

import SwiftUI

struct TravelPhraseListView: View {
    enum Source {
        case favorites
        case recent
        case fixed([TravelPhrase])
    }

    let title: String
    let source: Source
    let emptyTitle: String
    let emptySystemImage: String
    let emptyDescription: String

    @Environment(TravelPhraseStore.self) private var phraseStore
    @State private var query = ""

    init(
        title: String,
        phrases: [TravelPhrase],
        emptyTitle: String,
        emptySystemImage: String,
        emptyDescription: String
    ) {
        self.title = title
        self.source = .fixed(phrases)
        self.emptyTitle = emptyTitle
        self.emptySystemImage = emptySystemImage
        self.emptyDescription = emptyDescription
    }

    init(
        title: String,
        source: Source,
        emptyTitle: String,
        emptySystemImage: String,
        emptyDescription: String
    ) {
        self.title = title
        self.source = source
        self.emptyTitle = emptyTitle
        self.emptySystemImage = emptySystemImage
        self.emptyDescription = emptyDescription
    }

    private var sourcePhrases: [TravelPhrase] {
        switch source {
        case .favorites:
            return phraseStore.favoritePhrases
        case .recent:
            return phraseStore.recentPhrases
        case .fixed(let phrases):
            return phrases
        }
    }

    private var filtered: [TravelPhrase] {
        TravelPhraseCatalog.search(query, in: sourcePhrases)
    }

    var body: some View {
        List {
            if sourcePhrases.isEmpty {
                ContentUnavailableView(emptyTitle, systemImage: emptySystemImage, description: Text(emptyDescription))
            } else if filtered.isEmpty {
                ContentUnavailableView.search(text: query)
            } else {
                ForEach(filtered) { phrase in
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
        .navigationTitle(title)
        .searchable(text: $query, prompt: L10n.string( "travel.search.phrases"))
    }
}
