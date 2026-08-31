//
//  PathExamplesView.swift
//  HanziPlus
//

import SwiftUI

struct PathExamplesView: View {

    let example: PathExample
    let showsGroupHeader: Bool
    let index: Int
    let total: Int
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            if index == 0 {
                Text(PathStrings.lessonPhrasesTitle)
                    .font(.headline.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            if showsGroupHeader, let groupTitle = PathStrings.exampleGroupTitle(for: example.group) {
                Text(groupTitle)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, index == 0 ? 0 : 4)
            }

            VStack(spacing: 16) {
                Text(example.hanzi)
                    .font(.system(size: 42, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)

                Text(example.pinyin)
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                if example.hasTranslation, let translation = example.localizedTranslation {
                    Text(translation)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }

                DailyLessonSpeakButton(text: example.speechText, large: true)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.large)
            .padding(.horizontal, AppSpacing.medium)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
            }
            .studyCardShadow()
            .animation(.easeInOut(duration: 0.25), value: example.id)

            Text("\(index + 1) / \(total)")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)

            Spacer(minLength: 0)

            Button(action: onContinue) {
                Text(index + 1 == total ? PathStrings.finishPhrases : PathStrings.next)
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .frame(minHeight: 44)
                    .background(Capsule(style: .continuous).fill(Color.teal))
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    PathExamplesView(
        example: PathExample(id: "1", hanzi: "你忙吗？", pinyin: "Nǐ máng ma?", translation: PathLocalizedText(legacyRussian: "Ты занят?")),
        showsGroupHeader: true,
        index: 0,
        total: 6,
        onContinue: {}
    )
    .padding()
}
