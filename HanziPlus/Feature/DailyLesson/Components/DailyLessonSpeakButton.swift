//
//  DailyLessonSpeakButton.swift
//  HanziPlus
//

import SwiftUI

struct DailyLessonSpeakButton: View {

    let text: String
    var large: Bool = false

    var body: some View {
        Button {
            HapticService.light()
            SpeechService.shared.speak(text)
        } label: {
            if large {
                ZStack {
                    Circle()
                        .fill(Color.orange.opacity(0.14))
                        .frame(width: 112, height: 112)

                    Image(systemName: "speaker.wave.3.fill")
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundStyle(.orange)
                }
                .frame(minWidth: 44, minHeight: 44)
            } else {
                Label("Listen", systemImage: "speaker.wave.2.fill")
                    .font(.subheadline.weight(.semibold))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .frame(minHeight: 44)
                    .background {
                        Capsule(style: .continuous)
                            .fill(Color.orange.opacity(0.14))
                    }
                    .foregroundStyle(.orange)
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Play pronunciation")
        .accessibilityHint("Speaks the Chinese word")
    }
}
