//
//  SearchWordFilter.swift
//  HanziPlus
//

import Foundation

enum SearchWordFilter: String, CaseIterable, Identifiable {
    case all = "All Words"
    case favorites = "Favorites"
    case learned = "Learned"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .all: "text.book.closed"
        case .favorites: "heart.fill"
        case .learned: "checkmark.circle.fill"
        }
    }
}
