//
//  DailyLessonListeningView.swift
//  HanziPlus
//

import SwiftUI

struct DailyLessonListeningView: View {

    let word: Word
    let options: [String]
    let selectedAnswer: String?
    let showFeedback: Bool
    let onSelect: (String) -> Void
    let onContinue: () -> Void

    @State private var didAttemptAutoPlay = false

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            VStack(spacing: 16) {
                DailyLessonSpeakButton(text: word.hanzi, large: true)

                Text("Tap to hear again")
                    .font(.caption)
                    .foregroundStyle(.tertiary)

                if showFeedback {
                    Text(word.pinyin)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .accessibilityLabel("Pinyin \(word.pinyin)")
                } else {
                    Text("Which Hanzi did you hear?")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.medium)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
            }
            .studyCardShadow()

            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: AppSpacing.small
            ) {
                ForEach(options, id: \.self) { option in
                    DailyLessonOptionButton(
                        text: option,
                        emphasizesHanzi: true,
                        isSelected: selectedAnswer == option,
                        isCorrect: option == word.hanzi,
                        showResult: showFeedback,
                        action: { onSelect(option) }
                    )
                }
            }

            Spacer(minLength: 0)

            if showFeedback {
                Button(action: onContinue) {
                    Text("Continue")
                        .font(.body.weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .frame(minHeight: 44)
                        .background(Capsule(style: .continuous).fill(Color.orange))
                        .foregroundStyle(.white)
                }
                .buttonStyle(.plain)
            }
        }
        .onAppear {
            guard !didAttemptAutoPlay else { return }
            didAttemptAutoPlay = true
            if SpeechService.shared.canAutoPlay {
                SpeechService.shared.speak(word.hanzi)
            }
        }
        .onChange(of: word.hanzi) { _, newValue in
            if SpeechService.shared.canAutoPlay {
                SpeechService.shared.speak(newValue)
            }
        }
    }
}
