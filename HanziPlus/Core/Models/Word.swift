//
//  Word.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import Foundation

struct Word: Identifiable, Codable {

    var id: String { hanzi }
    let hanzi: String
    let pinyin: String
    let english: String
    let examples: [Example]
    let section: String?

    var translation: String {
        english
    }

    private enum CodingKeys: String, CodingKey {
        case hanzi
        case pinyin
        case english
        case examples
        case section
    }

}
