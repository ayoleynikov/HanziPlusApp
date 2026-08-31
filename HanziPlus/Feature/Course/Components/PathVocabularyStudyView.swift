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

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            Text(sectionTitle)
                .font(.headline.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 16) {
                Text(item.hanzi)
                    .font(.system(size: 72, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .contentTransition(.numericText())

                Text(item.pinyin)
                    .font(.title2)
                    .foregroundStyle(.secondary)
                    .contentTransition(.numericText())

                Text(item.localizedTranslation)
                    .font(.title3.weight(.medium))
                    .multilineTextAlignment(.center)
                    .contentTransition(.numericText())

                DailyLessonSpeakButton(text: item.speechText, large: true)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.large)
            .padding(.horizontal, AppSpacing.medium)
            .background {
                RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
            }
            .studyCardShadow()
            .animation(.easeInOut(duration: 0.25), value: item.id)

            Text("\(index + 1) / \(total)")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)

            Spacer(minLength: 0)

            Button(action: onContinue) {
                Text(index + 1 == total ? PathStrings.allWordsLearned : PathStrings.next)
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .frame(minHeight: 44)
                    .background(Capsule(style: .continuous).fill(Color.teal))
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)
            .accessibilityIdentifier("path_continue_button")
        }
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
