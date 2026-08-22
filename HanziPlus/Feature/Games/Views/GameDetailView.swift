//
//  GameDetailView.swift
//  HanziPlus
//

import SwiftUI

struct GameDetailView: View {

    let game: GameDefinition

    @State private var difficulty: GameDifficulty
    @State private var memoryMode: MemoryMatchMode = .chineseEnglish
    @State private var showStudySetPicker = false
    @State private var appeared = false

    @Environment(GameScoreStore.self) private var scoreStore
    @Environment(AchievementStore.self) private var achievementStore

    init(game: GameDefinition) {
        self.game = game
        _difficulty = State(initialValue: game.difficulty)
    }

    private var stats: GameStatistics {
        scoreStore.statistics(for: game.kind)
    }

    private var relatedAchievements: [Achievement] {
        achievementStore.achievements.filter { achievement in
            switch game.kind {
            case .listeningQuiz: achievement.id.contains("listening")
            case .typingChallenge: achievement.id.contains("typing")
            case .hanziMemory: achievement.id.contains("memory")
            default: achievement.id.contains("game") || achievement.id.contains("correct")
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                CinematicGameArtwork(game: game, height: 300, cornerRadius: AppRadius.studyCard)
                    .padding(.horizontal, AppSpacing.medium)
                    .scaleEffect(appeared ? 1 : 0.95)
                    .opacity(appeared ? 1 : 0)

                VStack(alignment: .leading, spacing: AppSpacing.medium) {
                    headerSection
                    benefitsSection
                    statsSection

                    if !relatedAchievements.isEmpty {
                        achievementsSection
                    }

                    if game.kind == .hanziMemory {
                        modeSection
                    }

                    difficultySection
                    personalStatsSection
                    startButton
                }
                .padding(.horizontal, AppSpacing.medium)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 16)
            }
            .padding(.bottom, AppSpacing.extraLarge)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(game.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showStudySetPicker) {
            studySetDestination
        }
        .onAppear {
            withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                appeared = true
            }
        }
    }

    @ViewBuilder
    private var studySetDestination: some View {
        switch game.kind {
        case .dailyChallenge:
            DailyChallengeView()
        default:
            GameStudySetPickerView(
                game: game,
                difficulty: difficulty,
                memoryMode: game.kind == .hanziMemory ? memoryMode : nil
            )
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(game.emoji) \(game.title)")
                .font(.largeTitle.weight(.bold))

            Text(game.description)
                .font(.body)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var benefitsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Benefits")
                .font(.title3.weight(.semibold))

            ForEach(game.benefits, id: \.self) { benefit in
                Label {
                    Text(benefit)
                        .font(.subheadline)
                } icon: {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(game.color)
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(sectionBackground)
    }

    private var statsSection: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: AppSpacing.small) {
            detailChip(title: "Difficulty", value: game.difficulty.label, tint: game.difficulty.color)
            detailChip(title: "Est. Time", value: game.estimatedTimeLabel, tint: .blue)
            detailChip(title: "XP Reward", value: game.xpRewardLabel, tint: .purple)
            detailChip(title: "Best Score", value: stats.bestScore > 0 ? "\(stats.bestScore)" : "—", tint: .orange)
        }
    }

    private var achievementsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Achievements")
                .font(.title3.weight(.semibold))

            ForEach(relatedAchievements.prefix(4)) { achievement in
                HStack(spacing: 12) {
                    Image(systemName: achievement.icon)
                        .foregroundStyle(achievement.isUnlocked ? .orange : .secondary)
                        .frame(width: 28)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(achievement.title)
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(achievement.isUnlocked ? .primary : .secondary)
                        Text(achievement.description)
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }

                    Spacer()

                    if achievement.isUnlocked {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(.orange)
                    }
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(sectionBackground)
    }

    private var modeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Mode Selection")
                .font(.title3.weight(.semibold))

            VStack(spacing: 8) {
                ForEach(MemoryMatchMode.allCases.filter(\.isAvailable)) { mode in
                    modeRow(mode)
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(sectionBackground)
    }

    private func modeRow(_ mode: MemoryMatchMode) -> some View {
        Button {
            memoryMode = mode
            HapticService.light()
        } label: {
            HStack {
                Text(mode.label)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.primary)

                Spacer()

                if memoryMode == mode {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(game.color)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(memoryMode == mode ? game.color.opacity(0.12) : Color(.tertiarySystemFill).opacity(0.5))
            }
        }
        .buttonStyle(.plain)
    }

    private var difficultySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Difficulty Selection")
                .font(.title3.weight(.semibold))

            GameDifficultyPicker(difficulty: $difficulty)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(sectionBackground)
    }

    private var personalStatsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your Statistics")
                .font(.title3.weight(.semibold))

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                statTile("Played", "\(stats.gamesPlayed)")
                statTile("Accuracy", stats.gamesPlayed > 0 ? "\(stats.averageAccuracy)%" : "—")
                statTile("Best Streak", "\(stats.longestStreak)")
                statTile("Total XP", "\(stats.xpEarned)")
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(sectionBackground)
    }

    private var startButton: some View {
        Button {
            HapticService.medium()
            showStudySetPicker = true
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "play.fill")
                    .font(.headline.weight(.bold))
                Text("Start Game")
                    .font(.headline.weight(.semibold))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background {
                Capsule(style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [game.color, game.artworkColors.last ?? game.color],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            }
        }
        .buttonStyle(GamePressButtonStyle())
        .padding(.top, AppSpacing.small)
    }

    private func detailChip(title: String, value: String, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(tint)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
    }

    private func statTile(_ title: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(.headline.weight(.bold))
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(.tertiarySystemGroupedBackground))
        }
    }

    private var sectionBackground: some View {
        RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
            .fill(Color(.secondarySystemGroupedBackground))
            .overlay {
                RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                    .strokeBorder(Color.primary.opacity(0.06), lineWidth: 0.5)
            }
    }
}

#Preview {
    NavigationStack {
        GameDetailView(game: GameDefinition.catalog[4])
    }
    .environment(GameScoreStore())
    .environment(AchievementStore())
}
