//
//  DailyLessonSummaryView.swift
//  HanziPlus
//

import SwiftUI

struct DailyLessonSummaryView: View {

    let studySet: StudySet
    let learnedCount: Int
    let wordCount: Int
    let meaningAccuracy: Double
    let mistakes: [Word]
    let onDone: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(l10n: "lesson.summary.title")
                        .font(.largeTitle.weight(.bold))
                        .accessibilityAddTraits(.isHeader)

                    Text(L10n.string( "lesson.summary.worked_through \(L10n.words(wordCount))"))
                        .font(.body)
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: AppSpacing.small) {
                    summaryStat(
                        title: L10n.string( "lesson.summary.stat_studied"),
                        value: "\(learnedCount)",
                        icon: "checkmark.seal.fill",
                        tint: .green
                    )
                    summaryStat(
                        title: L10n.string( "lesson.summary.stat_meaning"),
                        value: percent(meaningAccuracy),
                        icon: "text.book.closed.fill",
                        tint: .blue
                    )
                }

                if !mistakes.isEmpty {
                    VStack(alignment: .leading, spacing: AppSpacing.small) {
                        Text(l10n: "lesson.summary.words_to_review")
                            .font(.headline)

                        ForEach(mistakes) { word in
                            HStack(spacing: 12) {
                                Text(word.hanzi)
                                    .font(.title3.weight(.semibold))
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(word.pinyin)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    Text(word.localizedMeaning)
                                        .font(.subheadline)
                                }
                                Spacer(minLength: 0)
                            }
                            .padding(14)
                            .background {
                                RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                                    .fill(Color(.secondarySystemGroupedBackground))
                            }
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("\(word.hanzi), \(word.pinyin), \(word.localizedMeaning)")
                        }
                    }
                } else {
                    Label(L10n.string( "lesson.summary.no_mistakes"), systemImage: "sparkles")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)
                }

                VStack(spacing: AppSpacing.small) {
                    if !mistakes.isEmpty {
                        NavigationLink {
                            SmartReviewView(studySet: studySet)
                        } label: {
                            Text(l10n: "today.hero.start_smart_review")
                                .font(.body.weight(.semibold))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .frame(minHeight: 44)
                                .background(Capsule(style: .continuous).fill(Color.orange))
                                .foregroundStyle(.white)
                        }
                        .buttonStyle(.plain)
                    }

                    Button(action: onDone) {
                        Text(l10n: "common.done")
                            .font(.body.weight(.semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .frame(minHeight: 44)
                            .background {
                                Capsule(style: .continuous)
                                    .strokeBorder(Color.orange, lineWidth: 1.5)
                            }
                            .foregroundStyle(.orange)
                    }
                    .buttonStyle(.plain)
                    .accessibilityHint(L10n.string( "lesson.summary.a11y_done_hint"))
                }
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.bottom, AppSpacing.extraLarge)
        }
    }

    private func summaryStat(title: String, value: String, icon: String, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(tint)
            Text(value)
                .font(.title3.weight(.bold))
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title) \(value)")
    }

    private func percent(_ value: Double) -> String {
        L10n.percent(Int((value * 100).rounded()))
    }
}
