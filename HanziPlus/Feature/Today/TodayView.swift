//
//  TodayView.swift
//  HanziPlus
//

import SwiftUI

struct TodayView: View {

    @Environment(UserProfileStore.self) private var profileStore
    @Environment(StudySessionStore.self) private var sessionStore
    @Environment(DailyChallengeStore.self) private var dailyChallengeStore
    @Environment(DailyLessonStore.self) private var lessonStore
    @Environment(SmartReviewStore.self) private var smartReviewStore
    @Environment(LearnedWordsStore.self) private var learnedStore
    @Environment(JourneyStore.self) private var journeyStore
    @Environment(AppTabRouter.self) private var tabRouter
    @Environment(LanguageSettingsStore.self) private var languageStore

    @State private var showSettings = false
    @State private var showJourney = false
    @State private var path = NavigationPath()

    private var profile: UserProfile { profileStore.profile }
    private var tint: Color { .orange }

    private var hero: TodayHeroContent {
        TodayPlanBuilder.hero(
            profile: profile,
            sessionStore: sessionStore,
            lessonSession: lessonStore.todaySession,
            lessonStatus: lessonStore.status
        )
    }

    private var weakWordsCount: Int {
        AppDailyProgress.weakWordsCount(
            profile: profile,
            smartReview: smartReviewStore,
            learnedStore: learnedStore
        )
    }

    private var planActions: [TodayPlanAction] {
        TodayPlanBuilder.planActions(
            profile: profile,
            sessionStore: sessionStore,
            lessonSession: lessonStore.todaySession,
            lessonStatus: lessonStore.status,
            weakWordsCount: weakWordsCount,
            journeyCitiesCompleted: journeyStore.collectedSouvenirs.count,
            journeyCitiesTotal: JourneyCityCatalog.all.count
        )
    }

    private var lessonComplete: Bool {
        lessonStore.status == .complete
    }

    private var lessonInProgress: Bool {
        lessonStore.status == .inProgress
    }

    private var greetingKey: String.LocalizationValue {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "today.greeting.morning"
        case 12..<17: return "today.greeting.afternoon"
        case 17..<22: return "today.greeting.evening"
        default: return "today.greeting.welcome_back"
        }
    }

    var body: some View {
        let _ = languageStore.refreshToken

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

                    TodayDailyProgressCard(
                        lessonComplete: lessonComplete,
                        lessonInProgress: lessonInProgress,
                        weakWordsCount: weakWordsCount,
                        dailyTasksCompleted: dailyChallengeStore.state.completedTaskIDs.count,
                        dailyTasksTotal: dailyChallengeStore.state.tasks.count,
                        tint: tint
                    )
                    .padding(.horizontal, AppSpacing.medium)

                    planSection
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
                        Image(systemName: "globe")
                    }
                    .accessibilityLabel(L10n.string("today.a11y.open_settings"))
                }
            }
            .navigationDestination(for: TodayDestination.self) { destination in
                TodayDestinationRouter.view(for: destination)
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .fullScreenCover(isPresented: $showJourney) {
                JourneyView(showsDismissButton: true)
            }
            .onAppear {
                dailyChallengeStore.refreshIfNeeded()
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(l10n: greetingKey)
                .font(.largeTitle.weight(.bold))
                .accessibilityAddTraits(.isHeader)

            Text(profile.primaryGoal.title)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.top, AppSpacing.small)
    }

    private var planSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(l10n: "today.section.plan")
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

    private func open(_ destination: TodayDestination) {
        switch destination {
        case .learnTab:
            tabRouter.switchToLearn()
        case .gamesTab:
            tabRouter.switchToGames()
        case .journey:
            showJourney = true
        case .travelHub:
            tabRouter.switchToTravel(deepLink: .hub)
        case .travelEssentials:
            tabRouter.switchToTravel(deepLink: .essentials)
        case .study, .smartReview, .dailyLesson, .pathCourse:
            path.append(destination)
        }
    }
}

#Preview {
    TodayView()
        .environment(UserProfileStore())
        .environment(StudySessionStore())
        .environment(DailyChallengeStore())
        .environment(DailyLessonStore())
        .environment(AppTabRouter())
        .environmentObject(FavoritesStore())
        .environment(WordCatalog())
        .environment(LearnedWordsStore())
        .environment(SmartReviewStore())
        .environment(JourneyStore())
        .environment(LanguageSettingsStore())
}
