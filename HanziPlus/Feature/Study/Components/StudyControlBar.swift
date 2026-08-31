//
//  StudyControlBar.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct StudyControlBar: View {

    let isFavorite: Bool
    let canGoPrevious: Bool
    let canGoNext: Bool
    let onPrevious: () -> Void
    let onAudio: () -> Void
    let onFavorite: () -> Void
    let onNext: () -> Void

    var body: some View {
        HStack(spacing: 20) {
            StudyControlButton(
                systemImage: "chevron.left",
                accessibilityLabel: L10n.string("a11y.previous_card"),
                isEnabled: canGoPrevious,
                action: onPrevious
            )

            StudyControlButton(
                systemImage: "speaker.wave.2.fill",
                accessibilityLabel: L10n.string("a11y.play_pronunciation"),
                action: onAudio
            )

            StudyControlButton(
                systemImage: isFavorite ? "heart.fill" : "heart",
                accessibilityLabel: isFavorite ? "Remove from favorites" : "Add to favorites",
                isActive: isFavorite,
                activeColor: .red,
                action: onFavorite
            )

            StudyControlButton(
                systemImage: "chevron.right",
                accessibilityLabel: L10n.string("a11y.next_card"),
                isEnabled: canGoNext,
                action: onNext
            )
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    StudyControlBar(
        isFavorite: true,
        canGoPrevious: true,
        canGoNext: false,
        onPrevious: {},
        onAudio: {},
        onFavorite: {},
        onNext: {}
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}
