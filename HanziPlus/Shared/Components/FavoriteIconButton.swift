//
//  FavoriteIconButton.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct FavoriteIconButton: View {

    let isFavorite: Bool
    let action: () -> Void
    var font: Font = .title2

    var body: some View {
        Button(action: action) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(font)
                .foregroundStyle(isFavorite ? .red : .secondary)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack(spacing: 24) {
        FavoriteIconButton(isFavorite: false, action: {})
        FavoriteIconButton(isFavorite: true, action: {})
    }
}
