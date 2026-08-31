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
        case .all: L10n.string( "search.filter.all")
        case .favorites: L10n.string( "search.filter.favorites")
        case .learned: L10n.string( "search.filter.learned")
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
