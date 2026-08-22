//
//  TodayView.swift
//  HanziPlus
//

import SwiftUI

struct TodayView: View {

    @Environment(UserProfileStore.self) private var profileStore
    @Environment(StudySessionStore.self) private var sessionStore
    @Environment(GameScoreStore.self) private var scoreStore
    @Environment(DailyChallengeStore.self) private var dailyChallengeStore
    @Environment(GamesDailyProgressStore.self) private var dailyProgressStore
    @Environment(DailyLessonStore.self) private var lessonStore
    @Environment(LearnedWordsStore.self) private var learnedStore
    @Environment(AppTabRouter.self) private var tabRouter

    @State private var showSettings = false
    @State private var path = NavigationPath()

    private var profile: UserProfile { profileStore.profile }
    private var tint: Color { .orange }

    private var hero: TodayHeroContent {
        TodayPlanBuilder.hero(
            profile: profile,
            sessionStore: sessionStore,
            lessonStore: lessonStore,
            learnedStore: learnedStore
        )
    }

    private var planActions: [TodayPlanAction] {
        TodayPlanBuilder.planActions(
            profile: profile,
            sessionStore: sessionStore,
            lessonStore: lessonStore,
            learnedStore: learnedStore
        )
    }

    private var streak: Int {
        max(dailyProgressStore.progress.currentStreak, dailyChallengeStore.streakDays)
    }

    private var totalXP: Int {
        scoreStore.totalXPAllGames()
    }

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return String(localized: "today.greeting.morning")
        case 12..<17: return String(localized: "today.greeting.afternoon")
        case 17..<22: return String(localized: "today.greeting.evening")
        default: return String(localized: "today.greeting.welcome_back")
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.large) {
                    header

                    Button {
                        open(hero.destination)
                    } label: {
                        TodayHeroCard(content: hero, tint: tint)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, AppSpacing.medium)

                    planSection

                    quickActionsSection
                }
                .padding(.bottom, AppSpacing.extraLarge)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                    .accessibilityLabel(String(localized: "today.a11y.open_settings"))
                }
            }
            .navigationDestination(for: TodayDestination.self) { destination in
                TodayDestinationRouter.view(for: destination)
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                Text(greeting)
                    .font(.largeTitle.weight(.bold))
                    .accessibilityAddTraits(.isHeader)

                Text(profile.primaryGoal.title)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 10) {
                statChip(title: String(localized: "common.streak"), value: "\(streak)", icon: "flame.fill", tint: .orange)
                statChip(title: String(localized: "common.xp"), value: "\(totalXP)", icon: "sparkles", tint: .purple)
                Spacer(minLength: 0)
            }
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.top, AppSpacing.small)
    }

    private func statChip(title: String, value: String, icon: String, tint: Color) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.caption.weight(.semibold))
                .foregroundStyle(tint)

            VStack(alignment: .leading, spacing: 1) {
                Text(value)
                    .font(.subheadline.weight(.bold))
                Text(title)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background {
            Capsule(style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title) \(value)")
    }

    private var planSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("today.section.plan")
                .font(.title3.weight(.semibold))
                .padding(.horizontal, AppSpacing.medium)

            VStack(spacing: AppSpacing.small) {
                ForEach(planActions) { action in
                    Button {
                        open(action.destination)
                    } label: {
                        TodayPlanActionRow(action: action)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, AppSpacing.medium)
        }
    }

    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("today.section.quick_actions")
                .font(.title3.weight(.semibold))
                .padding(.horizontal, AppSpacing.medium)

            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ],
                spacing: 12
            ) {
                Button {
                    open(continueQuickDestination)
                } label: {
                    TodayQuickActionButton(
                        title: String(localized: "today.quick.continue_learning"),
                        icon: "play.fill",
                        tint: .blue
                    )
                }
                .buttonStyle(.plain)

                Button {
                    open(.smartReview(fileName: reviewFileName))
                } label: {
                    TodayQuickActionButton(
                        title: String(localized: "today.quick.smart_review"),
                        icon: "arrow.triangle.2.circlepath",
                        tint: .purple
                    )
                }
                .buttonStyle(.plain)

                Button {
                    open(.travelEssentials)
                } label: {
                    TodayQuickActionButton(
                        title: String(localized: "today.quick.travel_essentials"),
                        icon: "airplane",
                        tint: .orange
                    )
                }
                .buttonStyle(.plain)

                Button {
                    open(.journey)
                } label: {
                    TodayQuickActionButton(
                        title: String(localized: "today.quick.explore_china"),
                        icon: "globe.asia.australia.fill",
                        tint: .green
                    )
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, AppSpacing.medium)
        }
    }

    private var continueQuickDestination: TodayDestination {
        TodayPlanBuilder.continueDestination(profile: profile, sessionStore: sessionStore)?.destination
            ?? .study(
                fileName: TodayPlanBuilder.recommendedStudySet(for: profile).fileName,
                sectionID: nil
            )
    }

    private var reviewFileName: String {
        if case .study(let fileName, _) = continueQuickDestination {
            return fileName
        }
        return TodayPlanBuilder.recommendedStudySet(for: profile).fileName
    }

    private func open(_ destination: TodayDestination) {
        switch destination {
        case .learnTab:
            tabRouter.switchToLearn()
        case .gamesTab:
            tabRouter.switchToGames()
        case .journey:
            tabRouter.switchToJourney()
        case .travelHub:
            tabRouter.switchToTravel(deepLink: .hub)
        case .travelEssentials:
            tabRouter.switchToTravel(deepLink: .essentials)
        case .study, .smartReview, .dailyLesson:
            path.append(destination)
        }
    }
}

#Preview {
    TodayView()
        .environment(UserProfileStore())
        .environment(StudySessionStore())
        .environment(GameScoreStore())
        .environment(DailyChallengeStore())
        .environment(GamesDailyProgressStore())
        .environment(DailyLessonStore())
        .environment(AppTabRouter())
        .environmentObject(FavoritesStore())
        .environment(WordCatalog())
        .environment(LearnedWordsStore())
        .environment(SmartReviewStore())
}
