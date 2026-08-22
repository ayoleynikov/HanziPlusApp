//
//  CityLockedSheet.swift
//  HanziPlus
//

import SwiftUI

struct CityLockedSheet: View {

    let city: JourneyCity
    let progress: JourneyProgress

    @Environment(\.dismiss) private var dismiss
    @Environment(AppTabRouter.self) private var tabRouter

    private var evaluations: [RequirementEvaluation] {
        city.requirements.evaluations(for: progress, dailyStreak: progress.dailyStreak)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppSpacing.large) {
                    header

                    requirementsSection

                    Text("Keep learning to unlock your next destination.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, AppSpacing.medium)

                    actionButtons
                }
                .padding(.horizontal, AppSpacing.medium)
                .padding(.bottom, AppSpacing.extraLarge)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") { dismiss() }
                        .font(.subheadline.weight(.semibold))
                }
            }
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }

    private var header: some View {
        VStack(spacing: AppSpacing.small) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [city.theme.primary.opacity(0.2), city.theme.secondary.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 96, height: 96)

                Text(city.travelCollectible)
                    .font(.system(size: 40))
                    .grayscale(1)
                    .opacity(0.35)

                Image(systemName: "lock.fill")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            .padding(.top, AppSpacing.small)

            Text("Destination Locked")
                .font(.title2.weight(.bold))

            Text("Complete requirements to unlock \(city.name).")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    private var requirementsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            Text("Requirements")
                .font(.headline.weight(.semibold))

            if evaluations.isEmpty {
                Text("Complete the previous city to continue your journey.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                ForEach(evaluations) { evaluation in
                    RequirementRowView(evaluation: evaluation, tint: city.accentColor)
                }
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
        VStack(spacing: AppSpacing.small) {
            Button {
                dismiss()
                tabRouter.switchToStudy()
            } label: {
                Text("Continue Learning")
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Capsule().fill(city.accentColor))
                    .foregroundStyle(.white)
            }
            .buttonStyle(GamePressButtonStyle())

            Button {
                dismiss()
                tabRouter.switchToGames()
            } label: {
                Text("Play Games")
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background {
                        Capsule().fill(Color(.secondarySystemGroupedBackground))
                    }
                    .foregroundStyle(.primary)
            }
            .buttonStyle(GamePressButtonStyle())

            Button("Close") { dismiss() }
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
                .padding(.top, 4)
        }
    }
}

struct RequirementRowView: View {
    let evaluation: RequirementEvaluation
    let tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                Text(evaluation.statusIcon)
                    .font(.body)

                Text(evaluation.title)
                    .font(.subheadline.weight(.medium))

                Spacer()

                if let label = evaluation.progressLabel {
                    Text(label)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .monospacedDigit()
                }
            }

            if evaluation.showsProgress || (!evaluation.isComplete && evaluation.fraction > 0) {
                AnimatedProgressBar(progress: evaluation.fraction, tint: tint, height: 5)
            }
        }
    }
}

#Preview {
    CityLockedSheet(
        city: JourneyCityCatalog.all[3],
        progress: JourneyProgress(
            learnedWords: 120,
            totalXP: 2450,
            gamesPlayed: 12,
            accuracy: 68,
            hsk1Learned: 100,
            hsk1Total: 150,
            hsk2Learned: 0,
            hsk2Total: 150,
            dailyStreak: 2
        )
    )
    .environment(AppTabRouter())
}
