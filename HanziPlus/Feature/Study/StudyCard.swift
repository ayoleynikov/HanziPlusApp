//
//  StudyCard.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct StudyCard: View {

    private enum Constants {
        static let swipeThreshold: CGFloat = 80
        static let exitOffset: CGFloat = 520
        static let springResponse = 0.38
        static let springDamping = 0.84
    }

    let word: Word

    @Binding var isFlipped: Bool
    @Binding var navigationTrigger: StudyNavigationDirection?

    let canGoNext: Bool
    let canGoPrevious: Bool
    let onNavigate: (StudyNavigationDirection) -> Bool

    @State private var offset: CGSize = .zero
    @State private var isDragging = false
    @GestureState private var dragTranslation: CGSize = .zero

    var body: some View {

        FlashCardView(
            isFlipped: $isFlipped,
            allowsFlip: !isDragging && abs(displayedOffset.width) < 8
        ) {
            CardFrontView(word: word)
        } back: {
            CardBackView(word: word, scrollEnabled: !isDragging)
        }
        .offset(x: displayedOffset.width, y: displayedOffset.height * 0.08)
        .rotationEffect(.degrees(Double(displayedOffset.width / 28)))
        .scaleEffect(isDragging ? 1 - min(abs(displayedOffset.width) / 1800, 0.035) : 1)
        .contentShape(RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous))
        .highPriorityGesture(swipeGesture)
        .onChange(of: navigationTrigger) { _, direction in
            guard let direction else { return }
            navigationTrigger = nil
            handleTriggeredNavigation(direction)
        }
        .onChange(of: word.hanzi) { _, _ in
            resetCardPosition()
        }
    }

    private var displayedOffset: CGSize {
        isDragging
            ? CGSize(width: offset.width + dragTranslation.width, height: 0)
            : offset
    }

    private var swipeGesture: some Gesture {
        DragGesture(minimumDistance: 12, coordinateSpace: .local)
            .updating($dragTranslation) { value, state, _ in
                guard isHorizontalSwipe(value) else { return }

                let translation = value.translation.width

                guard translation < 0 else {
                    state.width = 0
                    return
                }

                state.width = canGoNext ? translation : rubberBand(translation)
            }
            .onChanged { value in
                guard isHorizontalSwipe(value), value.translation.width < 0 else { return }
                isDragging = true
            }
            .onEnded { value in
                isDragging = false

                let translation = value.translation.width

                guard isHorizontalSwipe(value), translation < 0 else {
                    springBack()
                    return
                }

                let predicted = value.predictedEndTranslation.width
                let effective = min(predicted, translation)

                if effective < -Constants.swipeThreshold {
                    if canGoNext {
                        offset.width += translation
                        commitNavigation(.next)
                    } else {
                        offset.width = rubberBand(translation)
                        bounceAtBoundary()
                    }
                } else {
                    offset.width += translation
                    springBack()
                }
            }
    }

    private func isHorizontalSwipe(_ value: DragGesture.Value) -> Bool {
        abs(value.translation.width) > abs(value.translation.height)
    }

    private func rubberBand(_ translation: CGFloat) -> CGFloat {
        translation * 0.22
    }

    private func springBack() {
        withAnimation(.spring(response: Constants.springResponse, dampingFraction: Constants.springDamping)) {
            offset = .zero
        }
    }

    private func resetCardPosition() {
        offset = .zero
        isDragging = false
    }

    private func bounceAtBoundary() {
        withAnimation(.spring(response: 0.32, dampingFraction: 0.55)) {
            offset.width = -30
        }

        HapticService.rigid()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.14) {
            springBack()
        }
    }

    private func handleTriggeredNavigation(_ direction: StudyNavigationDirection) {
        switch direction {
        case .next:
            if canGoNext {
                commitNavigation(.next)
            } else {
                bounceAtBoundary()
            }

        case .previous:
            if canGoPrevious {
                commitNavigation(.previous)
            } else {
                bounceAtBoundary()
            }
        }
    }

    private func commitNavigation(_ direction: StudyNavigationDirection) {
        let exitX = direction == .next ? -Constants.exitOffset : Constants.exitOffset

        withAnimation(.spring(response: Constants.springResponse, dampingFraction: Constants.springDamping)) {
            offset.width = exitX
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.24) {
            let succeeded = onNavigate(direction)

            if succeeded {
                resetCardPosition()
            } else {
                springBack()
            }
        }
    }
}
