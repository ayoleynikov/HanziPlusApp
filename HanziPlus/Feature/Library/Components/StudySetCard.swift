//
//  StudySetCard.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct StudySetCard: View {

    let studySet: StudySet
    let wordCount: Int
    let learnedWords: Int

    private var progress: Double {
        guard wordCount > 0 else { return 0 }
        return Double(learnedWords) / Double(wordCount)
    }

    private var percentage: Int {
        Int(progress * 100)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .top, spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(studySet.color.opacity(0.14))
                        .frame(width: 52, height: 52)

                    Image(systemName: studySet.icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(studySet.color)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text(studySet.title)
                        .font(.title2.weight(.bold))
                        .foregroundStyle(.primary)

                    Text(studySet.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("\(wordCount) words")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.tertiary)
                }

                Spacer(minLength: 0)

                Image(systemName: "chevron.right")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.tertiary)
                    .padding(.top, 4)
            }

            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .firstTextBaseline) {
                    Spacer()

                    Text("\(learnedWords) / \(wordCount) learned")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.secondary)

                    Text("\(percentage)%")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.primary)
                        .frame(minWidth: 36, alignment: .trailing)
                }

                AnimatedProgressBar(progress: progress, tint: studySet.color)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [studySet.color.opacity(0.07), .clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                        .strokeBorder(Color.primary.opacity(0.06), lineWidth: 0.5)
                }
        }
        .studyCardShadow()
    }
}

#Preview {
    StudySetCard(
        studySet: SampleStudySets.all[0],
        wordCount: WordCatalog().wordCount(for: "hsk1"),
        learnedWords: 48
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}
