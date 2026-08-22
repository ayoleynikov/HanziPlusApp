//
//  AppShadow.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

enum AppShadow {

    static let color = Color.black.opacity(0.08)
    static let radius: CGFloat = 18
    static let y: CGFloat = 8

    static let studyCardPrimary = Color.black.opacity(0.06)
    static let studyCardSecondary = Color.black.opacity(0.03)
}

extension View {

    func studyCardShadow() -> some View {
        shadow(color: AppShadow.studyCardSecondary, radius: 24, x: 0, y: 12)
            .shadow(color: AppShadow.studyCardPrimary, radius: 8, x: 0, y: 4)
    }
}
