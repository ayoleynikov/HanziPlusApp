//
//  CollectionArtworkView.swift
//  HanziPlus
//

import SwiftUI

struct CollectionArtworkView: View {

    let collection: GameCollection
    var height: CGFloat = 160

    var body: some View {
        ZStack {
            LinearGradient(
                colors: collection.artworkColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            sceneContent

            LinearGradient(
                colors: [.clear, .black.opacity(0.35)],
                startPoint: .center,
                endPoint: .bottom
            )
        }
        .frame(height: height)
    }

    @ViewBuilder
    private var sceneContent: some View {
        switch collection {
        case .vocabulary:
            ZStack {
                ForEach(0..<3, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(.white.opacity(0.85))
                        .frame(width: height * 0.14, height: height * 0.18)
                        .overlay { Text(["词", "汇", "学"][i]).font(.system(size: height * 0.08, weight: .bold)).foregroundStyle(.blue) }
                        .rotationEffect(.degrees(Double(i - 1) * 10))
                        .offset(x: CGFloat(i - 1) * height * 0.12, y: CGFloat(i) * 4)
                }
            }
        case .memory:
            Text("🧠")
                .font(.system(size: height * 0.35))
                .shadow(color: .white.opacity(0.3), radius: 12)
        case .listening:
            ZStack {
                Image(systemName: "headphones")
                    .font(.system(size: height * 0.22, weight: .semibold))
                    .foregroundStyle(.white)
                Image(systemName: "leaf.fill")
                    .font(.system(size: height * 0.1))
                    .foregroundStyle(.green.opacity(0.7))
                    .offset(x: height * 0.2, y: -height * 0.15)
            }
        case .speed:
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.white.opacity(0.9))
                    .frame(width: height * 0.55, height: height * 0.12)
                    .offset(y: height * 0.08)
                Image(systemName: "bolt.fill")
                    .font(.system(size: height * 0.18))
                    .foregroundStyle(.yellow)
                    .offset(x: height * 0.22, y: -height * 0.12)
            }
        case .writing:
            ZStack {
                Image(systemName: "paintbrush.pointed.fill")
                    .font(.system(size: height * 0.2))
                    .foregroundStyle(.yellow)
                    .rotationEffect(.degrees(-25))
                Text("文")
                    .font(.system(size: height * 0.22, weight: .bold, design: .serif))
                    .foregroundStyle(.white)
                    .shadow(color: .orange.opacity(0.8), radius: 10)
                    .offset(x: height * 0.15)
            }
        case .review:
            ZStack {
                Circle()
                    .fill(.orange.opacity(0.35))
                    .frame(width: height * 0.35)
                    .blur(radius: 8)
                    .offset(x: -height * 0.15, y: height * 0.05)
                Image(systemName: "lamp.desk.fill")
                    .font(.system(size: height * 0.16))
                    .foregroundStyle(.orange.opacity(0.9))
                    .offset(x: -height * 0.18, y: height * 0.1)
                ForEach(0..<2, id: \.self) { i in
                    Text(["复", "习"][i])
                        .font(.system(size: height * 0.12, weight: .bold))
                        .foregroundStyle(.white)
                        .shadow(color: .cyan.opacity(0.6), radius: 8)
                        .offset(x: height * 0.1 + CGFloat(i) * 20, y: CGFloat(i - 1) * 8)
                }
            }
        }
    }
}

struct GameCollectionCinematicCard: View {

    let collection: GameCollection

    var body: some View {
        NavigationLink {
            GameCollectionDetailView(collection: collection)
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                CollectionArtworkView(collection: collection, height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous))
                    .padding(12)

                VStack(alignment: .leading, spacing: 4) {
                    Text("\(collection.emoji) \(collection.title)")
                        .font(.headline.weight(.bold))
                        .foregroundStyle(.primary)
                        .lineLimit(1)

                    Text(collection.subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)

                    Text("\(collection.games.count) games")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(collection.tint)
                        .padding(.top, 4)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .frame(width: 260)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
                    .overlay {
                        RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                            .strokeBorder(Color.primary.opacity(0.06), lineWidth: 0.5)
                    }
            }
            .studyCardShadow()
        }
        .buttonStyle(GameCardButtonStyle())
    }
}

struct GameCollectionDetailView: View {

    let collection: GameCollection

    @Environment(GameScoreStore.self) private var scoreStore
    @Environment(GamesPlayHistoryStore.self) private var playHistory

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                ZStack(alignment: .bottomLeading) {
                    CollectionArtworkView(collection: collection, height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous))

                    VStack(alignment: .leading, spacing: 6) {
                        Text(collection.title)
                            .font(.title.weight(.bold))
                            .foregroundStyle(.white)
                        Text(collection.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.85))
                    }
                    .padding(24)
                }
                .padding(.horizontal, AppSpacing.medium)

                LazyVStack(spacing: AppSpacing.medium) {
                    ForEach(Array(collection.games.enumerated()), id: \.element.id) { index, game in
                        if GameAvailability.isPlayable(game) {
                            NavigationLink {
                                GameDetailView(game: game)
                            } label: {
                                GamePremiumCard(
                                    game: game,
                                    statistics: scoreStore.statistics(for: game.kind),
                                    badges: GameHubBadgeResolver.badges(
                                        for: game,
                                        featuredKinds: [],
                                        recommendedKind: GameDefinition.recommended().kind,
                                        recentlyPlayed: playHistory.recentlyPlayed,
                                        gamesPlayed: scoreStore.statistics(for: game.kind).gamesPlayed
                                    ),
                                    style: index == 0 ? .featured : .list
                                )
                            }
                            .buttonStyle(GameCardButtonStyle())
                        }
                    }
                }
                .padding(.horizontal, AppSpacing.medium)
            }
            .padding(.bottom, AppSpacing.extraLarge)
        }
        .background(GamesPremiumBackground(tint: collection.tint))
        .navigationTitle(collection.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
