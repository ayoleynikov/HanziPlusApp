//
//  DailyLessonOptionButton.swift
//  HanziPlus
//

import SwiftUI

struct DailyLessonOptionButton: View {

    let text: String
    let emphasizesHanzi: Bool
    let isSelected: Bool
    let isCorrect: Bool
    let showResult: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(text)
                    .font(emphasizesHanzi ? .title2.weight(.semibold) : .body.weight(.semibold))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.7)

                Spacer(minLength: 0)

                if showResult {
                    if isCorrect {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                    } else if isSelected {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.red)
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .frame(minHeight: 44)
            .frame(maxWidth: .infinity, alignment: .leading)
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
        .accessibilityLabel(text)
        .accessibilityHint(showResult ? "Answer locked" : "Double tap to choose")
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
    }

    private var backgroundColor: Color {
        guard showResult else {
            return isSelected ? Color.orange.opacity(0.12) : Color(.secondarySystemGroupedBackground)
        }
        if isCorrect { return .green.opacity(0.16) }
        if isSelected { return .red.opacity(0.16) }
        return Color(.secondarySystemGroupedBackground).opacity(0.6)
    }

    private var borderColor: Color {
        guard showResult else {
            return isSelected ? Color.orange.opacity(0.4) : Color.primary.opacity(0.06)
        }
        if isCorrect { return .green.opacity(0.55) }
        if isSelected { return .red.opacity(0.55) }
        return Color.primary.opacity(0.04)
    }
}
