//
//  GameLockedCard.swift
//  HanziPlus
//

import SwiftUI

struct GameLockedCard: View {

    let game: GameDefinition
    let unlockRequirement: String
    var style: GamePremiumCard.CardStyle = .standard

    @State private var floatUp = false
    @State private var lockPulse = false

    private var cardHeight: CGFloat {
        switch style {
        case .featured: 400
        case .standard, .list: 340
        case .compact: 248
        }
    }

    private var cardWidth: CGFloat? {
        switch style {
        case .featured, .list: nil
        case .standard: 300
        case .compact: 236
        }
    }

    private let cornerRadius: CGFloat = AppRadius.studyCard

    var body: some View {
        ZStack(alignment: .bottom) {
            lockedArtwork
            gradientOverlay
            lockOverlay
            bottomContent
        }
        .frame(width: cardWidth, height: cardHeight)
        .frame(maxWidth: style == .featured || style == .list ? .infinity : nil)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(.white.opacity(0.12), lineWidth: 0.75)
        }
        .shadow(color: game.color.opacity(0.14), radius: 14, x: 0, y: 8)
        .saturation(0.72)
        .offset(y: floatUp ? -2 : 2)
        .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: floatUp)
        .allowsHitTesting(false)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(L10n.string("\(game.localizedTitle). Locked. \(unlockRequirement)"))
        .onAppear {
            floatUp = true
            lockPulse = true
        }
    }

    private var lockedArtwork: some View {
        ZStack {
            CinematicGameArtwork(
                game: game,
                height: cardHeight * 1.1,
                cornerRadius: cornerRadius,
                showsVignette: false,
                showsShadow: false
            )

            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(0.5)
        }
        .blur(radius: 2)
    }

    private var gradientOverlay: some View {
        ZStack {
            LinearGradient(
                colors: [game.color.opacity(0.12), .clear, .black.opacity(0.12)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            LinearGradient(
                colors: [.clear, .black.opacity(0.5), .black.opacity(0.82)],
                startPoint: .center,
                endPoint: .bottom
            )
        }
        .allowsHitTesting(false)
    }

    private var lockOverlay: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: style == .compact ? 48 : 56, height: style == .compact ? 48 : 56)
                    .overlay {
                        Circle()
                            .strokeBorder(.white.opacity(0.22), lineWidth: 0.75)
                    }

                Image(systemName: "lock.fill")
                    .font(style == .compact ? .body.weight(.semibold) : .title3.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.92))
                    .scaleEffect(lockPulse ? 1.06 : 0.94)
                    .animation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true), value: lockPulse)
            }

            Text(unlockRequirement)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.white.opacity(0.88))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
        .frame(maxHeight: .infinity)
        .padding(.bottom, cardHeight * (style == .compact ? 0.22 : 0.28))
    }

    private var bottomContent: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Image(systemName: "lock.fill")
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.white.opacity(0.75))
                Text(game.localizedTitle)
                    .font(style == .compact ? .headline.weight(.bold) : .title3.weight(.bold))
                    .foregroundStyle(.white)
                    .lineLimit(1)
            }

            Text(game.localizedTagline)
                .font(style == .compact ? .caption2 : .caption)
                .foregroundStyle(.white.opacity(0.82))
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, style == .compact ? 14 : 18)
        .padding(.bottom, style == .compact ? 14 : 18)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    GameLockedCard(
        game: GameDefinition.catalog[4],
        unlockRequirement: "Unlock by completing Chengdu.",
        style: .standard
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}
