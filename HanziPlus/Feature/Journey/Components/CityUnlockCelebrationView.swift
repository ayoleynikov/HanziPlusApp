//
//  CityUnlockCelebrationView.swift
//  HanziPlus
//

import SwiftUI

struct CityUnlockCelebrationView: View {

    let city: JourneyCity
    var isJourneyComplete: Bool = false
    let onDismiss: () -> Void

    @State private var lockScale: CGFloat = 1
    @State private var lockOpacity: Double = 1
    @State private var contentOpacity: Double = 0
    @State private var contentOffset: CGFloat = 30
    @State private var cityScale: CGFloat = 0.6
    @State private var routeGlow = false
    @State private var planeOffset: CGFloat = -100
    @State private var stampScale: CGFloat = 0.3
    @State private var showConfetti = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture { onDismiss() }

            JourneyConfettiView(isActive: showConfetti)

            VStack(spacing: AppSpacing.large) {
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [city.theme.primary.opacity(routeGlow ? 0.4 : 0.12), .clear],
                                center: .center,
                                startRadius: 20,
                                endRadius: routeGlow ? 130 : 70
                            )
                        )
                        .frame(width: 240, height: 240)
                        .animation(.easeInOut(duration: 1.2).repeatCount(2, autoreverses: true), value: routeGlow)

                    Image(systemName: "airplane")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(city.theme.primary)
                        .rotationEffect(.degrees(45))
                        .offset(x: planeOffset, y: -20)
                        .opacity(routeGlow ? 1 : 0)

                    Text(city.travelCollectible)
                        .font(.system(size: 56))
                        .scaleEffect(stampScale)
                        .rotationEffect(.degrees(stampScale > 0.8 ? -8 : 0))
                        .opacity(routeGlow ? 1 : 0)

                    Text(city.emoji)
                        .font(.system(size: 72))
                        .scaleEffect(cityScale)
                        .grayscale(routeGlow ? 0 : 0.85)

                    Image(systemName: "lock.fill")
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .scaleEffect(lockScale)
                        .opacity(lockOpacity)
                }
                .frame(height: 190)

                VStack(spacing: 10) {
                    Text(isJourneyComplete
                         ? String(localized: "journey.celebration.complete_title")
                         : String(localized: "journey.celebration.unlock_title"))
                        .font(.title2.weight(.bold))
                        .multilineTextAlignment(.center)

                    Text(isJourneyComplete
                         ? String(localized: "journey.celebration.explored_all")
                         : String(localized: "journey.celebration.welcome \(city.localizedName)"))
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(city.theme.primary)
                        .multilineTextAlignment(.center)

                    if !isJourneyComplete {
                        Text(String(localized: "journey.celebration.collectible \(city.travelCollectible)"))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .opacity(contentOpacity)
                .offset(y: contentOffset)

                Button(action: onDismiss) {
                    Text(isJourneyComplete ? String(localized: "journey.celebration.continue") : String(localized: "journey.celebration.explore \(city.localizedName)"))
                        .font(.body.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Capsule().fill(city.theme.primary))
                        .foregroundStyle(.white)
                }
                .buttonStyle(GamePressButtonStyle())
                .opacity(contentOpacity)
                .padding(.horizontal, AppSpacing.medium)
            }
            .padding(AppSpacing.large)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                    .fill(.ultraThinMaterial)
            }
            .padding(.horizontal, AppSpacing.medium)
            .studyCardShadow()
        }
        .onAppear {
            HapticService.success()
            SoundService.success()
            showConfetti = true
            playAnimation()
        }
    }

    private func playAnimation() {
        withAnimation(.spring(response: 0.45, dampingFraction: 0.62)) {
            lockScale = 1.25
        }

        withAnimation(.easeOut(duration: 0.35).delay(0.25)) {
            lockOpacity = 0
            lockScale = 0.6
        }

        withAnimation(.spring(response: 0.62, dampingFraction: 0.68).delay(0.35)) {
            cityScale = 1
            routeGlow = true
        }

        withAnimation(.spring(response: 0.55, dampingFraction: 0.72).delay(0.45)) {
            contentOpacity = 1
            contentOffset = 0
        }

        withAnimation(.spring(response: 0.7, dampingFraction: 0.72).delay(0.5)) {
            planeOffset = 100
        }

        withAnimation(.spring(response: 0.45, dampingFraction: 0.58).delay(0.75)) {
            stampScale = 1
        }
    }
}

#Preview {
    CityUnlockCelebrationView(city: JourneyCityCatalog.all[3], onDismiss: {})
}
