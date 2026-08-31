//
//  GamesPlayerProfileSection.swift
//  HanziPlus
//

import SwiftUI

struct GamesPlayerProfileSection: View {

    let gamesPlayed: Int
    let accuracy: Int

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(l10n: "common.player")
                .font(.title2.weight(.bold))
                .padding(.horizontal, AppSpacing.medium)

            VStack(spacing: AppSpacing.medium) {
                HStack(spacing: AppSpacing.small) {
                    statTile(
                        title: L10n.string("games.stat.played"),
                        value: "\(gamesPlayed)",
                        icon: "gamecontroller.fill",
                        tint: .green
                    )
                    statTile(
                        title: L10n.string("games.stat.accuracy"),
                        value: L10n.percent(accuracy),
                        icon: "target",
                        tint: .mint
                    )
                }
                .padding(.horizontal, AppSpacing.medium)

                HStack(spacing: 12) {
                    NavigationLink {
                        GamesAchievementsView()
                    } label: {
                        profileLinkCard(
                            title: L10n.string("Achievements"),
                            icon: "trophy.fill",
                            tint: .orange
                        )
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        GamesCompletedView(gamesCompleted: gamesPlayed)
                    } label: {
                        profileLinkCard(
                            title: L10n.string("Games Completed"),
                            icon: "checkmark.circle.fill",
                            tint: .green
                        )
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, AppSpacing.medium)
            }
        }
    }

    private func profileLinkCard(title: String, icon: String, tint: Color) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.body.weight(.semibold))
                .foregroundStyle(tint)

            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
    }

    private func statTile(title: String, value: String, icon: String, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .font(.body.weight(.semibold))
                .foregroundStyle(tint)
            Text(value)
                .font(.title3.weight(.bold))
            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
    }
}
