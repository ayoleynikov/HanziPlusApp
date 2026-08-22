//
//  JourneyMiniActivityView.swift
//  HanziPlus
//

import SwiftUI

struct JourneyMiniActivityView: View {
    let city: JourneyCity

    @Environment(\.dismiss) private var dismiss
    @State private var timeRemaining = 25
    @State private var found = false
    @State private var tiles: [MiniTile] = []
    @State private var timerActive = true

    var body: some View {
        NavigationStack {
            VStack(spacing: AppSpacing.large) {
                Text(city.localizedMiniInstruction)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                if found {
                    successView
                } else {
                    gameGrid
                    Text("\(timeRemaining)s")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .monospacedDigit()
                }
            }
            .padding(AppSpacing.medium)
            .navigationTitle(city.localizedMiniTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(String(localized: "common.close")) { dismiss() }
                }
            }
            .onAppear { setupTiles(); startTimer() }
        }
        .presentationDetents([.medium, .large])
    }

    private var gameGrid: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
            ForEach(tiles) { tile in
                Button {
                    tap(tile)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(tile.isTarget ? city.theme.primary.opacity(0.15) : Color(.tertiarySystemFill))
                            .frame(height: 72)
                        Text(tile.emoji)
                            .font(.title)
                            .opacity(tile.revealed ? 1 : 0.15)
                    }
                }
                .buttonStyle(.plain)
                .disabled(tile.revealed && !tile.isTarget)
            }
        }
        .padding(.horizontal)
    }

    private var successView: some View {
        VStack(spacing: 16) {
            Text(city.miniActivity.targetEmoji)
                .font(.system(size: 72))
                .scaleEffect(found ? 1 : 0.5)
                .animation(.spring(response: 0.5, dampingFraction: 0.65), value: found)

            Text("journey.mini.great_find")
                .font(.title2.weight(.bold))

            Label("+\(city.miniActivity.xpReward) XP", systemImage: "sparkles")
                .font(.headline)
                .foregroundStyle(city.theme.primary)

            Button(String(localized: "common.done")) { dismiss() }
                .buttonStyle(.borderedProminent)
                .tint(city.theme.primary)
                .padding(.top, 8)
        }
        .padding(.vertical, AppSpacing.large)
    }

    private func setupTiles() {
        let distractors = ["🌸", "🏮", "🎋", "🍜", "🚲", "🎭", "🌿", "📸"]
        var items = (0..<8).map { i in
            MiniTile(id: i, emoji: distractors[i % distractors.count], isTarget: false)
        }
        items.append(MiniTile(id: 9, emoji: city.miniActivity.targetEmoji, isTarget: true))
        tiles = items.shuffled()
    }

    private func tap(_ tile: MiniTile) {
        guard let index = tiles.firstIndex(where: { $0.id == tile.id }) else { return }
        tiles[index].revealed = true

        if tile.isTarget {
            HapticService.success()
            timerActive = false
            withAnimation(.spring(response: 0.45, dampingFraction: 0.72)) {
                found = true
            }
        } else {
            HapticService.light()
        }
    }

    private func startTimer() {
        Task {
            while timerActive && timeRemaining > 0 && !found {
                try? await Task.sleep(for: .seconds(1))
                await MainActor.run {
                    if timerActive { timeRemaining -= 1 }
                }
            }
        }
    }
}

private struct MiniTile: Identifiable {
    let id: Int
    let emoji: String
    let isTarget: Bool
    var revealed = false
}
