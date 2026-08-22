//
//  TravelToolkitRoute.swift
//  HanziPlus
//

import Foundation

enum TravelToolkitRoute: Hashable {
    case category(String)
    case phrase(String)
    case favorites
    case recent
    case studyWords
}
