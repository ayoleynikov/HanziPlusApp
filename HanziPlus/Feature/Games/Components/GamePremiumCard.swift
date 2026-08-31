//
//  GamePremiumCard.swift
//  HanziPlus
//

import SwiftUI

struct GamePremiumCard: View {

    let game: GameDefinition
    var statistics: GameStatistics = GameStatistics()
    var badges: [GameBadge] = []
    var style: CardStyle = .standard

    @State private var floatUp = false
    @State private var isHovered = false
    @State private var starTwinkle = false
    @State private var shimmerPhase: CGFloat = 0

    enum CardStyle {
        case featured
        case standard
        case compact
        case list
    }

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

    private var cornerRadius: CGFloat { AppRadius.studyCard }

    private var hasProgress: Bool { statistics.gamesPlayed > 0 }

    private var completionProgress: Double {
        guard hasProgress else { return 0 }
        return Double(statistics.averageAccuracy) / 100
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            artworkLayer
            lightingOverlay
            topChrome
            bottomContent
        }
        .frame(width: cardWidth, height: cardHeight)
        .frame(maxWidth: style == .featured || style == .list ? .infinity : nil)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(
                    LinearGradient(
                        colors: [
                            .white.opacity(isHovered ? 0.45 : 0.22),
                            game.color.opacity(isHovered ? 0.55 : 0.18),
                            .white.opacity(0.08)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: isHovered ? 1.5 : 0.75
                )
        }
        .shadow(
            color: game.color.opacity(isHovered ? 0.35 : 0.22),
            radius: isHovered ? 32 : 18,
            x: 0,
            y: isHovered ? 20 : 12
        )
        .shadow(color: .black.opacity(isHovered ? 0.18 : 0.12), radius: isHovered ? 24 : 14, x: 0, y: isHovered ? 14 : 8)
        .offset(y: floatUp ? -3 : 3)
        .scaleEffect(isHovered ? 1.02 : 1)
        .animation(.easeInOut(duration: 2.8).repeatForever(autoreverses: true), value: floatUp)
        .animation(.spring(response: 0.45, dampingFraction: 0.78), value: isHovered)
        .onAppear {
            floatUp = true
            withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
                starTwinkle = true
            }
            withAnimation(.linear(duration: 6).repeatForever(autoreverses: false)) {
                shimmerPhase = 1
            }
        }
        .onHover { hovering in
            isHovered = hovering
        }
    }

    // MARK: - Artwork

    private var artworkLayer: some View {
        GeometryReader { geometry in
            ZStack {
                CinematicGameArtwork(
                    game: game,
                    height: geometry.size.height * 1.12,
                    cornerRadius: cornerRadius,
                    showsVignette: false,
                    showsShadow: false
                )
                .scaleEffect(isHovered ? 1.06 : 1.03)
                .offset(
                    x: isHovered ? 4 : -2,
                    y: floatUp ? -6 : 2
                )
                .animation(.easeInOut(duration: 3.2).repeatForever(autoreverses: true), value: floatUp)
                .animation(.spring(response: 0.55, dampingFraction: 0.82), value: isHovered)

                if style == .featured {
                    featuredShimmer(in: geometry.size)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipped()
        }
    }

    private func featuredShimmer(in size: CGSize) -> some View {
        LinearGradient(
            colors: [
                .clear,
                .white.opacity(0.12),
                .clear
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
        .frame(width: size.width * 0.45)
        .rotationEffect(.degrees(18))
        .offset(x: -size.width * 0.6 + shimmerPhase * size.width * 1.4)
        .blendMode(.plusLighter)
        .allowsHitTesting(false)
    }

    private var lightingOverlay: some View {
        ZStack {
            LinearGradient(
                colors: [
                    game.color.opacity(0.18),
                    .clear,
                    .black.opacity(0.08)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            LinearGradient(
                colors: [.clear, .clear, .black.opacity(style == .compact ? 0.72 : 0.82)],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .allowsHitTesting(false)
    }

    // MARK: - Top Chrome

    private var topChrome: some View {
        VStack {
            HStack(alignment: .top) {
                categoryBadge

                Spacer()

                VStack(alignment: .trailing, spacing: 6) {
                    if style == .featured {
                        recommendedBadge
                    }

                    ForEach(badgeItems, id: \.rawValue) { badge in
                        GameBadgePill(badge: badge)
                    }
                }
            }
            .padding(style == .compact ? 12 : 16)

            Spacer()
        }
    }

    private var badgeItems: [GameBadge] {
        badges.filter { $0 != .recommended || style != .featured }
    }

    private var categoryBadge: some View {
        HStack(spacing: 5) {
            Text(game.emoji)
                .font(.system(size: style == .compact ? 14 : 16))
            Text(game.collection.title)
                .font(.caption2.weight(.bold))
                .foregroundStyle(.white.opacity(0.92))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(.ultraThinMaterial, in: Capsule(style: .continuous))
        .overlay {
            Capsule(style: .continuous)
                .strokeBorder(.white.opacity(0.22), lineWidth: 0.5)
        }
    }

    private var recommendedBadge: some View {
        HStack(spacing: 5) {
            Image(systemName: "sparkles")
                .font(.caption2.weight(.bold))
                .symbolEffect(.pulse, options: .repeating)
            Text(l10n: "games.daily.recommended")
                .font(.caption2.weight(.bold))
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 12)
        .padding(.vertical, 7)
        .background {
            Capsule(style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [game.color, game.color.opacity(0.75)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
        .shadow(color: game.color.opacity(0.45), radius: 8, y: 4)
    }

    // MARK: - Bottom Content

    private var bottomContent: some View {
        VStack(alignment: .leading, spacing: style == .compact ? 8 : 10) {
            VStack(alignment: .leading, spacing: 4) {
                Text(game.localizedTitle)
                    .font(titleFont)
                    .foregroundStyle(.white)
                    .lineLimit(style == .compact ? 1 : 2)
                    .shadow(color: .black.opacity(0.35), radius: 4, y: 2)

                Text(game.localizedTagline)
                    .font(style == .compact ? .caption2 : .caption)
                    .foregroundStyle(.white.opacity(0.88))
                    .lineLimit(style == .compact ? 2 : 2)
                    .fixedSize(horizontal: false, vertical: true)
            }

            metadataRow

            if hasProgress, style != .compact {
                progressSection
            }
        }
        .padding(.horizontal, style == .compact ? 14 : 18)
        .padding(.bottom, style == .compact ? 14 : 18)
        .padding(.top, style == .compact ? 28 : 36)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            LinearGradient(
                colors: [
                    .clear,
                    .black.opacity(0.35),
                    .black.opacity(0.72)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }

    private var titleFont: Font {
        switch style {
        case .featured: .title.weight(.bold)
        case .standard, .list: .title3.weight(.bold)
        case .compact: .headline.weight(.bold)
        }
    }

    private var metadataRow: some View {
        HStack(spacing: style == .compact ? 6 : 8) {
            difficultyChip
            timeChip
            if style == .compact, hasProgress {
                Spacer(minLength: 0)
                Text(L10n.percent(statistics.averageAccuracy))
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.white.opacity(0.85))
            }
        }
    }

    private var difficultyChip: some View {
        HStack(spacing: 3) {
            Text("⭐")
                .font(.caption2)
                .scaleEffect(starTwinkle ? 1.12 : 0.92)
                .opacity(starTwinkle ? 1 : 0.72)
            Text(game.difficulty.label)
                .font(.caption2.weight(.bold))
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(glassChipBackground(tint: game.difficulty.color))
    }

    private var timeChip: some View {
        HStack(spacing: 3) {
            Image(systemName: "clock.fill")
                .font(.system(size: 9, weight: .bold))
            Text(game.estimatedTimeLabel)
                .font(.caption2.weight(.bold))
        }
        .foregroundStyle(.white.opacity(0.92))
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(glassChipBackground(tint: .white.opacity(0.35)))
    }

    private func glassChipBackground(tint: Color) -> some View {
        Capsule(style: .continuous)
            .fill(.ultraThinMaterial)
            .overlay {
                Capsule(style: .continuous)
                    .fill(tint.opacity(0.28))
            }
            .overlay {
                Capsule(style: .continuous)
                    .strokeBorder(.white.opacity(0.18), lineWidth: 0.5)
            }
    }

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            AnimatedProgressBar(progress: completionProgress, tint: game.color, height: 5)

            HStack(spacing: 12) {
                progressStat(label: "Best", value: "\(statistics.bestScore)")
                progressStat(label: L10n.string("common.done_short"), value: L10n.percent(statistics.averageAccuracy))
            }
        }
        .padding(.top, 2)
    }

    private func progressStat(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.system(size: 9, weight: .semibold))
                .foregroundStyle(.white.opacity(0.55))
                .textCase(.uppercase)
            Text(value)
                .font(.caption2.weight(.bold))
                .foregroundStyle(.white.opacity(0.95))
        }
    }
}

// MARK: - Button Style

struct GameCardButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.965 : 1)
            .brightness(configuration.isPressed ? 0.04 : 0)
            .shadow(
                color: configuration.isPressed ? Color.white.opacity(0.25) : .clear,
                radius: configuration.isPressed ? 16 : 0
            )
            .animation(.spring(response: 0.32, dampingFraction: 0.68), value: configuration.isPressed)
    }
}

#Preview("Standard") {
    GamePremiumCard(
        game: GameDefinition.catalog[4],
        statistics: GameStatistics(
            gamesPlayed: 12,
            bestScore: 850,
            longestStreak: 7,
            xpEarned: 420
        ),
        badges: [.featured, .popular],
        style: .standard
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}

#Preview("Featured") {
    GamePremiumCard(
        game: GameDefinition.catalog[1],
        badges: [.recommended],
        style: .featured
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}
