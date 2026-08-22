//
//  GameOptionButton.swift
//  HanziPlus
//

import SwiftUI

struct GameOptionButton: View {

    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let showResult: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(text)
                    .font(.body.weight(.semibold))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)

                Spacer(minLength: 0)

                if showResult {
                    if isCorrect {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                            .transition(.scale.combined(with: .opacity))
                    } else if isSelected {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.red)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                    .fill(backgroundColor)
            }
            .overlay {
                RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                    .strokeBorder(borderColor, lineWidth: showResult ? 1.5 : 0.5)
            }
            .scaleEffect(isCorrect && showResult ? 1.02 : (isSelected && !showResult ? 0.99 : 1))
            .animation(.spring(response: 0.35, dampingFraction: 0.72), value: showResult)
        }
        .buttonStyle(.plain)
        .disabled(showResult)
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

#Preview {
    VStack(spacing: 12) {
        GameOptionButton(text: "Study", isSelected: false, isCorrect: true, showResult: false, action: {})
        GameOptionButton(text: "Study", isSelected: true, isCorrect: true, showResult: true, action: {})
    }
    .padding()
}
