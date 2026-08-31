//
//  PathDialogueView.swift
//  HanziPlus
//

import SwiftUI

struct PathDialogueView: View {

    let lesson: PathLesson
    let dialogue: PathDialogue
    let title: String?
    let buttonTitle: String
    let showLessonHeader: Bool
    let highlightVocabulary: [PathVocabularyItem]
    let onContinue: () -> Void

    private var wordsInDialogue: [PathVocabularyItem] {
        PathDialogueVocabularyHelper.vocabulary(in: dialogue, from: highlightVocabulary)
    }

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            ScrollView {
                VStack(spacing: AppSpacing.medium) {
                    if showLessonHeader {
                        lessonHeader
                    }

                    if let title {
                        Text(title)
                            .font(.headline.weight(.semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    if !wordsInDialogue.isEmpty {
                        wordsInDialogueSection
                    }

                    VStack(spacing: 14) {
                        ForEach(dialogue.lines) { line in
                            PathDialogueLineView(
                                line: line,
                                highlightedItems: wordsInDialogue
                            )
                        }
                    }
                }
            }

            Button(action: onContinue) {
                Text(buttonTitle)
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

    private var wordsInDialogueSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(PathStrings.wordsInDialogue)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)

            FlowLayout(spacing: 8) {
                ForEach(wordsInDialogue) { item in
                    Text(item.hanzi)
                        .font(.subheadline.weight(.semibold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background {
                            Capsule(style: .continuous)
                                .fill(Color.teal.opacity(0.14))
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var lessonHeader: some View {
        VStack(spacing: 6) {
            Text("\(PathStrings.lessonPrefix) \(lesson.number)")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(lesson.chineseTitle)
                .font(.title.weight(.bold))
                .frame(maxWidth: .infinity, alignment: .leading)

            if let subtitle = lesson.chineseSubtitle {
                Text(subtitle)
                    .font(.title2.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            if let pinyin = lesson.pinyinTitle {
                Text(pinyin)
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            if let translation = lesson.localizedTranslationTitle {
                Text(translation)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(18)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
    }
}

struct PathDialogueLineView: View {

    let line: PathDialogueLine
    let highlightedItems: [PathVocabularyItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let speaker = line.speaker {
                Text(speaker)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
            }

            highlightedHanziText
                .font(.title2.weight(.semibold))

            Text(line.pinyin)
                .font(.body)
                .foregroundStyle(.secondary)

            if let translation = line.localizedTranslation {
                Text(translation)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            DailyLessonSpeakButton(text: line.speechText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
    }

    private var highlightedHanziText: Text {
        let ranges = highlightedRanges(in: line.hanzi)
        guard !ranges.isEmpty else {
            return Text(line.hanzi)
        }

        var result = Text("")
        var cursor = line.hanzi.startIndex

        for range in ranges {
            if cursor < range.lowerBound {
                result = result + Text(String(line.hanzi[cursor..<range.lowerBound]))
            }
            result = result + Text(String(line.hanzi[range]))
                .foregroundStyle(.teal)
                .fontWeight(.bold)
            cursor = range.upperBound
        }

        if cursor < line.hanzi.endIndex {
            result = result + Text(String(line.hanzi[cursor...]))
        }

        return result
    }

    private func highlightedRanges(in hanzi: String) -> [Range<String.Index>] {
        let sorted = highlightedItems.sorted { $0.hanzi.count > $1.hanzi.count }
        var ranges: [Range<String.Index>] = []

        for item in sorted {
            var searchStart = hanzi.startIndex
            while searchStart < hanzi.endIndex,
                  let range = hanzi.range(of: item.hanzi, range: searchStart..<hanzi.endIndex) {
                let overlaps = ranges.contains { existing in
                    existing.overlaps(range)
                }
                if !overlaps {
                    ranges.append(range)
                }
                searchStart = range.upperBound
            }
        }

        return ranges.sorted { $0.lowerBound < $1.lowerBound }
    }
}

private struct FlowLayout: Layout {
    let spacing: CGFloat

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrange(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrange(proposal: proposal, subviews: subviews)
        for (index, frame) in result.frames.enumerated() {
            subviews[index].place(
                at: CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY),
                proposal: ProposedViewSize(frame.size)
            )
        }
    }

    private func arrange(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, frames: [CGRect]) {
        let maxWidth = proposal.width ?? .infinity
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var frames: [CGRect] = []

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth, x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }

            frames.append(CGRect(origin: CGPoint(x: x, y: y), size: size))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }

        return (CGSize(width: maxWidth, height: y + rowHeight), frames)
    }
}

#Preview {
    let lesson = PathCourseLoader.previewLesson()
    PathDialogueView(
        lesson: lesson,
        dialogue: lesson.dialogues.first!,
        title: nil,
        buttonTitle: PathStrings.studyFirstWords,
        showLessonHeader: true,
        highlightVocabulary: lesson.allVocabulary,
        onContinue: {}
    )
    .padding()
}
