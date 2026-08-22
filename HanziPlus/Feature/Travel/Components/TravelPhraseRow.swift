//
//  TravelPhraseRow.swift
//  HanziPlus
//

import SwiftUI

/// Phrase list row with three independent hit targets:
/// text → open detail, heart → favorite, speaker → play.
struct TravelPhraseRow: View {
    let phrase: TravelPhrase
    let isFavorite: Bool
    let onFavorite: () -> Void
    let onSpeak: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            NavigationLink(value: TravelToolkitRoute.phrase(phrase.id)) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(phrase.simplifiedChinese)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(.primary)

                    Text(phrase.pinyin)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text(phrase.english)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("\(phrase.simplifiedChinese). \(phrase.pinyin). \(phrase.english)")
            .accessibilityHint("Opens phrase details")

            VStack(spacing: 8) {
                Button {
                    onFavorite()
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(isFavorite ? .red : .secondary)
                        .frame(width: 36, height: 36)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.borderless)
                .accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")

                Button {
                    onSpeak()
                } label: {
                    Image(systemName: "speaker.wave.2.fill")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.orange)
                        .frame(width: 36, height: 36)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.borderless)
                .accessibilityLabel("Play pronunciation")
            }
        }
        .padding(.vertical, 8)
    }
}
