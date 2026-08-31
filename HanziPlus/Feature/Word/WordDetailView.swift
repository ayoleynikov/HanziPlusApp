import SwiftUI

struct WordDetailView: View {

    let word: Word
    var entryID: String?
    var searchQuery: String?

    @EnvironmentObject private var favorites: FavoritesStore
    @Environment(HistoryStore.self) private var history
    @Environment(WordCatalog.self) private var catalog

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                HStack {
                    Spacer()

                    FavoriteIconButton(
                        isFavorite: favorites.isFavorite(word),
                        action: {
                            favorites.toggle(word)
                        },
                        font: .title3.weight(.bold)
                    )
                    .frame(width: 44, height: 44)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                }

                Text(word.hanzi)
                    .font(.system(size: 110, weight: .bold, design: .rounded))
                    .padding(.top, 8)

                VStack(spacing: 10) {
                    Text(word.pinyin)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.secondary)

                    Text(word.translation)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Button {
                    SpeechService.shared.speak(word.hanzi)
                } label: {
                    Label(L10n.string( "common.listen"), systemImage: "speaker.wave.2.fill")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }

                Divider()

                if !word.examples.isEmpty {
                    VStack(alignment: .leading, spacing: 16) {
                        Label(L10n.string( "word.detail.examples"), systemImage: "text.quote")
                            .font(.headline)

                        ForEach(word.examples) { example in
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 6))
                                    .padding(.top, 8)
                                    .foregroundStyle(.secondary)

                                ExampleRowView(example: example, style: .detailed)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
        .navigationTitle(word.hanzi)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            recordVisit()
        }
    }

    private func recordVisit() {
        if let searchQuery {
            history.addSearch(searchQuery)
        }

        if let entryID {
            history.addRecentWord(id: entryID)
        } else if let entry = catalog.entries.first(where: { $0.word.hanzi == word.hanzi }) {
            history.addRecentWord(id: entry.id)
        }
    }
}

#Preview {
    NavigationStack {
        WordDetailView(
            word: WordLoader.load(fileName: "hsk1").first!
        )
    }
    .environmentObject(FavoritesStore())
    .environment(HistoryStore())
    .environment(WordCatalog())
}
