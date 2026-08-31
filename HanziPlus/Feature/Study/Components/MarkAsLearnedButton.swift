//
//  MarkAsLearnedButton.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct MarkAsLearnedButton: View {

    let isLearned: Bool
    var isDisabled: Bool = false
    let action: () -> Void

    @State private var celebrationScale: CGFloat = 1
    @State private var burstScale: CGFloat = 0.4
    @State private var burstOpacity: Double = 0
    @State private var checkBounce = false

    var body: some View {
        Button(action: action) {
            ZStack {
                if isLearned {
                    Circle()
                        .strokeBorder(Color.green.opacity(0.35), lineWidth: 2)
                        .frame(width: 56, height: 56)
                        .scaleEffect(burstScale)
                        .opacity(burstOpacity)
                }

                HStack(spacing: 8) {
                    Image(systemName: isLearned ? "checkmark.circle.fill" : "checkmark.circle")
                        .font(.body.weight(.semibold))
                        .symbolEffect(.bounce, value: checkBounce)
                        .contentTransition(.symbolEffect(.replace))

                    Text(isLearned ? L10n.string("study.learned_check") : L10n.string("study.mark_learned"))
                        .font(.subheadline.weight(.semibold))
                }
                .foregroundStyle(isLearned ? Color.green : Color.primary)
                .padding(.horizontal, 22)
                .padding(.vertical, 13)
                .background {
                    Capsule(style: .continuous)
                        .fill(isLearned ? Color.green.opacity(0.12) : Color(.secondarySystemGroupedBackground))
                        .overlay {
                            Capsule(style: .continuous)
                                .strokeBorder(
                                    isLearned ? Color.green.opacity(0.28) : Color.primary.opacity(0.08),
                                    lineWidth: 0.5
                                )
                        }
                }
            }
            .scaleEffect(celebrationScale)
        }
        .buttonStyle(MarkAsLearnedButtonStyle())
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.72 : 1)
        .animation(.spring(response: 0.34, dampingFraction: 0.78), value: isLearned)
        .onChange(of: isLearned) { wasLearned, nowLearned in
            guard !wasLearned, nowLearned else { return }
            playCelebration()
        }
    }

    private func playCelebration() {
        checkBounce.toggle()

        burstScale = 0.4
        burstOpacity = 0.85

        withAnimation(.spring(response: 0.38, dampingFraction: 0.58)) {
            celebrationScale = 1.07
        }

        withAnimation(.spring(response: 0.48, dampingFraction: 0.72).delay(0.08)) {
            burstScale = 1.55
            burstOpacity = 0
        }

        withAnimation(.spring(response: 0.42, dampingFraction: 0.76).delay(0.14)) {
            celebrationScale = 1
        }
    }
}

private struct MarkAsLearnedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.spring(response: 0.28, dampingFraction: 0.72), value: configuration.isPressed)
    }
}

#Preview {
    VStack(spacing: 20) {
        MarkAsLearnedButton(isLearned: false, action: {})
        MarkAsLearnedButton(isLearned: true, action: {})
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
