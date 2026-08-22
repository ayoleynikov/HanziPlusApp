//
//  FavoriteButton.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct FavoriteButton: View {

    @Binding var isFavorite: Bool

    var body: some View {
        FavoriteIconButton(isFavorite: isFavorite) {
            withAnimation(.spring(response: 0.3)) {
                isFavorite.toggle()
            }
        }
    }
}

#Preview {

    @Previewable @State var favorite = false

    FavoriteButton(isFavorite: $favorite)
}
