//
//  DailyLessonPreviewView.swift
//  HanziPlus
//

import SwiftUI

struct DailyLessonPreviewView: View {

    let word: Word
    let index: Int
    let total: Int
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            Spacer(minLength: AppSpacing.small)

            VStack(spacing: 14) {
                Text(word.hanzi)
                    .font(.system(size: 56, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .accessibilityLabel(L10n.string("Chinese character \(word.hanzi)"))

                Text(word.pinyin)
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .accessibilityLabel(L10n.string("Pinyin \(word.pinyin)"))

                Text(word.localizedMeaning)
                    .font(.title2.weight(.semibold))
                    .multilineTextAlignment(.center)
                    .accessibilityLabel("\(word.hanzi) · \(word.localizedMeaning)")

                if let example = word.examples.first {
                    ExampleRowView(example: example, style: .compact)
                        .padding(.top, 4)
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel(L10n.string("Example \(example.hanzi)\(example.localizedMeaning.map { ". \($0)" } ?? "")"))
                }

                DailyLessonSpeakButton(text: word.hanzi)
                    .padding(.top, 4)
            }
            .frame(maxWidth: .infinity)
            .padding(AppSpacing.large)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
            }
            .studyCardShadow()

            Spacer(minLength: AppSpacing.small)

            Button(action: onContinue) {
                Text(index + 1 < total ? L10n.string( "lesson.preview.next_word") : L10n.string( "lesson.preview.start_practice"))
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .frame(minHeight: 44)
                    .background(Capsule(style: .continuous).fill(Color.orange))
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)
            .accessibilityHint(L10n.string( "lesson.preview.a11y_hint"))
        }
    }
}
