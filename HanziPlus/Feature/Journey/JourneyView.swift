//
//  JourneyView.swift
//  HanziPlus
//

import SwiftUI

struct JourneyView: View {

    var showsDismissButton = false

    @Environment(JourneyStore.self) private var journeyStore
    @Environment(WordCatalog.self) private var catalog
    @Environment(LearnedWordsStore.self) private var learnedStore
    @Environment(GameScoreStore.self) private var gameScoreStore
    @Environment(StatisticsStore.self) private var statisticsStore
    @Environment(AchievementStore.self) private var achievementStore
    @Environment(DailyChallengeStore.self) private var dailyChallengeStore
    @Environment(AppTabRouter.self) private var tabRouter
    @Environment(\.dismiss) private var dismiss

    private var progress: JourneyProgress {
        JourneyProgress.current(
            catalog: catalog,
            learnedStore: learnedStore,
            gameScoreStore: gameScoreStore,
            statisticsStore: statisticsStore,
            dailyChallengeStore: dailyChallengeStore
        )
    }

    private var allComplete: Bool {
        journeyStore.collectedSouvenirs.count >= JourneyCityCatalog.all.count
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.large) {
                    heroHeader
                        .padding(.horizontal, AppSpacing.medium)

                    JourneyPassportStrip(progress: progress)
                        .padding(.horizontal, AppSpacing.medium)

                    TravelTouristWordsPanel(
                        categoryIDs: TravelTouristSituations.featuredCategoryIDs
                    ) { categoryID in
                        if showsDismissButton {
                            dismiss()
                        }
                        tabRouter.switchToTravel(deepLink: .category(categoryID))
                    }
                    .padding(.horizontal, AppSpacing.medium)

                    JourneyMapView(
                        cities: JourneyCityCatalog.all,
                        progress: progress,
                        journeyStore: journeyStore,
                        onDismissPresentation: showsDismissButton ? { dismiss() } : nil
                    )
                    .padding(.horizontal, AppSpacing.medium)

                    if allComplete {
                        journeyCompleteBanner
                            .padding(.horizontal, AppSpacing.medium)
                    }
                }
                .padding(.top, AppSpacing.small)
                .padding(.bottom, AppSpacing.extraLarge)
            }
            .background(journeyBackground.ignoresSafeArea())
            .toolbar(showsDismissButton ? .visible : .hidden, for: .navigationBar)
            .toolbar {
                if showsDismissButton {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(L10n.string("common.close")) { dismiss() }
                    }
                }
            }
            .onAppear {
                journeyStore.sync(progress: progress, achievementStore: achievementStore)
            }
            .overlay {
                if let city = journeyStore.celebrationCity {
                    CityUnlockCelebrationView(
                        city: city,
                        isJourneyComplete: allComplete && journeyStore.isCompleted(city)
                    ) {
                        journeyStore.dismissCelebration()
                    }
                    .transition(.opacity.combined(with: .scale(scale: 0.96)))
                }
            }
            .animation(.spring(response: 0.5, dampingFraction: 0.86), value: journeyStore.celebrationCity?.id)
        }
    }

    private var journeyBackground: some View {
        LinearGradient(
            colors: [
                Color(red: 0.04, green: 0.12, blue: 0.22).opacity(0.04),
                Color(.systemGroupedBackground),
                Color(red: 0.1, green: 0.35, blue: 0.28).opacity(0.05)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var heroHeader: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(l10n: "journey.title")
                        .font(.system(size: 34, weight: .bold, design: .rounded))

                    Text(l10n: "journey.subtitle")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Text("🇨🇳")
                    .font(.system(size: 44))
            }

            HStack(spacing: 8) {
                Image(systemName: "airplane.departure")
                    .foregroundStyle(.blue)
                Text(L10n.string(
                    "journey.cities_explored \(journeyStore.collectedSouvenirs.count) \(JourneyCityCatalog.all.count)"
                ))
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Capsule().fill(.ultraThinMaterial))
        }
    }

    private var journeyCompleteBanner: some View {
        VStack(spacing: 12) {
            Text("🎉")
                .font(.system(size: 48))
            Text(l10n: "journey.complete.title")
                .font(.title3.weight(.bold))
            Text(l10n: "journey.complete.subtitle")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(AppSpacing.large)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color.purple.opacity(0.15), Color.blue.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
        .studyCardShadow()
    }
}

#Preview {
    JourneyView()
        .environment(JourneyStore())
        .environment(WordCatalog())
        .environment(LearnedWordsStore())
        .environment(GameScoreStore())
        .environment(StatisticsStore())
        .environment(AchievementStore())
        .environment(DailyChallengeStore())
        .environment(AppTabRouter())
}
