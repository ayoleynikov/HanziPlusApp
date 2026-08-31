//
//  TravelToolkitHubView.swift
//  HanziPlus
//

import SwiftUI

struct TravelToolkitHubView: View {

    @Environment(JourneyStore.self) private var journeyStore
    @Environment(WordCatalog.self) private var catalog
    @Environment(LearnedWordsStore.self) private var learnedStore
    @Environment(GameScoreStore.self) private var gameScoreStore
    @Environment(StatisticsStore.self) private var statisticsStore
    @Environment(DailyChallengeStore.self) private var dailyChallengeStore
    @Environment(AchievementStore.self) private var achievementStore

    @Binding var path: NavigationPath

    private var journeyProgress: JourneyProgress {
        JourneyProgress.current(
            catalog: catalog,
            learnedStore: learnedStore,
            gameScoreStore: gameScoreStore,
            statisticsStore: statisticsStore,
            dailyChallengeStore: dailyChallengeStore
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                header
                touristWordsSection
                journeyRouteSection
                tripEssentialsSection
            }
            .padding(.bottom, AppSpacing.extraLarge)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(L10n.string( "travel.nav_title"))
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            journeyStore.sync(progress: journeyProgress, achievementStore: achievementStore)
        }
    }

    private var touristWordsSection: some View {
        TravelTouristWordsPanel(
            categoryIDs: TravelTouristSituations.featuredCategoryIDs
        ) { categoryID in
            HapticService.light()
            path.append(TravelToolkitRoute.category(categoryID))
        }
        .padding(.horizontal, AppSpacing.medium)
    }

    private var journeyRouteSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(l10n: "travel.section.journey_route")
                .font(.title3.weight(.semibold))
                .padding(.horizontal, AppSpacing.medium)

            JourneyMapView(
                cities: JourneyCityCatalog.all,
                progress: journeyProgress,
                journeyStore: journeyStore,
                showsRouteTitle: false
            )
            .padding(.horizontal, AppSpacing.medium)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(l10n: "travel.offline_blurb")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.top, 4)
    }

    private var tripEssentialsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(l10n: "travel.section.trip_essentials")
                .font(.title3.weight(.semibold))
                .padding(.horizontal, AppSpacing.medium)

            TravelTripEssentialsPanel(
                phrases: TravelPhraseCatalog.tripEssentials()
            ) { phraseID in
                HapticService.light()
                path.append(TravelToolkitRoute.phrase(phraseID))
            }
            .padding(.horizontal, AppSpacing.medium)
        }
    }
}
