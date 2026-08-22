//
//  JourneyView.swift
//  HanziPlus
//

import SwiftUI

struct JourneyView: View {

    @Environment(JourneyStore.self) private var journeyStore
    @Environment(WordCatalog.self) private var catalog
    @Environment(LearnedWordsStore.self) private var learnedStore
    @Environment(GameScoreStore.self) private var gameScoreStore
    @Environment(StatisticsStore.self) private var statisticsStore
    @Environment(AchievementStore.self) private var achievementStore
    @Environment(DailyChallengeStore.self) private var dailyChallengeStore

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

                    statsRow
                        .padding(.horizontal, AppSpacing.medium)

                    JourneyPassportStrip(progress: progress)
                        .padding(.horizontal, AppSpacing.medium)

                    quickLinks
                        .padding(.horizontal, AppSpacing.medium)

                    JourneyMapView(
                        cities: JourneyCityCatalog.all,
                        progress: progress,
                        journeyStore: journeyStore
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
            .toolbar(.hidden, for: .navigationBar)
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
                    Text("Journey")
                        .font(.system(size: 34, weight: .bold, design: .rounded))

                    Text("Travel across China as you master Chinese.")
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
                Text("\(journeyStore.collectedSouvenirs.count) of \(JourneyCityCatalog.all.count) cities explored")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Capsule().fill(.ultraThinMaterial))
        }
    }

    private var statsRow: some View {
        HStack(spacing: AppSpacing.small) {
            JourneyStatChip(title: "XP", value: "\(progress.totalXP)", icon: "sparkles", tint: .purple)
            JourneyStatChip(title: "Learned", value: "\(progress.learnedWords)", icon: "checkmark.circle.fill", tint: .green)
            JourneyStatChip(title: "Games", value: "\(progress.gamesPlayed)", icon: "gamecontroller.fill", tint: .orange)
        }
    }

    private var quickLinks: some View {
        HStack(spacing: AppSpacing.small) {
            NavigationLink {
                JourneyPassportView(progress: progress)
            } label: {
                JourneyQuickLink(title: "Travel Collection", icon: "rectangle.stack.fill", tint: .blue)
            }
            .buttonStyle(.plain)

            NavigationLink {
                JourneySouvenirsView()
            } label: {
                JourneyQuickLink(title: "Souvenirs", icon: "gift.fill", tint: .orange)
            }
            .buttonStyle(.plain)
        }
    }

    private var journeyCompleteBanner: some View {
        VStack(spacing: 12) {
            Text("🎉")
                .font(.system(size: 48))
            Text("China Journey Complete!")
                .font(.title3.weight(.bold))
            Text("You've collected every travel collectible. You're a true explorer!")
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

private struct JourneyStatChip: View {
    let title: String
    let value: String
    let icon: String
    let tint: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption.weight(.bold))
                .foregroundStyle(tint)
            Text(value)
                .font(.headline.weight(.bold))
            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial)
        }
    }
}

private struct JourneyQuickLink: View {
    let title: String
    let icon: String
    let tint: Color

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundStyle(tint)
            Text(title)
                .font(.subheadline.weight(.semibold))
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption.weight(.bold))
                .foregroundStyle(.tertiary)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill(.ultraThinMaterial)
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
