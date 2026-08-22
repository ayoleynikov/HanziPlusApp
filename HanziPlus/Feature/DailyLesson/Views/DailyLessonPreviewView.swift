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
                    .accessibilityLabel("Chinese character \(word.hanzi)")

                Text(word.pinyin)
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .accessibilityLabel("Pinyin \(word.pinyin)")

                Text(word.localizedMeaning)
                    .font(.title2.weight(.semibold))
                    .multilineTextAlignment(.center)
                    .accessibilityLabel("\(word.hanzi) · \(word.localizedMeaning)")

                if let example = word.examples.first {
                    VStack(spacing: 6) {
                        Text(example.hanzi)
                            .font(.body.weight(.medium))
                            .multilineTextAlignment(.center)
                        if let english = example.english {
                            Text(english)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.top, 4)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Example \(example.hanzi)\(example.english.map { ". \($0)" } ?? "")")
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
                Text(index + 1 < total ? "Next Word" : "Start Practice")
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .frame(minHeight: 44)
                    .background(Capsule(style: .continuous).fill(Color.orange))
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)
            .accessibilityHint("Moves to the next preview word or practice")
        }
    }
}
