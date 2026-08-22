//
//  GameDifficultyPicker.swift
//  HanziPlus
//

import SwiftUI

struct GameDifficultyPicker: View {
    @Binding var difficulty: GameDifficulty

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Difficulty")
                .font(.headline)

            Picker("Difficulty", selection: $difficulty) {
                ForEach(GameDifficulty.allCases, id: \.self) { level in
                    Text(level.label).tag(level)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

struct GameRestartToolbar: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Restart", action: action)
                        .font(.subheadline.weight(.semibold))
                }
            }
    }
}

extension View {
    func gameRestartToolbar(action: @escaping () -> Void) -> some View {
        modifier(GameRestartToolbar(action: action))
    }
}
