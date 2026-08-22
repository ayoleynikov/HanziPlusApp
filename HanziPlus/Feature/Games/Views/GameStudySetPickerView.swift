//
//  GameStudySetPickerView.swift
//  HanziPlus
//

import SwiftUI

struct GameStudySetPickerView: View {

    let game: GameDefinition
    var memoryMode: MemoryMatchMode?
    let showsDifficultyPicker: Bool

    @State private var difficulty: GameDifficulty

    @Environment(WordCatalog.self) private var catalog

    init(
        game: GameDefinition,
        difficulty: GameDifficulty = .medium,
        memoryMode: MemoryMatchMode? = nil,
        showsDifficultyPicker: Bool = false
    ) {
        self.game = game
        self.memoryMode = memoryMode
        self.showsDifficultyPicker = showsDifficultyPicker
        _difficulty = State(initialValue: difficulty)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                gameHeader
                    .padding(.horizontal, AppSpacing.medium)
                    .padding(.top, AppSpacing.small)

                VStack(alignment: .leading, spacing: AppSpacing.medium) {
                    Text("games.choose_study_set")
                        .font(.title2.weight(.semibold))
                        .padding(.horizontal, AppSpacing.medium)

                    if showsDifficultyPicker {
                        GameDifficultyPicker(difficulty: $difficulty)
                            .padding(.horizontal, AppSpacing.medium)
                    }

                    LazyVStack(spacing: AppSpacing.medium) {
                        ForEach(SampleStudySets.all) { studySet in
                            NavigationLink {
                                GameRouter.destination(
                                    for: game,
                                    studySet: studySet,
                                    difficulty: difficulty,
                                    memoryMode: memoryMode
                                )
                            } label: {
                                StudySetPickerRow(
                                    studySet: studySet,
                                    wordCount: catalog.wordCount(for: studySet.fileName)
                                )
                            }
                            .buttonStyle(StudySetCardButtonStyle())
                        }
                    }
                    .padding(.horizontal, AppSpacing.medium)
                }
            }
            .padding(.bottom, AppSpacing.extraLarge)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(game.localizedTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var gameHeader: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(game.color.opacity(0.14))
                    .frame(width: 52, height: 52)

                Image(systemName: game.icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(game.color)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(game.localizedTitle)
                    .font(.title3.weight(.bold))

                Text(game.localizedDescription)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(AppSpacing.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
    }
}

private struct StudySetPickerRow: View {

    let studySet: StudySet
    let wordCount: Int

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(studySet.color.opacity(0.14))
                    .frame(width: 48, height: 48)

                Image(systemName: studySet.icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(studySet.color)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(studySet.localizedTitle)
                    .font(.headline.weight(.semibold))

                Text("\(wordCount) words · \(studySet.subtitle)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                        .strokeBorder(Color.primary.opacity(0.06), lineWidth: 0.5)
                }
        }
        .studyCardShadow()
    }
}

#Preview {
    NavigationStack {
        GameStudySetPickerView(game: GameDefinition.catalog[0])
    }
    .environment(WordCatalog())
}
