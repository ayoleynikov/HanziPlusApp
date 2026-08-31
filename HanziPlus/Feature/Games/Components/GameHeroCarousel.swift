//
//  GameHeroCarousel.swift
//  HanziPlus
//

import SwiftUI

enum GamesFeaturedSelection {
    private static var cached: [GameDefinition]?

    static var featuredGames: [GameDefinition] {
        if let cached { return cached }
        let shuffled = GameDefinition.featuredPool.shuffled()
        let games = Array(shuffled.prefix(min(5, shuffled.count)))
        cached = games
        return games
    }
}

struct GameHeroCarousel: View {

    let games: [GameDefinition]
    @Binding var selectedIndex: Int
    var scrollOffset: CGFloat = 0

    private let cardHeight: CGFloat = 420
    private let artworkHeight: CGFloat = 280

    var body: some View {
        VStack(spacing: 16) {
            TabView(selection: $selectedIndex) {
                ForEach(Array(games.enumerated()), id: \.element.id) { index, game in
                    GameHeroSlide(
                        game: game,
                        scrollOffset: scrollOffset,
                        cardHeight: cardHeight,
                        artworkHeight: artworkHeight
                    )
                    .tag(index)
                    .padding(.horizontal, 4)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: cardHeight)
            .scaleEffect(scrollOffset > 0 ? 1 - min(scrollOffset / 5000, 0.02) : 1)
            .animation(.spring(response: 0.45, dampingFraction: 0.88), value: selectedIndex)

            if games.count > 1 {
                HStack(spacing: 6) {
                    ForEach(0..<games.count, id: \.self) { index in
                        Capsule()
                            .fill(index == selectedIndex ? games[index].color : Color.primary.opacity(0.15))
                            .frame(width: index == selectedIndex ? 20 : 6, height: 6)
                            .animation(.spring(response: 0.35, dampingFraction: 0.8), value: selectedIndex)
                    }
                }
            }
        }
    }
}

private struct GameHeroSlide: View {

    let game: GameDefinition
    var scrollOffset: CGFloat = 0
    let cardHeight: CGFloat
    let artworkHeight: CGFloat

    private var parallaxOffset: CGFloat {
        scrollOffset > 0 ? -scrollOffset * 0.2 : scrollOffset * 0.06
    }

    var body: some View {
        VStack(spacing: 0) {
            CinematicGameArtwork(
                game: game,
                height: artworkHeight,
                cornerRadius: 0,
                showsVignette: false,
                showsShadow: false
            )
            .offset(y: parallaxOffset)
            .scaleEffect(scrollOffset > 0 ? 1 + scrollOffset / 2400 : 1)
            .frame(height: artworkHeight)
            .clipped()

            VStack(spacing: 20) {
                VStack(spacing: 8) {
                    Text(game.localizedTitle)
                        .font(.title.weight(.bold))
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.center)

                    Text(game.localizedTagline)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.top, 4)

                NavigationLink {
                    GameDetailView(game: game)
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "play.fill")
                            .font(.body.weight(.bold))
                        Text(l10n: "games.play_now")
                            .font(.headline.weight(.semibold))
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background {
                        Capsule(style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [game.color, game.artworkColors.last ?? game.color],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    }
                }
                .buttonStyle(GamePressButtonStyle())
                .simultaneousGesture(TapGesture().onEnded { HapticService.light() })
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity)
            .frame(height: cardHeight - artworkHeight)
            .background(Color(.secondarySystemGroupedBackground))
        }
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .strokeBorder(Color.primary.opacity(0.06), lineWidth: 0.5)
        }
        .studyCardShadow()
    }
}

#Preview {
    GameHeroCarousel(games: GameDefinition.featuredPool, selectedIndex: .constant(0))
        .padding()
        .background(Color(.systemGroupedBackground))
}
