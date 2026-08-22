//
//  GameCompletionView.swift
//  HanziPlus
//

import SwiftUI

struct GameCompletionView: View {

    let game: GameDefinition
    let result: GameResult
    let onPlayAgain: () -> Void
    let onBackToGames: () -> Void

    @Environment(GamesDailyProgressStore.self) private var dailyProgressStore
    @Environment(GameSessionStore.self) private var sessionStore
    @Environment(GamesPlayHistoryStore.self) private var playHistory

    @State private var iconScale: CGFloat = 0.4
    @State private var contentOpacity: Double = 0
    @State private var showConfetti = true
    @State private var didRecordProgress = false

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            if showConfetti, result.accuracy >= 80 {
                ConfettiView()
                    .ignoresSafeArea()
            }

            ScrollView {
                VStack(spacing: AppSpacing.large) {
                    successIcon

                    VStack(spacing: 8) {
                        Text("Game Complete")
                            .font(.largeTitle.weight(.bold))

                        if result.isNewRecord {
                            Text("New Record!")
                                .font(.title3.weight(.bold))
                                .foregroundStyle(.green)
                                .transition(.scale.combined(with: .opacity))
                        }
                    }
                    .opacity(contentOpacity)

                    statsGrid
                        .opacity(contentOpacity)

                    VStack(spacing: AppSpacing.small) {
                        completionButton(
                            title: "Play Again",
                            style: .primary,
                            action: onPlayAgain
                        )

                        completionButton(
                            title: "Back to Games",
                            style: .secondary,
                            action: onBackToGames
                        )
                    }
                    .opacity(contentOpacity)
                    .padding(.top, AppSpacing.small)
                }
                .padding(.horizontal, AppSpacing.medium)
                .padding(.vertical, AppSpacing.extraLarge)
            }
        }
        .onAppear {
            if !didRecordProgress {
                dailyProgressStore.recordSession(result: result, comboPeak: result.comboPeak)
                playHistory.recordPlay(result.gameKind)
                sessionStore.clear()
                didRecordProgress = true
            }

            if result.isNewRecord {
                HapticService.success()
            }

            withAnimation(.spring(response: 0.58, dampingFraction: 0.68)) {
                iconScale = 1
            }

            withAnimation(.spring(response: 0.5, dampingFraction: 0.82).delay(0.1)) {
                contentOpacity = 1
            }
        }
    }

    private var successIcon: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [game.color.opacity(0.22), game.color.opacity(0.04)],
                        center: .center,
                        startRadius: 20,
                        endRadius: 90
                    )
                )
                .frame(width: 140, height: 140)

            Image(systemName: resultIcon)
                .font(.system(size: 56, weight: .semibold))
                .foregroundStyle(game.color)
        }
        .scaleEffect(iconScale)
    }

    private var resultIcon: String {
        if result.accuracy == 100 { return "trophy.fill" }
        if result.accuracy >= 80 { return "medal.fill" }
        if result.accuracy >= 60 { return "checkmark.seal.fill" }
        return "book.fill"
    }

    private var statsGrid: some View {
        VStack(spacing: AppSpacing.small) {
            statRow(title: "Score", value: "\(result.score)", icon: "star.fill", tint: .orange)
            statRow(title: "Accuracy", value: "\(result.accuracy)%", icon: "target", tint: game.color)
            statRow(title: "Time", value: formattedTime, icon: "clock.fill", tint: .secondary)
            statRow(title: "XP Earned", value: "+\(result.xpEarned)", icon: "sparkles", tint: .purple)

            if result.comboPeak > 1 {
                statRow(title: "Best Combo", value: "×\(result.comboPeak)", icon: "flame.fill", tint: .orange)
            }
        }
        .padding(AppSpacing.medium)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
    }

    private var formattedTime: String {
        let minutes = result.elapsedSeconds / 60
        let seconds = result.elapsedSeconds % 60
        if minutes > 0 {
            return String(format: "%d:%02d", minutes, seconds)
        }
        return "\(seconds)s"
    }

    private func statRow(title: String, value: String, icon: String, tint: Color) -> some View {
        HStack {
            Label(title, systemImage: icon)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .font(.title3.weight(.semibold))
                .foregroundStyle(tint)
                .contentTransition(.numericText())
        }
        .padding(.vertical, 4)
    }

    @ViewBuilder
    private func completionButton(
        title: String,
        style: CompletionStyle,
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
                        Capsule(style: .continuous).fill(game.color)
                    case .secondary:
                        Capsule(style: .continuous).fill(Color(.secondarySystemGroupedBackground))
                    }
                }
                .foregroundStyle(style == .primary ? .white : .primary)
        }
        .buttonStyle(GamePressButtonStyle())
    }

    private enum CompletionStyle {
        case primary
        case secondary
    }
}

struct GamePressButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(response: 0.28, dampingFraction: 0.72), value: configuration.isPressed)
    }
}

#Preview {
    GameCompletionView(
        game: GameDefinition.catalog[0],
        result: GameResult(
            gameKind: .matchPairs,
            studySetFileName: "hsk1",
            score: 850,
            accuracy: 92,
            elapsedSeconds: 145,
            xpEarned: 320,
            correctCount: 18,
            wrongCount: 2,
            comboPeak: 5,
            isNewRecord: true
        ),
        onPlayAgain: {},
        onBackToGames: {}
    )
}
