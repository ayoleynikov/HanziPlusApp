//
//  JourneyConfettiView.swift
//  HanziPlus
//

import SwiftUI

struct JourneyConfettiView: View {
    @State private var particles: [ConfettiParticle] = []
    let isActive: Bool

    var body: some View {
        TimelineView(.animation(minimumInterval: 1 / 30)) { timeline in
            Canvas { context, size in
                let now = timeline.date.timeIntervalSinceReferenceDate
                for particle in particles {
                    let age = now - particle.birth
                    guard age >= 0, age < particle.lifetime else { continue }

                    let progress = age / particle.lifetime
                    let x = particle.origin.x + particle.velocity.x * age
                    let y = particle.origin.y + particle.velocity.y * age + 120 * age * age
                    let opacity = 1 - progress

                    var resolved = context.resolve(
                        Text(particle.symbol).font(.system(size: particle.size))
                    )
                    resolved.shading = .color(particle.color.opacity(opacity))
                    context.draw(resolved, at: CGPoint(x: x, y: y))
                }
            }
        }
        .allowsHitTesting(false)
        .onChange(of: isActive) { _, active in
            if active { spawn() }
        }
        .onAppear {
            if isActive { spawn() }
        }
    }

    private func spawn() {
        let symbols = ["✦", "●", "▲", "♦", "★"]
        let colors: [Color] = [.yellow, .orange, .pink, .cyan, .mint, .purple]
        particles = (0..<48).map { index in
            ConfettiParticle(
                symbol: symbols[index % symbols.count],
                color: colors[index % colors.count],
                origin: CGPoint(x: CGFloat.random(in: 40...350), y: -20),
                velocity: CGPoint(x: CGFloat.random(in: -40...40), y: CGFloat.random(in: 80...180)),
                size: CGFloat.random(in: 8...14),
                birth: Date.timeIntervalSinceReferenceDate + Double(index) * 0.02,
                lifetime: Double.random(in: 1.8...2.8)
            )
        }
    }
}

private struct ConfettiParticle {
    let symbol: String
    let color: Color
    let origin: CGPoint
    let velocity: CGPoint
    let size: CGFloat
    let birth: TimeInterval
    let lifetime: TimeInterval
}
