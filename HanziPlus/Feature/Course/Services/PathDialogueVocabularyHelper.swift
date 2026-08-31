//
//  PathDialogueVocabularyHelper.swift
//  HanziPlus
//

import Foundation

enum PathDialogueVocabularyHelper {

    static func vocabulary(in dialogue: PathDialogue, from items: [PathVocabularyItem]) -> [PathVocabularyItem] {
        let sorted = items.sorted { $0.hanzi.count > $1.hanzi.count }
        var matched: [PathVocabularyItem] = []

        for item in sorted {
            let appears = dialogue.lines.contains { line in
                line.hanzi.contains(item.hanzi)
            }
            if appears, !matched.contains(where: { $0.id == item.id }) {
                matched.append(item)
            }
        }

        return matched
    }

    static func vocabularyNotInDialogues(
        lesson: PathLesson,
        dialogues: [PathDialogue]
    ) -> [PathVocabularyItem] {
        let coveredIDs = Set(
            dialogues
                .flatMap { vocabulary(in: $0, from: lesson.allVocabulary) }
                .map(\.id)
        )

        return lesson.allVocabulary.filter { item in
            item.countsInLessonTotal && !coveredIDs.contains(item.id)
        }
    }
}
