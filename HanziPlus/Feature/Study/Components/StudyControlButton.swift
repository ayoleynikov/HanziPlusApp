//
//  StudyControlButton.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct StudyControlButton: View {

    let systemImage: String
    var accessibilityLabel: String? = nil
    var isEnabled = true
    var isActive = false
    var activeColor: Color = .accentColor
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 18, weight: .semibold))
                .symbolRenderingMode(isActive ? .multicolor : .monochrome)
                .foregroundStyle(foregroundColor)
                .frame(width: 52, height: 52)
                .background(backgroundColor)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .strokeBorder(Color.primary.opacity(0.06), lineWidth: 0.5)
                }
        }
        .buttonStyle(StudyControlButtonStyle())
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1 : 0.38)
        .animation(.spring(response: 0.32, dampingFraction: 0.78), value: isActive)
        .accessibilityLabel(accessibilityLabel ?? systemImage)
    }

    private var foregroundColor: Color {
        if isActive { return activeColor }
        return .primary
    }

    private var backgroundColor: Color {
        Color(.secondarySystemGroupedBackground)
    }
}

private struct StudyControlButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.spring(response: 0.28, dampingFraction: 0.72), value: configuration.isPressed)
    }
}

#Preview {
    HStack(spacing: 16) {
        StudyControlButton(systemImage: "chevron.left", isEnabled: false, action: {})
        StudyControlButton(systemImage: "speaker.wave.2.fill", action: {})
        StudyControlButton(systemImage: "heart.fill", isActive: true, activeColor: .red, action: {})
        StudyControlButton(systemImage: "chevron.right", action: {})
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
