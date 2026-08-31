//
//  CityDetailView.swift
//  HanziPlus
//

import SwiftUI

struct CityDetailView: View {

    let city: JourneyCity
    let progress: JourneyProgress
    var onDismissPresentation: (() -> Void)? = nil

    @Environment(JourneyStore.self) private var journeyStore
    @Environment(AppTabRouter.self) private var tabRouter

    @State private var contentRevealed = false

    private var isCompleted: Bool { journeyStore.isCompleted(city) }

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.large) {
                JourneyCityHeroCard(city: city, animateEntrance: true)

                Group {
                    achievementBadge

                    JourneyCityInfoGrid(city: city)

                    JourneyFactsSection(city: city)

                    JourneyMustVisitSection(city: city)

                    JourneyVocabularySection(city: city)

                    JourneyMiniActivityCard(city: city)

                    souvenirCard

                    actionButtons
                }
                .opacity(contentRevealed ? 1 : 0)
                .offset(y: contentRevealed ? 0 : 18)
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.bottom, AppSpacing.extraLarge)
        }
        .background(
            LinearGradient(
                colors: [city.theme.primary.opacity(0.04), Color(.systemGroupedBackground)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .navigationTitle(city.localizedName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            let isFirstVisit = !journeyStore.isCompleted(city)
            journeyStore.markVisited(city)

            if isFirstVisit {
                HapticService.success()
            } else {
                HapticService.light()
            }

            withAnimation(.spring(response: 0.58, dampingFraction: 0.82)) {
                contentRevealed = true
            }
        }
    }

    private var achievementBadge: some View {
        HStack(spacing: 12) {
            Image(systemName: "medal.fill")
                .font(.title2)
                .foregroundStyle(city.theme.secondary)

            VStack(alignment: .leading, spacing: 4) {
                Text(l10n: "journey.detail.city_badge")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                Text(city.localizedAchievementName)
                    .font(.headline.weight(.semibold))
            }

            Spacer()

            if isCompleted {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(city.theme.primary)
            }
        }
        .padding(AppSpacing.medium)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(city.theme.primary.opacity(0.08))
        }
    }

    private var souvenirCard: some View {
        HStack(spacing: 16) {
            Text(city.souvenirEmoji)
                .font(.system(size: 44))

            VStack(alignment: .leading, spacing: 4) {
                Text(l10n: "journey.detail.souvenir")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                Text(city.localizedSouvenirName)
                    .font(.headline.weight(.semibold))

                if isCompleted, let record = journeyStore.completion(for: city.id) {
                    Text(L10n.string("journey.detail.collected_on \(L10n.abbreviatedDate(record.completedAt))"))
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }
            }

            Spacer()

            if isCompleted {
                Text(city.travelCollectible)
                    .font(.title)
            }
        }
        .padding(AppSpacing.medium)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
    }

    private var actionButtons: some View {
        VStack(spacing: 12) {
            Button {
                onDismissPresentation?()
                tabRouter.switchToStudy()
            } label: {
                Text(l10n: "journey.cta.continue_learning")
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Capsule().fill(city.theme.primary))
                    .foregroundStyle(.white)
            }
            .buttonStyle(GamePressButtonStyle())

            Button {
                onDismissPresentation?()
                tabRouter.switchToGames()
            } label: {
                Text(l10n: "journey.cta.play_games")
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Capsule().strokeBorder(city.theme.primary.opacity(0.35), lineWidth: 1.5))
                    .foregroundStyle(city.theme.primary)
            }
            .buttonStyle(GamePressButtonStyle())
        }
    }
}
