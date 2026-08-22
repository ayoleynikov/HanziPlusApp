//
//  GamesPlayerProfileSection.swift
//  HanziPlus
//

import SwiftUI

struct GamesPlayerProfileSection: View {

    let totalXP: Int
    let todayXP: Int
    let weeklyXP: Int
    let streak: Int
    let gamesPlayed: Int
    let accuracy: Int

    private var level: Int { GamesPlayerLevel.level(totalXP: totalXP) }
    private var levelProgress: Double { GamesPlayerLevel.progress(totalXP: totalXP) }

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("common.player")
                .font(.title2.weight(.bold))
                .padding(.horizontal, AppSpacing.medium)

            VStack(spacing: AppSpacing.medium) {
                levelCard

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: AppSpacing.small) {
                        statRing(title: "Today's XP", value: "\(todayXP)", progress: min(Double(todayXP) / 400, 1), tint: .purple)
                        statRing(title: "Weekly XP", value: "\(weeklyXP)", progress: min(Double(weeklyXP) / 1500, 1), tint: .blue)
                        statTile(title: "Streak", value: "\(streak)", icon: "flame.fill", tint: .orange)
                        statTile(title: String(localized: "games.stat.played"), value: "\(gamesPlayed)", icon: "gamecontroller.fill", tint: .green)
                        statTile(title: "Accuracy", value: "\(accuracy)%", icon: "target", tint: .mint)
                    }
                    .padding(.horizontal, AppSpacing.medium)
                }
            }
        }
    }

    private var levelCard: some View {
        HStack(spacing: 20) {
            ZStack {
                Circle()
                    .stroke(Color.purple.opacity(0.15), lineWidth: 8)
                    .frame(width: 72, height: 72)

                Circle()
                    .trim(from: 0, to: levelProgress)
                    .stroke(
                        LinearGradient(colors: [.purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .frame(width: 72, height: 72)
                    .rotationEffect(.degrees(-90))

                VStack(spacing: 0) {
                    Text("\(level)")
                        .font(.title2.weight(.bold))
                    Text("LVL")
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(.secondary)
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(String(localized: "common.level_n \(level)"))
                    .font(.headline.weight(.bold))

                Text("\(totalXP) XP total")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text("\(GamesPlayerLevel.xpInCurrentLevel(totalXP: totalXP)) / 300 to next level")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }

            Spacer(minLength: 0)
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
        .padding(.horizontal, AppSpacing.medium)
    }

    private func statRing(title: String, value: String, progress: Double, tint: Color) -> some View {
        VStack(spacing: 10) {
            ZStack {
                Circle().stroke(tint.opacity(0.15), lineWidth: 5).frame(width: 52, height: 52)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(tint, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    .frame(width: 52, height: 52)
                    .rotationEffect(.degrees(-90))
                Text(value)
                    .font(.caption.weight(.bold))
            }
            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(width: 100)
        .padding(.vertical, 14)
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
        .frame(width: 100, alignment: .leading)
        .padding(14)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
    }
}
