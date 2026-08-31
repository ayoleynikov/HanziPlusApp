//
//  PathCourse+LessonLocalized.swift
//  HanziPlus
//

import Foundation

extension PathLessonSummary {
    var localizedTranslationTitle: String? {
        translationTitle?.localizedValueOrNil()
    }
}

extension PathLesson {
    var localizedTranslationTitle: String? {
        translationTitle?.localizedValueOrNil()
    }
}

extension PathDialogueLine {
    var localizedTranslation: String? {
        translation?.localizedValueOrNil()
    }
}

extension PathVocabularyItem {
    var localizedTranslation: String {
        translation.localizedValue()
    }
}

extension PathVocabularyGroup {
    var localizedTitle: String {
        title.localizedValue()
    }
}

extension PathExample {
    var localizedTranslation: String? {
        translation?.localizedValueOrNil()
    }
}
