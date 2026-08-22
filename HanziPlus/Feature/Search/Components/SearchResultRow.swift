//
//  SearchResultRow.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct SearchResultRow: View {

    let entry: IndexedWord
    let isFavorite: Bool
    let onFavoriteToggle: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.word.hanzi)
                    .font(.title2.bold())

                Text(entry.word.pinyin)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(entry.word.localizedMeaning)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 8)

            VStack(alignment: .trailing, spacing: 10) {
                LevelBadge(level: entry.level)

                Button(action: onFavoriteToggle) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.body)
                        .foregroundStyle(isFavorite ? .red : .secondary)
                }
                .buttonStyle(.borderless)
            }
        }
        .padding(.vertical, 4)
    }
}

private struct LevelBadge: View {

    let level: WordLevel

    var body: some View {
        Text(level.badgeTitle)
            .font(.caption2.weight(.semibold))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(level.color.opacity(0.14))
            .foregroundStyle(level.color)
            .clipShape(Capsule())
    }
}

#Preview {
    let entry = WordCatalog().entries.first!

    return List {
        SearchResultRow(
            entry: entry,
            isFavorite: true,
            onFavoriteToggle: {}
        )
    }
}
