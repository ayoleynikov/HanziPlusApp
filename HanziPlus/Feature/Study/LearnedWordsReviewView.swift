//
//  LearnedWordsReviewView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct LearnedWordsReviewView: View {

    let studySet: StudySet

    @Environment(LearnedWordsStore.self) private var learnedStore

    private var learnedWords: [Word] {
        WordLoader.load(fileName: studySet.fileName)
            .filter { learnedStore.isLearned(word: $0, in: studySet) }
    }

    var body: some View {
        Group {
            if learnedWords.isEmpty {
                ContentUnavailableView(
                    L10n.string("study.learned_words.title"),
                    systemImage: "checkmark.circle",
                    description: Text(l10n: "study.learned_words.empty")
                )
            } else {
                List(learnedWords) { word in
                    NavigationLink {
                        WordDetailView(word: word)
                    } label: {
                        LearnedWordRow(word: word)
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle(L10n.string("study.learned_words.title"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct LearnedWordRow: View {

    let word: Word

    var body: some View {
        HStack(spacing: 16) {
            Text(word.hanzi)
                .font(.title2.weight(.semibold))
                .frame(width: 52, alignment: .leading)

            VStack(alignment: .leading, spacing: 4) {
                Text(word.pinyin)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(word.translation)
                    .font(.subheadline.weight(.medium))
                    .lineLimit(2)
            }

            Spacer(minLength: 0)

            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
                .font(.body.weight(.semibold))
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        LearnedWordsReviewView(studySet: SampleStudySets.all[0])
    }
    .environment(LearnedWordsStore())
}
