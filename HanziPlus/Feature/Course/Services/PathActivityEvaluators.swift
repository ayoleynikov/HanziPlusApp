//
//  PathActivityEvaluators.swift
//  HanziPlus
//

import Foundation

enum PathSentenceBuilderEvaluator {

    static func isCorrect(selectedOrder: [String], activity: PathSentenceBuilderActivity) -> Bool {
        selectedOrder == activity.correctOrder
    }

    static func builtHanzi(from selectedOrder: [String]) -> String {
        selectedOrder.joined()
    }
}

enum PathFillBlankEvaluator {

    static func isCorrect(selected: String, activity: PathFillBlankActivity) -> Bool {
        selected == activity.correctOption
    }
}

enum PathDialogueOrderEvaluator {

    static func isCorrect(selectedOrder: [String], activity: PathDialogueOrderActivity) -> Bool {
        selectedOrder == activity.correctOrder
    }
}

enum PathQuizSubsetBuilder {

    /// Picks key vocabulary for chapter check — prioritizes unmastered and limits count.
    static func quizItems(
        from items: [PathVocabularyItem],
        mistakeIDs: Set<String>,
        limit: Int = 6
    ) -> [PathVocabularyItem] {
        guard !items.isEmpty else { return [] }

        let prioritized = items.sorted { lhs, rhs in
            let lhsMistake = mistakeIDs.contains(lhs.id)
            let rhsMistake = mistakeIDs.contains(rhs.id)
            if lhsMistake != rhsMistake { return lhsMistake }
            return lhs.hanzi.count > rhs.hanzi.count
        }

        if prioritized.count <= limit {
            return prioritized
        }
        return Array(prioritized.prefix(limit))
    }
}
