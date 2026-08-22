//
//  FlashCardView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct FlashCardView<Front: View, Back: View>: View {

    @Binding var isFlipped: Bool
    var allowsFlip = true

    let front: Front
    let back: Back

    private let flipSpring = Animation.spring(response: 0.52, dampingFraction: 0.86)

    @ScaledMetric(relativeTo: .largeTitle) private var cardHeight: CGFloat = 360

    init(
        isFlipped: Binding<Bool>,
        allowsFlip: Bool = true,
        @ViewBuilder front: () -> Front,
        @ViewBuilder back: () -> Back
    ) {
        _isFlipped = isFlipped
        self.allowsFlip = allowsFlip
        self.front = front()
        self.back = back()
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .fill(AppColors.cardBackground)
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                        .strokeBorder(Color.primary.opacity(0.06), lineWidth: 0.5)
                }
                .studyCardShadow()

            front
                .padding(.horizontal, 36)
                .padding(.vertical, 40)
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))

            back
                .padding(.horizontal, 36)
                .padding(.vertical, 40)
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 280, idealHeight: cardHeight, maxHeight: cardHeight)
        .contentShape(RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous))
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.55
        )
        .animation(flipSpring, value: isFlipped)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(isFlipped ? "Show front of card" : "Show back of card")
        .accessibilityHint("Double tap to flip the flashcard")
        .onTapGesture {
            guard allowsFlip else { return }

            withAnimation(flipSpring) {
                HapticService.medium()
                isFlipped.toggle()
            }
        }
    }
}
