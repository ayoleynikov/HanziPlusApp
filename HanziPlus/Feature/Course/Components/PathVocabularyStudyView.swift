//
//  PathVocabularyStudyView.swift
//  HanziPlus
//

import SwiftUI

struct PathVocabularyStudyView: View {

    let item: PathVocabularyItem
    let sectionTitle: String
    let index: Int
    let total: Int
    let onContinue: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            Text(sectionTitle)
                .font(.headline.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityAddTraits(.isHeader)

            PathStudyCard {
                VStack(spacing: 16) {
                    Text(item.hanzi)
                        .font(.system(size: 72, weight: .bold))
                        .minimumScaleFactor(0.5)
                        .accessibilityLabel(item.hanzi)

                    Text(item.pinyin)
                        .font(.title2)
                        .foregroundStyle(.secondary)
                        .accessibilityLabel(item.pinyin)

                    Text(item.localizedTranslation)
                        .font(.title3.weight(.medium))
                        .multilineTextAlignment(.center)
                        .accessibilityLabel(item.localizedTranslation)

                    DailyLessonSpeakButton(
                        text: item.hanzi,
                        iconOnly: true,
                        accessibilityIdentifier: "path_vocab_speak_button"
                    )
                }
            }
            .animation(PathMotion.stepAnimation(reduceMotion: reduceMotion, value: item.id), value: item.id)

            PathWordProgressBadge(index: index, total: total)

            Spacer(minLength: 0)

            PathContinueButton(
                title: index + 1 == total ? PathStrings.allWordsLearned : PathStrings.next,
                action: onContinue
            )
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("path_vocabulary_study")
    }
}

#Preview {
    PathVocabularyStudyView(
        item: PathCourseLoader.previewLesson().allVocabulary[0],
        sectionTitle: PathStrings.firstWords,
        index: 0,
        total: 12,
        onContinue: {}
    )
    .padding()
}
