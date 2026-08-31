//
//  JourneyCitySections.swift
//  HanziPlus
//

import SwiftUI

// MARK: - Hero

struct JourneyCityHeroCard: View {
    let city: JourneyCity
    var animateEntrance = false

    @State private var parallax: CGFloat = 0
    @State private var heroRevealed = false
    @State private var emojiPop = false

    var body: some View {
        GeometryReader { geo in
            let offset = parallax * 0.08

            ZStack(alignment: .bottomLeading) {
                JourneyCityHeroArtwork(city: city)

                RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: city.theme.heroGradient.map { $0.opacity(0.72) },
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                            .fill(
                                RadialGradient(
                                    colors: [.white.opacity(0.22), .clear],
                                    center: .topTrailing,
                                    startRadius: 20,
                                    endRadius: geo.size.width * 0.8
                                )
                            )
                            .offset(x: offset, y: -offset)
                    }

                Image(systemName: "map.fill")
                    .font(.system(size: 120, weight: .ultraLight))
                    .foregroundStyle(.white.opacity(0.08))
                    .offset(x: geo.size.width * 0.45 + offset, y: -30)

                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 12) {
                        Text(city.emoji)
                            .font(.system(size: 52))
                            .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
                            .scaleEffect(animateEntrance ? (emojiPop ? 1 : 0.2) : 1)
                            .rotationEffect(.degrees(animateEntrance && emojiPop ? 0 : -12))

                        VStack(alignment: .leading, spacing: 4) {
                            Text("🇨🇳 \(city.localizedName)")
                                .font(.title.weight(.bold))
                                .foregroundStyle(.white)
                            Text(city.localizedProvince)
                                .font(.subheadline.weight(.medium))
                                .foregroundStyle(.white.opacity(0.85))
                        }
                        .opacity(animateEntrance ? (heroRevealed ? 1 : 0) : 1)
                        .offset(x: animateEntrance ? (heroRevealed ? 0 : 16) : 0)
                    }

                    Text(city.localizedIntroduction)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.92))
                        .fixedSize(horizontal: false, vertical: true)
                        .opacity(animateEntrance ? (heroRevealed ? 1 : 0) : 1)
                        .offset(y: animateEntrance ? (heroRevealed ? 0 : 10) : 0)
                }
                .padding(AppSpacing.medium)
            }
            .frame(height: 240)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous))
            .studyCardShadow()
            .scaleEffect(animateEntrance ? (heroRevealed ? 1 : 0.94) : 1)
            .opacity(animateEntrance ? (heroRevealed ? 1 : 0.85) : 1)
            .onAppear {
                withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                    parallax = 12
                }

                guard animateEntrance else { return }
                withAnimation(.spring(response: 0.52, dampingFraction: 0.68)) {
                    heroRevealed = true
                }
                withAnimation(.spring(response: 0.45, dampingFraction: 0.55).delay(0.08)) {
                    emojiPop = true
                }
            }
        }
        .frame(height: 240)
    }
}

// MARK: - Info grid

struct JourneyCityInfoGrid: View {
    let city: JourneyCity

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: AppSpacing.small) {
            JourneyInfoTile(icon: "person.3.fill", title: L10n.string( "journey.info.population"), value: city.localizedPopulation, tint: city.theme.primary)
            JourneyInfoTile(icon: "mappin.and.ellipse", title: L10n.string( "journey.info.province"), value: city.localizedProvince, tint: city.theme.primary)
            JourneyInfoTile(icon: "star.fill", title: L10n.string( "journey.info.famous_for"), value: city.localizedFamousFor, tint: city.theme.secondary)
            JourneyInfoTile(icon: "sun.max.fill", title: L10n.string( "journey.info.best_season"), value: city.localizedBestSeason, tint: city.theme.secondary)
        }

        JourneyInfoTile(icon: "fork.knife", title: L10n.string( "journey.info.local_food"), value: city.localizedLocalFood, tint: city.theme.primary, fullWidth: true)
    }
}

struct JourneyInfoTile: View {
    let icon: String
    let title: String
    let value: String
    let tint: Color
    var fullWidth: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.caption.weight(.semibold))
                .foregroundStyle(tint)

            Text(value)
                .font(.subheadline)
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background { glassCard }
        .gridCellColumns(fullWidth ? 2 : 1)
    }

    private var glassCard: some View {
        RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
            .fill(.ultraThinMaterial)
            .overlay {
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .strokeBorder(Color.primary.opacity(0.06), lineWidth: 0.5)
            }
    }
}

// MARK: - Facts

struct JourneyFactsSection: View {
    let city: JourneyCity

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            sectionHeader(L10n.string( "journey.section.facts_title"), icon: "lightbulb.max.fill")

            ForEach(city.facts) { fact in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: fact.icon)
                        .font(.body.weight(.semibold))
                        .foregroundStyle(city.theme.primary)
                        .frame(width: 28)

                    Text(fact.localizedText)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                }
            }
        }
    }
}

// MARK: - Must Visit

struct JourneyMustVisitSection: View {
    let city: JourneyCity

    @State private var selectedPlace: JourneyAttraction?

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            sectionHeader(L10n.string("journey.section.must_visit_title"), icon: "paintpalette.fill")

            Text(l10n: "journey.section.must_visit_subtitle")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(city.attractions) { place in
                        JourneyAttractionCard(
                            place: place,
                            tint: city.theme.primary
                        ) {
                            selectedPlace = place
                        }
                    }
                }
                .padding(.horizontal, 2)
                .padding(.vertical, 4)
            }
        }
        .sheet(item: $selectedPlace) { place in
            JourneyAttractionDetailView(place: place, city: city)
        }
    }
}

struct JourneyAttractionCard: View {
    let place: JourneyAttraction
    let tint: Color
    let onTap: () -> Void

    @State private var pressed = false

    var body: some View {
        Button {
            HapticService.light()
            withAnimation(.spring(response: 0.32, dampingFraction: 0.62)) {
                pressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                    pressed = false
                }
                onTap()
            }
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                ZStack(alignment: .topLeading) {
                    JourneyAttractionArtwork(
                        style: place.visualStyle,
                        tint: tint,
                        height: 130,
                        cornerRadius: 18
                    )

                    Text(place.era.localizedLabel)
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(place.era == .modern ? .white : tint)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background {
                            Capsule()
                                .fill(
                                    place.era == .modern
                                        ? tint.opacity(0.9)
                                        : Color(.systemBackground).opacity(0.88)
                                )
                        }
                        .padding(8)
                }

                Text(place.localizedName)
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                Text(place.localizedDescription)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)

                Label(L10n.string("journey.attraction.read_more"), systemImage: "arrow.up.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(tint)
            }
            .frame(width: 220)
            .scaleEffect(pressed ? 0.96 : 1)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Vocabulary

struct JourneyVocabularySection: View {
    let city: JourneyCity

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            sectionHeader(L10n.string( "journey.section.vocab_title"), icon: "character.book.closed.fill")

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(city.vocabulary) { word in
                    VStack(spacing: 4) {
                        Text(word.hanzi)
                            .font(.title2.weight(.semibold))
                        Text(word.pinyin)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(word.localizedMeaning)
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(city.theme.primary.opacity(0.08))
                    }
                }
            }
        }
    }
}

// MARK: - Mini activity card

struct JourneyMiniActivityCard: View {
    let city: JourneyCity
    @State private var showActivity = false

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            sectionHeader(L10n.string( "journey.section.mini_activity_title"), icon: "gamecontroller.fill")

            Button {
                HapticService.medium()
                showActivity = true
            } label: {
                HStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(city.theme.primary.opacity(0.15))
                            .frame(width: 56, height: 56)
                        Image(systemName: city.miniActivity.icon)
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(city.theme.primary)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(city.localizedMiniTitle)
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(.primary)
                        Text(L10n.string("journey.mini.seconds \(25)"))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Text(city.miniActivity.targetEmoji)
                        .font(.title)

                    Image(systemName: "play.circle.fill")
                        .font(.title2)
                        .foregroundStyle(city.theme.primary)
                }
                .padding(AppSpacing.medium)
                .background {
                    RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [city.theme.primary.opacity(0.12), city.theme.secondary.opacity(0.08)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                                .strokeBorder(city.theme.primary.opacity(0.2), lineWidth: 1)
                        }
                }
            }
            .buttonStyle(GamePressButtonStyle())
        }
        .sheet(isPresented: $showActivity) {
            JourneyMiniActivityView(city: city)
        }
    }
}

// MARK: - Shared header

func sectionHeader(_ title: String, icon: String) -> some View {
    Label(title, systemImage: icon)
        .font(.title3.weight(.bold))
        .padding(.top, 4)
}

// MARK: - Travel Collection strip

struct JourneyPassportStrip: View {
    let progress: JourneyProgress

    @Environment(JourneyStore.self) private var journeyStore

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            HStack {
                Label(L10n.string( "journey.link.travel_collection"), systemImage: "rectangle.stack.fill")
                    .font(.headline.weight(.bold))
                Spacer()
                Text("\(journeyStore.collectedSouvenirs.count)/\(JourneyCityCatalog.all.count)")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(JourneyCityCatalog.all) { city in
                        let stamped = journeyStore.isCompleted(city)
                        VStack(spacing: 6) {
                            ZStack {
                                Circle()
                                    .fill(stamped ? city.theme.primary.opacity(0.15) : Color(.tertiarySystemFill))
                                    .frame(width: 52, height: 52)
                                Text(stamped ? city.travelCollectible : "⬜")
                                    .font(.title2)
                                    .grayscale(stamped ? 0 : 1)
                                    .opacity(stamped ? 1 : 0.35)
                            }
                            Text(city.localizedName)
                                .font(.caption2.weight(.medium))
                                .foregroundStyle(stamped ? .primary : .tertiary)
                                .lineLimit(1)
                        }
                        .frame(width: 64)
                    }
                }
            }
        }
        .padding(AppSpacing.medium)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                        .strokeBorder(Color.primary.opacity(0.06), lineWidth: 0.5)
                }
        }
        .studyCardShadow()
    }
}
