//
//  JourneyAttractionDetailView.swift
//  HanziPlus
//

import SwiftUI

struct JourneyAttractionDetailView: View {
    let place: JourneyAttraction
    let city: JourneyCity

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.large) {
                    JourneyAttractionArtwork(
                        style: place.visualStyle,
                        tint: city.theme.primary,
                        height: 220,
                        cornerRadius: AppRadius.studyCard
                    )
                    .studyCardShadow()

                    VStack(alignment: .leading, spacing: AppSpacing.small) {
                        HStack(spacing: 8) {
                            eraBadge

                            Text(place.emoji)
                                .font(.title2)
                        }

                        Text(place.localizedName)
                            .font(.title.weight(.bold))

                        Text(place.localizedDescription)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }

                    detailSection

                    tipSection
                }
                .padding(AppSpacing.medium)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(place.localizedName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(L10n.string("common.done")) {
                        dismiss()
                    }
                }
            }
        }
    }

    private var eraBadge: some View {
        Text(place.era.localizedLabel)
            .font(.caption.weight(.bold))
            .foregroundStyle(place.era == .modern ? .white : city.theme.primary)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background {
                Capsule()
                    .fill(
                        place.era == .modern
                            ? city.theme.primary
                            : city.theme.primary.opacity(0.14)
                    )
            }
    }

    private var detailSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(L10n.string("journey.attraction.about"), systemImage: "text.book.closed.fill")
                .font(.headline.weight(.bold))
                .foregroundStyle(city.theme.primary)

            Text(place.localizedDetail)
                .font(.subheadline)
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(AppSpacing.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background { sectionCard }
    }

    private var tipSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(L10n.string("journey.attraction.tip_title"), systemImage: "lightbulb.fill")
                .font(.headline.weight(.bold))
                .foregroundStyle(city.theme.secondary)

            Text(place.localizedTip)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(AppSpacing.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background { sectionCard }
    }

    private var sectionCard: some View {
        RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
            .fill(Color(.secondarySystemGroupedBackground))
            .overlay {
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .strokeBorder(Color.primary.opacity(0.06), lineWidth: 0.5)
            }
    }
}
