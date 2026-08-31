//
//  TravelTabView.swift
//  HanziPlus
//

import SwiftUI

struct TravelTabView: View {

    @Environment(AppTabRouter.self) private var tabRouter
    @Environment(TravelPhraseStore.self) private var phraseStore
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            TravelToolkitHubView(path: $path)
                .navigationDestination(for: TravelToolkitRoute.self) { route in
                    destination(for: route)
                }
        }
        .onChange(of: tabRouter.travelDeepLink) { _, link in
            guard let link else { return }
            applyDeepLink(link)
            tabRouter.clearTravelDeepLink()
        }
        .onAppear {
            if let link = tabRouter.travelDeepLink {
                applyDeepLink(link)
                tabRouter.clearTravelDeepLink()
            }
        }
    }

    @ViewBuilder
    private func destination(for route: TravelToolkitRoute) -> some View {
        switch route {
        case .category(let id):
            if let category = TravelPhraseCategories.category(id: id) {
                TravelCategoryView(category: category)
            } else {
                ContentUnavailableView(L10n.string("Category unavailable"), systemImage: "folder")
            }

        case .phrase(let id):
            if let phrase = TravelPhraseCatalog.phrase(id: id) {
                TravelPhraseDetailView(phrase: phrase)
            } else {
                ContentUnavailableView(L10n.string("Phrase unavailable"), systemImage: "text.bubble")
            }

        case .favorites:
            TravelPhraseListView(
                title: L10n.string("travel.favorites"),
                source: .favorites,
                emptyTitle: L10n.string("travel.favorites.empty_title"),
                emptySystemImage: "heart",
                emptyDescription: L10n.string("travel.favorites.empty_desc")
            )

        case .recent:
            TravelPhraseListView(
                title: L10n.string("travel.recent"),
                source: .recent,
                emptyTitle: L10n.string("travel.recent.empty_title"),
                emptySystemImage: "clock",
                emptyDescription: L10n.string("travel.recent.empty_desc")
            )

        case .studyWords:
            SectionedStudySetView(studySet: SampleStudySets.travel)
        }
    }

    private func applyDeepLink(_ link: TravelDeepLink) {
        path = NavigationPath()
        switch link {
        case .hub:
            break
        case .category(let id):
            path.append(TravelToolkitRoute.category(id))
        case .phrase(let id):
            path.append(TravelToolkitRoute.phrase(id))
        case .essentials:
            path.append(TravelToolkitRoute.category("essentials"))
        }
    }
}

#Preview {
    TravelTabView()
        .environment(TravelPhraseStore())
        .environment(AppTabRouter())
        .environment(LearnedWordsStore())
        .environment(StudySessionStore())
        .environmentObject(FavoritesStore())
        .environment(WordCatalog())
        .environment(JourneyStore())
        .environment(GameScoreStore())
        .environment(StatisticsStore())
        .environment(AchievementStore())
        .environment(DailyChallengeStore())
}
