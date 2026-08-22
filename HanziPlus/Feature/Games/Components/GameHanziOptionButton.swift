//
//  GameHanziOptionButton.swift
//  HanziPlus
//

import SwiftUI

struct GameHanziOptionButton: View {
    let hanzi: String
    let isSelected: Bool
    let isCorrect: Bool
    let showResult: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(hanzi)
                .font(.title2.weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background {
                    RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                        .fill(backgroundColor)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                        .strokeBorder(borderColor, lineWidth: showResult ? 1.5 : 0.5)
                }
        }
        .buttonStyle(.plain)
        .disabled(showResult)
        .scaleEffect(isCorrect && showResult ? 1.03 : 1)
        .animation(.spring(response: 0.35, dampingFraction: 0.72), value: showResult)
    }

    private var backgroundColor: Color {
        guard showResult else {
            return isSelected ? Color.accentColor.opacity(0.1) : Color(.secondarySystemGroupedBackground)
        }
        if isCorrect { return .green.opacity(0.16) }
        if isSelected { return .red.opacity(0.16) }
        return Color(.secondarySystemGroupedBackground).opacity(0.6)
    }

    private var borderColor: Color {
        guard showResult else {
            return isSelected ? Color.accentColor.opacity(0.35) : Color.primary.opacity(0.06)
        }
        if isCorrect { return .green.opacity(0.55) }
        if isSelected { return .red.opacity(0.55) }
        return Color.primary.opacity(0.04)
    }
}
