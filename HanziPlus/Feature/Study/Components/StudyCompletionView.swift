//
//  StudyCompletionView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct StudyCompletionView: View {

    let studySet: StudySet
    var sectionTitle: String? = nil
    let totalWords: Int
    let onReviewLearned: () -> Void
    let onStartAgain: () -> Void
    let onBackToSets: () -> Void

    @State private var iconScale: CGFloat = 0.35
    @State private var iconOpacity: Double = 0
    @State private var contentOpacity: Double = 0
    @State private var contentOffset: CGFloat = 24
    @State private var checkBounce = false

    private var completionSubtitle: String {
        if let sectionTitle {
            return L10n.string( "study.complete.subtitle_section \(sectionTitle) \(studySet.localizedTitle)")
        }
        return L10n.string( "study.complete.subtitle_set \(studySet.localizedTitle)")
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ConfettiView()
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.large) {
                Spacer()

                successIcon

                VStack(spacing: AppSpacing.small) {
                    Text(l10n: "study.complete.congrats")
                        .font(.largeTitle.weight(.bold))
                        .multilineTextAlignment(.center)

                    Text(completionSubtitle)
                        .font(.title3.weight(.medium))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)

                    Text(L10n.string( "study.complete.words_learned \(totalWords) \(totalWords)"))
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(studySet.color)
                        .padding(.top, 4)
                }
                .opacity(contentOpacity)
                .offset(y: contentOffset)

                Spacer()

                VStack(spacing: AppSpacing.small) {
                    completionButton(
                        title: L10n.string( "study.complete.review_learned"),
                        style: .primary,
                        color: studySet.color,
                        action: onReviewLearned
                    )

                    completionButton(
                        title: L10n.string( "study.complete.start_again"),
                        style: .secondary,
                        color: studySet.color,
                        action: onStartAgain
                    )

                    completionButton(
                        title: L10n.string( "study.complete.back_to_sets"),
                        style: .tertiary,
                        color: studySet.color,
                        action: onBackToSets
                    )
                }
                .opacity(contentOpacity)
                .offset(y: contentOffset)
                .padding(.horizontal, AppSpacing.medium)
                .padding(.bottom, AppSpacing.extraLarge)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.62, dampingFraction: 0.68)) {
                iconScale = 1
                iconOpacity = 1
            }

            withAnimation(.spring(response: 0.55, dampingFraction: 0.82).delay(0.12)) {
                contentOpacity = 1
                contentOffset = 0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                checkBounce = true
            }
        }
    }

    private var successIcon: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [studySet.color.opacity(0.22), studySet.color.opacity(0.04)],
                        center: .center,
                        startRadius: 20,
                        endRadius: 90
                    )
                )
                .frame(width: 160, height: 160)

            Circle()
                .fill(studySet.color.opacity(0.14))
                .frame(width: 120, height: 120)

            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 64, weight: .semibold))
                .foregroundStyle(studySet.color)
                .symbolEffect(.bounce, value: checkBounce)
        }
        .scaleEffect(iconScale)
        .opacity(iconOpacity)
    }

    @ViewBuilder
    private func completionButton(
        title: String,
        style: CompletionButtonStyle,
        color: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.body.weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background {
                    switch style {
                    case .primary:
                        Capsule(style: .continuous)
                            .fill(color)

                    case .secondary:
                        Capsule(style: .continuous)
                            .fill(color.opacity(0.12))

                    case .tertiary:
                        Capsule(style: .continuous)
                            .fill(Color(.secondarySystemGroupedBackground))
                    }
                }
                .foregroundStyle(style == .primary ? Color.white : color)
        }
        .buttonStyle(CompletionButtonPressStyle())
    }

    private enum CompletionButtonStyle {
        case primary
        case secondary
        case tertiary
    }
}

private struct CompletionButtonPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(response: 0.28, dampingFraction: 0.72), value: configuration.isPressed)
    }
}

#Preview {
    StudyCompletionView(
        studySet: SampleStudySets.all[0],
        totalWords: 150,
        onReviewLearned: {},
        onStartAgain: {},
        onBackToSets: {}
    )
}
