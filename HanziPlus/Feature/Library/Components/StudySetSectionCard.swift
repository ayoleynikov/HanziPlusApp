//
//  StudySetSectionCard.swift
//  HanziPlus
//

import SwiftUI

struct StudySetSectionCard: View {

    let section: StudySetSection
    let wordCount: Int
    let learnedWords: Int
    let tint: Color

    private var progress: Double {
        guard wordCount > 0 else { return 0 }
        return Double(learnedWords) / Double(wordCount)
    }

    private var percentage: Int {
        Int(progress * 100)
    }

    private var isComplete: Bool {
        wordCount > 0 && learnedWords >= wordCount
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(tint.opacity(0.14))
                        .frame(width: 48, height: 48)

                    Image(systemName: section.icon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(tint)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(section.displayTitle)
                        .font(.headline.weight(.bold))
                        .foregroundStyle(.primary)
                        .lineLimit(2)

                    Text(L10n.words(wordCount))
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.tertiary)
                }

                Spacer(minLength: 0)

                if isComplete {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.title3)
                        .foregroundStyle(.green)
                } else {
                    Image(systemName: "chevron.right")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.tertiary)
                        .padding(.top, 4)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(L10n.string("\(learnedWords) / \(wordCount) learned"))
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.secondary)

                    Spacer()

                    Text(isComplete ? L10n.string("common.done") : L10n.percent(percentage))
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(isComplete ? .green : .primary)
                }

                AnimatedProgressBar(progress: progress, tint: isComplete ? .green : tint)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [tint.opacity(0.06), .clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                        .strokeBorder(
                            isComplete ? Color.green.opacity(0.25) : Color.primary.opacity(0.06),
                            lineWidth: 0.5
                        )
                }
        }
        .studyCardShadow()
    }
}

#Preview {
    StudySetSectionCard(
        section: StudySetCatalog.travelSections[1],
        wordCount: 12,
        learnedWords: 4,
        tint: .orange
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}
