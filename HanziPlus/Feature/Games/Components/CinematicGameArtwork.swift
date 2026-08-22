//
//  CinematicGameArtwork.swift
//  HanziPlus
//

import SwiftUI

/// Unique cinematic artwork per game — consistent modern premium style.
struct CinematicGameArtwork: View {

    let game: GameDefinition
    var height: CGFloat = 220
    var cornerRadius: CGFloat = AppRadius.large
    var showTitle: Bool = false
    var showsVignette: Bool = true
    var showsShadow: Bool = true
    var isLive: Bool = true

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: game.artworkColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Group {
                if isLive {
                    LiveGameScene(game: game, height: height)
                } else {
                    sceneLayer
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))

            if showsVignette {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [.clear, .black.opacity(0.45)],
                            startPoint: .center,
                            endPoint: .bottom
                        )
                    )
            }

            if showTitle {
                VStack(alignment: .leading, spacing: 4) {
                    Spacer()
                    Text(game.emoji)
                        .font(.title)
                    Text(game.title)
                        .font(.headline.weight(.bold))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
            }
        }
        .frame(height: height)
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(.white.opacity(0.12), lineWidth: 0.5)
        }
        .shadow(color: showsShadow ? game.color.opacity(0.28) : .clear, radius: 20, x: 0, y: 10)
    }

    @ViewBuilder
    private var sceneLayer: some View {
        switch game.kind {
        case .hanziMemory: memoryScene
        case .speedChallenge: speedScene
        case .listeningQuiz: listeningScene
        case .matchPairs: matchPairsScene
        case .typingChallenge: typingScene
        case .findTheHanzi: findHanziScene
        case .sentenceBuilder: sentenceScene
        case .smartReview: reviewScene
        case .dailyChallenge: dailyScene
        }
    }

    // MARK: - Scenes

    private var memoryScene: some View {
        ZStack {
            Circle()
                .fill(.white.opacity(0.08))
                .frame(width: height * 0.8)
                .offset(x: height * 0.25, y: -height * 0.1)

            // Panda silhouette via circles
            ZStack {
                Circle().fill(.white.opacity(0.9)).frame(width: height * 0.18)
                Circle().fill(.white.opacity(0.9)).frame(width: height * 0.1).offset(x: -height * 0.08, y: -height * 0.06)
                Circle().fill(.white.opacity(0.9)).frame(width: height * 0.1).offset(x: height * 0.08, y: -height * 0.06)
                Circle().fill(.black.opacity(0.7)).frame(width: height * 0.04).offset(x: -height * 0.04, y: -height * 0.02)
                Circle().fill(.black.opacity(0.7)).frame(width: height * 0.04).offset(x: height * 0.04, y: -height * 0.02)
            }
            .offset(x: -height * 0.15, y: height * 0.05)

            // Character cards
            ForEach(0..<3, id: \.self) { i in
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.white.opacity(0.92))
                    .frame(width: height * 0.16, height: height * 0.2)
                    .overlay {
                        Text(["学", "习", "中"][i])
                            .font(.system(size: height * 0.09, weight: .bold))
                            .foregroundStyle(game.color)
                    }
                    .rotationEffect(.degrees(Double(i - 1) * 12))
                    .offset(x: height * 0.22 + CGFloat(i) * 8, y: CGFloat(i - 1) * 6)
                    .shadow(color: .black.opacity(0.15), radius: 6, y: 4)
            }
        }
    }

    private var speedScene: some View {
        ZStack {
            // Night sky
            LinearGradient(
                colors: [.indigo.opacity(0.8), .black.opacity(0.6)],
                startPoint: .top,
                endPoint: .bottom
            )

            // City lights
            HStack(spacing: 6) {
                ForEach(Array([14, 22, 18, 26, 16, 24, 20, 28].enumerated()), id: \.offset) { _, h in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.yellow.opacity(0.7))
                        .frame(width: 4, height: CGFloat(h))
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, height * 0.08)
            .opacity(0.7)

            // Train
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(
                    LinearGradient(colors: [.white, .orange.opacity(0.8)], startPoint: .leading, endPoint: .trailing)
                )
                .frame(width: height * 0.7, height: height * 0.14)
                .overlay {
                    HStack(spacing: 8) {
                        ForEach(0..<4, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 3)
                                .fill(.cyan.opacity(0.8))
                                .frame(width: height * 0.08, height: height * 0.06)
                        }
                    }
                }
                .offset(y: height * 0.12)

            // Speed lines
            ForEach(0..<5, id: \.self) { i in
                Capsule()
                    .fill(.white.opacity(0.25))
                    .frame(width: height * 0.2, height: 2)
                    .offset(x: -height * 0.35, y: CGFloat(i - 2) * 10)
            }

            Image(systemName: "bolt.fill")
                .font(.system(size: height * 0.12, weight: .bold))
                .foregroundStyle(.yellow)
                .offset(x: height * 0.3, y: -height * 0.2)
        }
    }

    private var listeningScene: some View {
        ZStack {
            // Garden atmosphere
            Circle()
                .fill(.green.opacity(0.25))
                .frame(width: height * 0.5)
                .blur(radius: 20)
                .offset(x: height * 0.2, y: height * 0.15)

            // Headphones figure
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(colors: [.pink.opacity(0.6), .purple.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                    )
                    .frame(width: height * 0.22)

                Image(systemName: "headphones")
                    .font(.system(size: height * 0.14, weight: .semibold))
                    .foregroundStyle(.white)
                    .offset(y: -height * 0.02)

                // Sound waves
                ForEach(0..<3, id: \.self) { i in
                    Circle()
                        .stroke(.white.opacity(0.3 - Double(i) * 0.08), lineWidth: 2)
                        .frame(width: height * 0.28 + CGFloat(i) * 18)
                        .offset(x: height * 0.18)
                }
            }
            .offset(x: -height * 0.05)

            // Pagoda hint
            Image(systemName: "leaf.fill")
                .font(.system(size: height * 0.08))
                .foregroundStyle(.green.opacity(0.6))
                .offset(x: height * 0.28, y: -height * 0.18)
        }
    }

    private var matchPairsScene: some View {
        ZStack {
            Image(systemName: "sparkles")
                .font(.system(size: height * 0.35))
                .foregroundStyle(.yellow.opacity(0.35))
                .offset(x: height * 0.15, y: -height * 0.05)

            floatingCard(index: 0, character: "龙")
            floatingCard(index: 1, character: "凤")
            floatingCard(index: 2, character: "吉")
            floatingCard(index: 3, character: "祥")

            Image(systemName: "flame.fill")
                .font(.system(size: height * 0.1))
                .foregroundStyle(.yellow)
                .offset(y: height * 0.2)
        }
    }

    private func floatingCard(index: Int, character: String) -> some View {
        let angle = Double(index) * .pi / 2
        return RoundedRectangle(cornerRadius: 10, style: .continuous)
            .fill(.white.opacity(0.9))
            .frame(width: height * 0.14, height: height * 0.18)
            .overlay {
                Text(character)
                    .font(.system(size: height * 0.07, weight: .bold))
                    .foregroundStyle(.orange)
            }
            .rotationEffect(.degrees(Double(index) * 18 - 20))
            .offset(
                x: cos(angle) * height * 0.18,
                y: sin(angle) * height * 0.12
            )
    }

    private var typingScene: some View {
        ZStack {
            // Glowing brush stroke
            Capsule()
                .fill(
                    LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing)
                )
                .frame(width: height * 0.5, height: height * 0.04)
                .blur(radius: 4)
                .rotationEffect(.degrees(-25))
                .offset(x: -height * 0.05, y: height * 0.05)

            Image(systemName: "paintbrush.pointed.fill")
                .font(.system(size: height * 0.18, weight: .semibold))
                .foregroundStyle(
                    LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
                )
                .rotationEffect(.degrees(-30))
                .offset(x: -height * 0.2, y: height * 0.08)

            // Glowing Hanzi
            Text("文")
                .font(.system(size: height * 0.28, weight: .bold, design: .serif))
                .foregroundStyle(.white)
                .shadow(color: .yellow.opacity(0.8), radius: 12)
                .offset(x: height * 0.15, y: -height * 0.05)
        }
    }

    private var findHanziScene: some View {
        ZStack {
            // Scrolls
            ForEach(0..<2, id: \.self) { i in
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [.brown.opacity(0.5), .orange.opacity(0.3)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: height * 0.12, height: height * 0.35)
                    .rotationEffect(.degrees(i == 0 ? -8 : 6))
                    .offset(x: i == 0 ? -height * 0.2 : height * 0.22, y: height * 0.05)
            }

            // Lantern glow
            Circle()
                .fill(.orange.opacity(0.4))
                .frame(width: height * 0.25)
                .blur(radius: 15)
                .offset(x: -height * 0.05, y: height * 0.1)

            Image(systemName: "flashlight.on.fill")
                .font(.system(size: height * 0.14))
                .foregroundStyle(.yellow)
                .offset(x: height * 0.05, y: -height * 0.05)

            Image(systemName: "magnifyingglass")
                .font(.system(size: height * 0.1, weight: .bold))
                .foregroundStyle(.white.opacity(0.9))
                .offset(x: height * 0.25, y: -height * 0.15)
        }
    }

    private var sentenceScene: some View {
        ZStack {
            sentenceWordCapsule(index: 0, widthFactor: 0.18, ySign: -1)
            sentenceWordCapsule(index: 1, widthFactor: 0.14, ySign: 1)
            sentenceWordCapsule(index: 2, widthFactor: 0.22, ySign: -1)
            sentenceWordCapsule(index: 3, widthFactor: 0.12, ySign: 1)

            Image(systemName: "text.word.spacing")
                .font(.system(size: height * 0.12))
                .foregroundStyle(.white.opacity(0.8))
                .offset(y: height * 0.18)
        }
    }

    private func sentenceWordCapsule(index: Int, widthFactor: CGFloat, ySign: Int) -> some View {
        Capsule()
            .fill(.white.opacity(0.85))
            .frame(width: height * widthFactor, height: height * 0.07)
            .offset(
                x: CGFloat(index - 2) * height * 0.08,
                y: CGFloat(ySign) * height * 0.08
            )
    }

    private var reviewScene: some View {
        ZStack {
            // Warm desk lamp glow
            Circle()
                .fill(.orange.opacity(0.45))
                .frame(width: height * 0.45)
                .blur(radius: 18)
                .offset(x: -height * 0.18, y: height * 0.08)

            Image(systemName: "lamp.desk.fill")
                .font(.system(size: height * 0.14, weight: .semibold))
                .foregroundStyle(.orange.opacity(0.95))
                .offset(x: -height * 0.22, y: height * 0.12)

            // Glowing words
            glowingWord("词", x: 0.05, y: -0.08)
            glowingWord("汇", x: 0.18, y: 0.02)
            glowingWord("记", x: -0.08, y: 0.06)

            // Student silhouette
            Circle()
                .fill(
                    LinearGradient(colors: [.white.opacity(0.5), .white.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                )
                .frame(width: height * 0.14)
                .offset(x: height * 0.05, y: height * 0.15)
        }
    }

    private func glowingWord(_ char: String, x: CGFloat, y: CGFloat) -> some View {
        Text(char)
            .font(.system(size: height * 0.11, weight: .bold, design: .serif))
            .foregroundStyle(.white)
            .shadow(color: .cyan.opacity(0.7), radius: 10)
            .offset(x: height * x, y: height * y)
    }

    private var dailyScene: some View {
        ZStack {
            Image(systemName: "sun.max.fill")
                .font(.system(size: height * 0.2))
                .foregroundStyle(.yellow.opacity(0.8))
                .offset(x: height * 0.25, y: -height * 0.2)
            Image(systemName: "calendar")
                .font(.system(size: height * 0.16, weight: .semibold))
                .foregroundStyle(.white.opacity(0.9))
            ForEach(0..<3, id: \.self) { i in
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green.opacity(0.8))
                    .offset(x: CGFloat(i - 1) * height * 0.12, y: height * 0.2)
            }
        }
    }
}

// Backward-compatible wrapper
struct GameArtworkView: View {
    let game: GameDefinition
    var height: CGFloat = 220
    var cornerRadius: CGFloat = AppRadius.large

    var body: some View {
        CinematicGameArtwork(game: game, height: height, cornerRadius: cornerRadius)
    }
}

#Preview {
    ScrollView {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            ForEach(GameDefinition.libraryGames) { game in
                CinematicGameArtwork(game: game, height: 140, showTitle: true)
            }
        }
        .padding()
    }
}
