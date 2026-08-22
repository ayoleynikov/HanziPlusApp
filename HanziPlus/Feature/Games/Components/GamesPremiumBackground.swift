//
//  GamesPremiumBackground.swift
//  HanziPlus
//

import SwiftUI

struct GamesPremiumBackground: View {

    var tint: Color = .indigo
    var secondaryTint: Color = .purple

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)

            LinearGradient(
                colors: [
                    tint.opacity(0.07),
                    Color(.systemGroupedBackground),
                    secondaryTint.opacity(0.04)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            RadialGradient(
                colors: [tint.opacity(0.08), .clear],
                center: .topTrailing,
                startRadius: 20,
                endRadius: 380
            )
        }
        .ignoresSafeArea()
    }
}
