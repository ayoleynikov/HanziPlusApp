//
//  ConfettiView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct ConfettiView: View {

    private struct Piece: Identifiable {
        let id = UUID()
        let xRatio: CGFloat
        let color: Color
        let delay: Double
        let rotation: Double
        let width: CGFloat
        let height: CGFloat
        let drift: CGFloat
    }

    @State private var pieces: [Piece] = []
    @State private var isAnimating = false

    private let colors: [Color] = [
        .green, .mint, .yellow, .orange, .blue, .purple, .pink
    ]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(pieces) { piece in
                    RoundedRectangle(cornerRadius: 1.5, style: .continuous)
                        .fill(piece.color.opacity(0.85))
                        .frame(width: piece.width, height: piece.height)
                        .rotationEffect(.degrees(isAnimating ? piece.rotation + 280 : piece.rotation))
                        .offset(
                            x: isAnimating ? piece.drift : 0,
                            y: isAnimating ? geometry.size.height + 40 : -30
                        )
                        .opacity(isAnimating ? 0 : 0.9)
                        .position(x: piece.xRatio * geometry.size.width, y: 0)
                        .animation(
                            .easeOut(duration: 2.6).delay(piece.delay),
                            value: isAnimating
                        )
                }
            }
        }
        .allowsHitTesting(false)
        .onAppear {
            spawnPieces()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                isAnimating = true
            }
        }
    }

    private func spawnPieces() {
        pieces = (0..<42).map { index in
            Piece(
                xRatio: CGFloat.random(in: 0.05...0.95),
                color: colors[index % colors.count],
                delay: Double.random(in: 0...0.45),
                rotation: Double.random(in: 0...180),
                width: CGFloat.random(in: 5...9),
                height: CGFloat.random(in: 8...14),
                drift: CGFloat.random(in: -36...36)
            )
        }
    }
}

#Preview {
    ZStack {
        Color(.systemGroupedBackground)
        ConfettiView()
    }
}
