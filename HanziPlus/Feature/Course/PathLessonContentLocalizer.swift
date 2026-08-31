//
//  PathLessonContentLocalizer.swift
//  HanziPlus
//

import Foundation

enum PathLessonContentLocalizer {

    /// Resolves lesson JSON chrome strings (transitions, button titles) for the active UI language.
    static func localized(_ text: String) -> String {
        switch text {
        case "path.continue_conversation", "Теперь продолжим разговор.":
            return PathStrings.continueConversation
        case "path.study_first_words", "Изучить первые слова":
            return PathStrings.studyFirstWords
        case "path.study_new_words", "Изучить новые слова":
            return PathStrings.studyNewWords
        case "path.next", "Дальше":
            return PathStrings.next
        case "path.read_dialogue_again", "Прочитай диалог ещё раз":
            return PathStrings.readDialogueAgain
        default:
            if text.hasPrefix("path.") {
                return L10n.dynamic(text)
            }
            return text
        }
    }
}
