//
//  HanziMemoryModePickerView.swift
//  HanziPlus
//

import SwiftUI

struct HanziMemoryModePickerView: View {

    private let game = GameDefinition.definition(for: .hanziMemory)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                header
                    .padding(.horizontal, AppSpacing.medium)
                    .padding(.top, AppSpacing.small)

                VStack(alignment: .leading, spacing: AppSpacing.medium) {
                    Text("Choose Mode")
                        .font(.title2.weight(.semibold))
                        .padding(.horizontal, AppSpacing.medium)

                    LazyVStack(spacing: AppSpacing.small) {
                        ForEach(MemoryMatchMode.allCases.filter(\.isAvailable)) { mode in
                            NavigationLink {
                                GameStudySetPickerView(game: game, memoryMode: mode)
                            } label: {
                                MemoryModeRow(mode: mode, gameColor: game.color)
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

    private var header: some View {
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

                Text("Pick how you want to match cards, then choose a study set.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
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

private struct MemoryModeRow: View {
    let mode: MemoryMatchMode
    let gameColor: Color

    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(gameColor.opacity(0.14))
                .frame(width: 10, height: 10)

            Text(mode.label)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.primary)

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
        HanziMemoryModePickerView()
    }
}
