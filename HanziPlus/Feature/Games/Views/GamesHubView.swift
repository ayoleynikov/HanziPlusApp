//
//  GamesHubView.swift
//  HanziPlus
//

import SwiftUI

struct GamesHubView: View {

    @Environment(GameScoreStore.self) private var scoreStore
    @Environment(GameSessionStore.self) private var sessionStore
    @Environment(GamesDailyProgressStore.self) private var dailyProgressStore
    @Environment(DailyChallengeStore.self) private var dailyChallengeStore
    @Environment(GamesPlayHistoryStore.self) private var playHistory
    @Environment(JourneyStore.self) private var journeyStore

    @State private var heroIndex = 0
    @State private var scrollOffset: CGFloat = 0
    @State private var appeared = false

    private var featuredGames: [GameDefinition] {
        GamesFeaturedSelection.featuredGames
    }

    private var featuredKinds: Set<GameKind> {
        Set(featuredGames.map(\.kind))
    }

    private var recommendedGame: GameDefinition {
        let pool = playableGames.isEmpty ? GameDefinition.libraryGames : playableGames
        let day = Calendar.current.ordinality(of: .day, in: .year, for: .now) ?? 1
        return pool[day % pool.count]
    }

    private var heroTint: Color {
        featuredGames.indices.contains(heroIndex)
            ? featuredGames[heroIndex].color
            : .indigo
    }

    private var totalXP: Int {
        scoreStore.totalXPAllGames()
    }

    private var playableGames: [GameDefinition] {
        GameDefinition.libraryGames.filter {
            GameAvailability.isPlayable($0, journeyStore: journeyStore, totalXP: totalXP)
        }
    }

    private var lockedGames: [(game: GameDefinition, requirement: GameLockRequirement)] {
        GameAvailability.lockedGames(journeyStore: journeyStore, totalXP: totalXP)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.extraLarge) {
                    header
                        .sectionReveal(appeared, delay: 0)

                    GameHeroCarousel(
                        games: featuredGames,
                        selectedIndex: $heroIndex,
                        scrollOffset: scrollOffset
                    )
                    .padding(.horizontal, AppSpacing.medium)
                    .sectionReveal(appeared, delay: 0.05)

                    GamesTodaySection(
                        recommendedGame: recommendedGame,
                        tasks: dailyChallengeStore.state.tasks,
                        completedTaskIDs: dailyChallengeStore.state.completedTaskIDs,
                        xpReward: 150,
                        activeSession: sessionStore.activeSession,
                        recentlyPlayed: playHistory.recentlyPlayed,
                        statistics: { scoreStore.statistics(for: $0) }
                    )
                    .sectionReveal(appeared, delay: 0.1)

                    featuredCollectionsSection
                        .sectionReveal(appeared, delay: 0.15)

                    allGamesSection
                        .sectionReveal(appeared, delay: 0.2)

                    GamesPlayerProfileSection(
                        totalXP: totalXP,
                        todayXP: dailyProgressStore.progress.xpEarned,
                        weeklyXP: dailyProgressStore.weeklyXP,
                        streak: max(dailyProgressStore.progress.currentStreak, dailyChallengeStore.streakDays),
                        gamesPlayed: dailyProgressStore.progress.gamesPlayed,
                        accuracy: dailyProgressStore.progress.accuracy
                    )
                    .sectionReveal(appeared, delay: 0.25)
                }
                .padding(.bottom, AppSpacing.extraLarge)
                .background(
                    GeometryReader { geometry in
                        Color.clear.preference(
                            key: GamesScrollOffsetKey.self,
                            value: geometry.frame(in: .named("gamesScroll")).minY
                        )
                    }
                )
            }
            .coordinateSpace(name: "gamesScroll")
            .onPreferenceChange(GamesScrollOffsetKey.self) { scrollOffset = $0 }
            .background(GamesPremiumBackground(tint: heroTint))
            .toolbar(.hidden, for: .navigationBar)
            .onAppear {
                dailyChallengeStore.refreshIfNeeded()
                withAnimation(.spring(response: 0.65, dampingFraction: 0.86)) {
                    appeared = true
                }
            }
        }
    }

    private var header: some View {
        Text("games.title")
            .font(.largeTitle.weight(.bold))
            .padding(.horizontal, AppSpacing.medium)
            .padding(.top, AppSpacing.small)
    }

    private var featuredCollectionsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("games.section.collections")
                .font(.title2.weight(.bold))
                .padding(.horizontal, AppSpacing.medium)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.medium) {
                    ForEach(GameCollection.featured) { collection in
                        GameCollectionCinematicCard(collection: collection)
                    }
                }
                .padding(.horizontal, AppSpacing.medium)
                .padding(.vertical, 4)
            }
        }
    }

    private var allGamesSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            Text("games.section.play")
                .font(.title2.weight(.bold))
                .padding(.horizontal, AppSpacing.medium)

            if let featuredGame = playableGames.first {
                NavigationLink {
                    GameDetailView(game: featuredGame)
                } label: {
                    GamePremiumCard(
                        game: featuredGame,
                        statistics: scoreStore.statistics(for: featuredGame.kind),
                        badges: featuredBadges(for: featuredGame),
                        style: .featured
                    )
                }
                .buttonStyle(GameCardButtonStyle())
                .padding(.horizontal, AppSpacing.medium)
            }

            if playableGames.count > 1 || !lockedGames.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: AppSpacing.medium) {
                        ForEach(Array(playableGames.dropFirst())) { game in
                            NavigationLink {
                                GameDetailView(game: game)
                            } label: {
                                GamePremiumCard(
                                    game: game,
                                    statistics: scoreStore.statistics(for: game.kind),
                                    badges: badges(for: game),
                                    style: .standard
                                )
                            }
                            .buttonStyle(GameCardButtonStyle())
                        }

                        ForEach(lockedGames, id: \.game.id) { item in
                            GameLockedCard(
                                game: item.game,
                                unlockRequirement: item.requirement.label,
                                style: .standard
                            )
                        }
                    }
                    .padding(.horizontal, AppSpacing.medium)
                    .padding(.vertical, 4)
                }
            }
        }
    }

    private func featuredBadges(for game: GameDefinition) -> [GameBadge] {
        var result = badges(for: game)
        if !result.contains(.recommended) {
            result.insert(.recommended, at: 0)
        }
        return Array(result.prefix(2))
    }

    private func badges(for game: GameDefinition) -> [GameBadge] {
        GameHubBadgeResolver.badges(
            for: game,
            featuredKinds: featuredKinds,
            recommendedKind: recommendedGame.kind,
            recentlyPlayed: playHistory.recentlyPlayed,
            gamesPlayed: scoreStore.statistics(for: game.kind).gamesPlayed
        )
    }
}

private extension View {
    func sectionReveal(_ appeared: Bool, delay: Double) -> some View {
        opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 18)
            .animation(
                .spring(response: 0.58, dampingFraction: 0.84).delay(delay),
                value: appeared
            )
    }
}

private struct GamesScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    GamesHubView()
        .environment(GameScoreStore())
        .environment(GameSessionStore())
        .environment(GamesDailyProgressStore())
        .environment(DailyChallengeStore())
        .environment(GamesPlayHistoryStore())
        .environment(AchievementStore())
        .environment(JourneyStore())
}
