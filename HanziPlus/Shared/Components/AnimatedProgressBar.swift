//
//  AnimatedProgressBar.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct AnimatedProgressBar: View {

    let progress: Double
    var tint: Color = .primary
    var height: CGFloat = 4

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(tint.opacity(0.12))
                    .frame(height: height)

                Capsule()
                    .fill(tint.opacity(0.72))
                    .frame(width: max(height, geometry.size.width * min(max(progress, 0), 1)), height: height)
                    .animation(.spring(response: 0.45, dampingFraction: 0.86), value: progress)
            }
        }
        .frame(height: height)
    }
}

#Preview {
    VStack(spacing: 20) {
        AnimatedProgressBar(progress: 0.35)
        AnimatedProgressBar(progress: 0.72, tint: .blue)
    }
    .padding()
}
