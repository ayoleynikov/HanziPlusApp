//
//  CityDetailView.swift
//  HanziPlus
//

import SwiftUI

struct CityDetailView: View {

    let city: JourneyCity
    let progress: JourneyProgress

    @Environment(JourneyStore.self) private var journeyStore
    @Environment(AppTabRouter.self) private var tabRouter

    private var isCompleted: Bool { journeyStore.isCompleted(city) }
    private var fraction: Double { journeyStore.progressFraction(for: city, progress: progress) }

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.large) {
                JourneyCityHeroCard(city: city)

                progressSection

                JourneyCityInfoGrid(city: city)

                achievementBadge

                JourneyFactsSection(city: city)

                JourneyMustVisitSection(city: city)

                JourneyVocabularySection(city: city)

                JourneyMiniActivityCard(city: city)

                souvenirCard

                if !isCompleted {
                    requirementsCard
                }

                actionButtons
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
        .navigationTitle(city.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Chapter Progress")
                    .font(.headline.weight(.semibold))
                Spacer()
                if isCompleted {
                    Label("Complete", systemImage: "checkmark.seal.fill")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(city.theme.primary)
                }
            }

            HStack(spacing: AppSpacing.medium) {
                metric("XP", "\(progress.totalXP)")
                metric("Words", "\(progress.learnedWords)")
                metric("Games", "\(progress.gamesPlayed)")
                metric("Done", "\(Int(fraction * 100))%")
            }

            AnimatedProgressBar(progress: fraction, tint: city.theme.primary, height: 7)
        }
        .padding(AppSpacing.medium)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(.ultraThinMaterial)
        }
        .studyCardShadow()
    }

    private func metric(_ title: String, _ value: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.subheadline.weight(.bold))
            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    private var achievementBadge: some View {
        HStack(spacing: 12) {
            Image(systemName: "medal.fill")
                .font(.title2)
                .foregroundStyle(city.theme.secondary)

            VStack(alignment: .leading, spacing: 4) {
                Text("City Badge")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                Text(city.localAchievement)
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
                Text("Souvenir")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                Text(city.souvenirName)
                    .font(.headline.weight(.semibold))

                if isCompleted, let record = journeyStore.completion(for: city.id) {
                    Text("Collected \(record.completedAt.formatted(date: .abbreviated, time: .omitted))")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                } else {
                    Text("Complete this chapter to collect")
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

    private var requirementsCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("Unlock Requirements")
                .font(.headline.weight(.semibold))

            ForEach(city.requirements.evaluations(for: progress, dailyStreak: progress.dailyStreak)) { evaluation in
                RequirementRowView(evaluation: evaluation, tint: city.theme.primary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(AppSpacing.medium)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
    }

    private var actionButtons: some View {
        VStack(spacing: 12) {
            Button {
                tabRouter.switchToStudy()
            } label: {
                Text("Continue Learning")
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Capsule().fill(city.theme.primary))
                    .foregroundStyle(.white)
            }
            .buttonStyle(GamePressButtonStyle())

            Button {
                tabRouter.switchToGames()
            } label: {
                Text("Play Games")
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
