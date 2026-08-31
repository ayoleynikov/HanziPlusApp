//
//  AppTabRouter.swift
//  HanziPlus
//

import Foundation
import Observation

enum AppTab: Int, Hashable, CaseIterable {
    case today = 0
    case learn = 1
    case travel = 2
    case games = 3
}

enum TravelDeepLink: Equatable {
    case hub
    case essentials
    case category(String)
    case phrase(String)
}

@Observable
final class AppTabRouter {
    var selectedTab: AppTab = .today
    var travelDeepLink: TravelDeepLink?

    func switchToToday() {
        selectedTab = .today
    }

    func switchToLearn() {
        selectedTab = .learn
    }

    /// Legacy alias used by Journey unlock sheets.
    func switchToStudy() {
        switchToLearn()
    }

    func switchToTravel(deepLink: TravelDeepLink = .hub) {
        travelDeepLink = deepLink
        selectedTab = .travel
    }

    func clearTravelDeepLink() {
        travelDeepLink = nil
    }

    func switchToGames() {
        selectedTab = .games
    }

}
