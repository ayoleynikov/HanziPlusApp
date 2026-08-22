//
//  JourneyPassportView.swift
//  HanziPlus
//

import SwiftUI

struct JourneyPassportView: View {

    let progress: JourneyProgress

    @Environment(JourneyStore.self) private var journeyStore
    @State private var stampingCityID: String?

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.medium) {
                passportCover

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                    ForEach(JourneyCityCatalog.all) { city in
                        passportStampCard(city: city)
                    }
                }
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.bottom, AppSpacing.extraLarge)
        }
        .background(
            LinearGradient(
                colors: [Color.blue.opacity(0.05), Color(.systemGroupedBackground)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .navigationTitle("Travel Collection")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var passportCover: some View {
        VStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 0.12, green: 0.28, blue: 0.55), Color(red: 0.2, green: 0.45, blue: 0.72)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 120)

                VStack(spacing: 8) {
                    Text("🇨🇳")
                        .font(.largeTitle)
                    Text("journey.passport.collection_header")
                        .font(.caption.weight(.heavy))
                        .tracking(2)
                        .foregroundStyle(.white.opacity(0.9))
                }
            }

            Text("journey.passport.title")
                .font(.title3.weight(.bold))

            Text("\(journeyStore.collectedSouvenirs.count) of \(JourneyCityCatalog.all.count) collectibles collected")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(AppSpacing.large)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .fill(.ultraThinMaterial)
        }
        .studyCardShadow()
    }

    private func passportStampCard(city: JourneyCity) -> some View {
        let record = journeyStore.completion(for: city.id)
        let stamped = record != nil
        let isAnimating = stampingCityID == city.id

        return VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(stamped ? city.theme.primary.opacity(0.12) : Color(.tertiarySystemFill))
                    .frame(width: 64, height: 64)

                Circle()
                    .strokeBorder(
                        stamped ? city.theme.primary.opacity(0.5) : Color.primary.opacity(0.08),
                        lineWidth: 2
                    )
                    .frame(width: 64, height: 64)

                Text(stamped ? city.travelCollectible : "⬜")
                    .font(.title)
                    .grayscale(stamped ? 0 : 1)
                    .opacity(stamped ? 1 : 0.3)
                    .scaleEffect(isAnimating ? 1.2 : 1)
                    .rotationEffect(.degrees(isAnimating ? -12 : 0))
            }

            Text(city.localizedName)
                .font(.caption.weight(.semibold))
                .lineLimit(1)

            if let record {
                Text(record.completedAt.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            } else {
                Text("journey.passport.not_discovered")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .onAppear {
            if stamped {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.6).delay(0.1)) {
                    stampingCityID = city.id
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    stampingCityID = nil
                }
            }
        }
    }
}
