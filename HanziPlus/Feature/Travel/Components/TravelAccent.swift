//
//  TravelAccent.swift
//  HanziPlus
//

import SwiftUI

enum TravelAccent {
    static func color(named name: String) -> Color {
        switch name {
        case "blue": .blue
        case "green": .green
        case "purple": .purple
        case "red": .red
        case "indigo": .indigo
        case "teal": .teal
        case "cyan": .cyan
        case "pink": .pink
        default: .orange
        }
    }
}
