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
                ContentUnavailableView("Category unavailable", systemImage: "folder")
            }

        case .phrase(let id):
            if let phrase = TravelPhraseCatalog.phrase(id: id) {
                TravelPhraseDetailView(phrase: phrase)
            } else {
                ContentUnavailableView("Phrase unavailable", systemImage: "text.bubble")
            }

        case .favorites:
            TravelPhraseListView(
                title: "Favorites",
                source: .favorites,
                emptyTitle: "No favorites yet",
                emptySystemImage: "heart",
                emptyDescription: "Heart a phrase to keep it ready offline."
            )

        case .recent:
            TravelPhraseListView(
                title: "Recently Used",
                source: .recent,
                emptyTitle: "No recent phrases",
                emptySystemImage: "clock",
                emptyDescription: "Opened or played phrases will appear here."
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
}
