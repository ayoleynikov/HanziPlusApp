//
//  SearchWordFilter.swift
//  HanziPlus
//

import Foundation

enum SearchWordFilter: String, CaseIterable, Identifiable {
    case all
    case favorites
    case learned

    var id: String { rawValue }

    var title: String {
        switch self {
        case .all: String(localized: "search.filter.all")
        case .favorites: String(localized: "search.filter.favorites")
        case .learned: String(localized: "search.filter.learned")
        }
    }

    var icon: String {
        switch self {
        case .all: "text.book.closed"
        case .favorites: "heart.fill"
        case .learned: "checkmark.circle.fill"
        }
    }
}
