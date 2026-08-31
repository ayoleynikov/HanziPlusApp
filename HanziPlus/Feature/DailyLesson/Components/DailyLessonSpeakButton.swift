//
//  DailyLessonSpeakButton.swift
//  HanziPlus
//

import SwiftUI

struct DailyLessonSpeakButton: View {

    let text: String
    var large: Bool = false
    var iconOnly: Bool = false

    @State private var showsVolumeHint = false
    @State private var hideHintTask: Task<Void, Never>?

    var body: some View {
        VStack(spacing: 8) {
            Button(action: play) {
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
                } else if iconOnly {
                    Image(systemName: "speaker.wave.2.fill")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.orange)
                        .frame(width: 44, height: 44)
                        .background {
                            Circle()
                                .fill(Color.orange.opacity(0.14))
                        }
                } else {
                    Label(L10n.string("Listen"), systemImage: "speaker.wave.2.fill")
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
            .accessibilityLabel(L10n.string("a11y.play_pronunciation"))
            .accessibilityHint(L10n.string("a11y.speaks_chinese_word"))

            if showsVolumeHint {
                Label {
                    Text(l10n: "audio.turn_up_volume")
                        .multilineTextAlignment(.center)
                } icon: {
                    Image(systemName: "speaker.slash.fill")
                }
                .font(.caption)
                .foregroundStyle(.orange)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }

    private func play() {
        if SpeechService.shared.speakIfAudible(text) {
            HapticService.light()
            hideVolumeHint()
        } else {
            HapticService.rigid()
            withAnimation(.easeInOut(duration: 0.2)) {
                showsVolumeHint = true
            }
            scheduleHideHint()
        }
    }

    private func scheduleHideHint() {
        hideHintTask?.cancel()
        hideHintTask = Task {
            try? await Task.sleep(for: .seconds(4))
            guard !Task.isCancelled else { return }
            await MainActor.run {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showsVolumeHint = false
                }
            }
        }
    }

    private func hideVolumeHint() {
        hideHintTask?.cancel()
        showsVolumeHint = false
    }
}
