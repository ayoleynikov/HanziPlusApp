//
//  PathStrings.swift
//  HanziPlus
//

import Foundation

enum PathStrings {

    static var cardTitle: String { L10n.string("path.card.title") }
    static var cardSubtitle: String { L10n.string("path.card.subtitle") }
    static var cardDetail: String { L10n.string("path.card.detail") }
    static var startCourse: String { L10n.string("path.start_course") }
    static var continueCourse: String { L10n.string("path.continue_course") }
    static var aboutCourse: String { L10n.string("path.about_course") }
    static var readMore: String { L10n.string("path.read_more") }
    static var courseFormatLabel: String { L10n.string("path.course_format_label") }

    static var howItWorksTitle: String { L10n.string("path.how_it_works.title") }
    static var howItWorksSteps: [(title: String, detail: String)] {
        [
            (L10n.string("path.how.step1.title"), L10n.string("path.how.step1.detail")),
            (L10n.string("path.how.step2.title"), L10n.string("path.how.step2.detail")),
            (L10n.string("path.how.step3.title"), L10n.string("path.how.step3.detail")),
            (L10n.string("path.how.step4.title"), L10n.string("path.how.step4.detail")),
        ]
    }

    static var firstWords: String { L10n.string("path.first_words") }
    static var studyFirstWords: String { L10n.string("path.study_first_words") }
    static var studyNewWords: String { L10n.string("path.study_new_words") }
    static var continueConversation: String { L10n.string("path.continue_conversation") }
    static var lessonWords: String { L10n.string("path.lesson_words") }
    static var lessonPhrasesTitle: String { L10n.string("path.lesson_phrases_title") }
    static var exampleGroupDialogue: String { L10n.string("path.example_group.dialogue") }
    static var exampleGroupAdditional: String { L10n.string("path.example_group.additional") }
    static var exampleGroupQuestions: String { L10n.string("path.example_group.questions") }
    static var exampleGroupCompounds: String { L10n.string("path.example_group.compounds") }
    static var exampleGroupReading: String { L10n.string("path.example_group.reading") }
    static var finishPhrases: String { L10n.string("path.finish_phrases") }
    static var studiedDialogues: String { L10n.string("path.studied_dialogues") }
    static var replayDialogues: String { L10n.string("path.replay_dialogues") }
    static var lessonUnavailable: String { L10n.string("path.lesson_unavailable") }
    static var lessonsTitle: String { L10n.string("path.lessons_title") }

    static var lessonPrefix: String { L10n.string("path.lesson_prefix") }
    static var allWordsLearned: String { L10n.string("path.all_words_learned") }
    static var next: String { L10n.string("path.next") }
    static var backToDialogue: String { L10n.string("path.back_to_dialogue") }
    static var readDialogueAgain: String { L10n.string("path.read_dialogue_again") }
    static var wordsInDialogue: String { L10n.string("path.words_in_dialogue") }
    static var otherLessonWordsNote: String { L10n.string("path.other_lesson_words_note") }
    static var whatDoesWordMean: String { L10n.string("path.what_does_word_mean") }
    static var lessonComplete: String { L10n.string("path.lesson_complete") }
    static var nextLesson: String { L10n.string("path.next_lesson") }
    static var retryLesson: String { L10n.string("path.retry_lesson") }

    static var statusStart: String { L10n.string("path.status.start") }
    static var statusInProgress: String { L10n.string("path.status.in_progress") }
    static var statusCompleted: String { L10n.string("path.status.completed") }
    static var statusComingSoon: String { L10n.string("path.status.coming_soon") }
    static var statusRequiresPriorLesson: String { L10n.string("path.status.requires_prior_lesson") }

    static func lessonProgress(current: Int, total: Int) -> String {
        L10n.string("path.lesson_progress \(current) \(total)")
    }

    static func lessonNumber(_ number: Int) -> String {
        String(format: "%02d", number)
    }

    static func lessonCompletedTitle(_ number: Int) -> String {
        L10n.string("path.lesson_completed_title \(number)")
    }

    static func newWordsLabel(_ count: Int) -> String {
        L10n.string("path.new_words_label \(count)")
    }

    static func howToSayPrompt(_ translation: String) -> String {
        L10n.placeholder("path.how_to_say_prompt", translation)
    }

    static func wordCountLabel(_ count: Int) -> String {
        L10n.words(count)
    }

    static func exampleGroupTitle(for key: String?) -> String? {
        switch key {
        case "dialogue": exampleGroupDialogue
        case "additional": exampleGroupAdditional
        case "questions": exampleGroupQuestions
        case "compounds": exampleGroupCompounds
        case "reading": exampleGroupReading
        default: nil
        }
    }

    static func courseLessonsLabel(available: Int, total: Int) -> String {
        L10n.string("path.course_lessons_label \(total) \(available)")
    }

    static var courseInDevelopment: String { L10n.string("path.course_in_development") }
}
