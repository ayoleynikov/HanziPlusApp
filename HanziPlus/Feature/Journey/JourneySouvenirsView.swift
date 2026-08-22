//
//  JourneySouvenirsView.swift
//  HanziPlus
//

import SwiftUI

struct JourneySouvenirsView: View {

    @Environment(JourneyStore.self) private var journeyStore

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            if journeyStore.collectedSouvenirs.isEmpty {
                ContentUnavailableView(
                    "No Souvenirs Yet",
                    systemImage: "gift",
                    description: Text("Complete cities on your journey to collect souvenirs.")
                )
                .padding(.top, 80)
            } else {
                LazyVGrid(columns: columns, spacing: AppSpacing.medium) {
                    ForEach(JourneyCityCatalog.all) { city in
                        souvenirTile(city: city)
                    }
                }
                .padding(.horizontal, AppSpacing.medium)
                .padding(.bottom, AppSpacing.extraLarge)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Souvenirs")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func souvenirTile(city: JourneyCity) -> some View {
        let collected = journeyStore.completion(for: city.id) != nil

        return VStack(spacing: 12) {
            Text(city.souvenirEmoji)
                .font(.system(size: 48))
                .grayscale(collected ? 0 : 1)
                .opacity(collected ? 1 : 0.25)

            Text(city.souvenirName)
                .font(.subheadline.weight(.semibold))
                .multilineTextAlignment(.center)

            Text(city.name)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppSpacing.medium)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
                .overlay {
                    if collected {
                        RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                            .strokeBorder(city.accentColor.opacity(0.25), lineWidth: 1)
                    }
                }
        }
        .studyCardShadow()
    }
}
