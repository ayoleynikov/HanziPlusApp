//
//  PathChapterViewModel.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
@MainActor
final class PathChapterViewModel {

    let lesson: PathLesson
    let chapter: PathLessonChapter
    private let pathStore: PathCourseStore
    private let smartReviewStore: SmartReviewStore
    private let steps: [PathResolvedStep]

    private(set) var lessonProgress: PathLessonProgress
    private(set) var chapterProgress: PathChapterProgress
    private(set) var currentChineseOptions: [String] = []
    private(set) var currentTranslationOptions: [PathVocabularyItem] = []
    private(set) var selectedAnswer: String?
    private(set) var selectedTokenIDs: [String] = []
    private(set) var selectedLineOrder: [String] = []
    private(set) var showFeedback = false
    private(set) var lastAnswerCorrect = false
    private(set) var feedbackExplanation: String?

    private var quizVocabularyItems: [PathVocabularyItem] {
        PathQuizSubsetBuilder.quizItems(
            from: chapter.vocabularyItems,
            mistakeIDs: Set(activeMistakes.compactMap(\.vocabularyID))
        )
    }

    init(
        lesson: PathLesson,
        chapter: PathLessonChapter,
        pathStore: PathCourseStore,
        smartReviewStore: SmartReviewStore
    ) {
        self.lesson = lesson
        self.chapter = chapter
        self.pathStore = pathStore
        self.smartReviewStore = smartReviewStore
        self.steps = PathLessonFlowResolver.resolveChapter(chapter, lesson: lesson)
        self.lessonProgress = pathStore.lessonProgress(for: lesson.id)
        self.chapterProgress = pathStore.chapterProgress(for: lesson.id, chapterID: chapter.id)
        pathStore.startChapter(lessonID: lesson.id, chapterID: chapter.id)
        self.chapterProgress = pathStore.chapterProgress(for: lesson.id, chapterID: chapter.id)
        clampProgressToValidRange()
        skipEmptyStepsIfNeeded()
        prepareQuizOptionsIfNeeded()
    }

    var currentStep: PathResolvedStep? {
        guard chapterProgress.stepIndex < steps.count else { return nil }
        return steps[chapterProgress.stepIndex]
    }

    var activeMistakes: [PathCourseMistake] {
        PathCourseMistakeRecorder.activeMistakes(in: lessonProgress, chapterID: chapter.id)
    }

    var progressFraction: Double {
        guard !steps.isEmpty else { return 0 }
        return min(1, Double(chapterProgress.stepIndex) / Double(steps.count))
    }

    var quizChineseItem: PathVocabularyItem? {
        guard chapterProgress.quizChineseIndex < quizVocabularyItems.count else { return nil }
        return quizVocabularyItems[chapterProgress.quizChineseIndex]
    }

    var quizTranslationItem: PathVocabularyItem? {
        guard chapterProgress.quizTranslationIndex < quizVocabularyItems.count else { return nil }
        return quizVocabularyItems[chapterProgress.quizTranslationIndex]
    }

    var chapterExamples: [PathExample] {
        chapter.examplesInSections
    }

    var currentExample: PathExample? {
        guard chapterProgress.exampleIndex < chapterExamples.count else { return nil }
        return chapterExamples[chapterProgress.exampleIndex]
    }

    func advance() {
        resetTransientState()

        if case .mistakeReview = currentStep, !activeMistakes.isEmpty {
            return
        }

        if case .chapterComplete = currentStep {
            pathStore.completeChapter(lessonID: lesson.id, chapterID: chapter.id, lesson: lesson)
            refreshProgress()
            return
        }

        if case .completion = currentStep {
            pathStore.completeChapter(lessonID: lesson.id, chapterID: chapter.id, lesson: lesson)
            refreshProgress()
            return
        }

        guard chapterProgress.stepIndex < steps.count - 1 else { return }

        updateChapterProgress { progress in
            progress.stepIndex += 1
            resetSubindices(&progress, for: steps[progress.stepIndex])
        }
        prepareQuizOptionsIfNeeded()
        skipEmptyStepsIfNeeded()
    }

    func selectChineseQuizAnswer(_ answer: String) {
        guard let item = quizChineseItem, !showFeedback else { return }
        selectedAnswer = answer
        let correct = answer == item.localizedTranslation
        registerQuizResult(item: item, correct: correct, kind: .quizChinese)
    }

    func continueAfterChineseQuiz() {
        guard quizChineseItem != nil else {
            advance()
            return
        }
        resetTransientState()
        if chapterProgress.quizChineseIndex < quizVocabularyItems.count - 1 {
            updateChapterProgress { $0.quizChineseIndex += 1 }
            prepareChineseQuizOptions()
        } else {
            advance()
        }
    }

    func selectTranslationQuizAnswer(_ item: PathVocabularyItem) {
        guard let target = quizTranslationItem, !showFeedback else { return }
        selectedAnswer = item.id
        let correct = item.id == target.id
        registerQuizResult(item: target, correct: correct, kind: .quizTranslation)
    }

    func continueAfterTranslationQuiz() {
        guard quizTranslationItem != nil else {
            advance()
            return
        }
        resetTransientState()
        if chapterProgress.quizTranslationIndex < quizVocabularyItems.count - 1 {
            updateChapterProgress { $0.quizTranslationIndex += 1 }
            prepareTranslationQuizOptions()
        } else {
            advance()
        }
    }

    func continueAfterExample() {
        if chapterProgress.exampleIndex < chapterExamples.count - 1 {
            updateChapterProgress { $0.exampleIndex += 1 }
        } else {
            advance()
        }
    }

    func toggleToken(_ tokenID: String, activity: PathSentenceBuilderActivity) {
        if let index = selectedTokenIDs.firstIndex(of: tokenID) {
            selectedTokenIDs.remove(at: index)
        } else if selectedTokenIDs.count < activity.correctOrder.count {
            selectedTokenIDs.append(tokenID)
        }
    }

    func submitSentenceBuilder(_ activity: PathSentenceBuilderActivity) {
        let correct = PathSentenceBuilderEvaluator.isCorrect(
            selectedOrder: selectedTokenIDs,
            activity: activity
        )
        presentAnswerFeedback(
            correct: correct,
            speechHanzi: activity.resultHanzi,
            explanation: activity.explanation
        )
        if !correct {
            recordActivityMistake(
                relatedVocabularyID: nil,
                fallbackHanzi: activity.resultHanzi,
                kind: .sentenceBuilder
            )
        }
    }

    func submitFillBlank(_ activity: PathFillBlankActivity, option: String) {
        selectedAnswer = option
        let correct = PathFillBlankEvaluator.isCorrect(selected: option, activity: activity)
        presentAnswerFeedback(
            correct: correct,
            speechHanzi: activity.resultHanzi,
            explanation: activity.explanation
        )
        if !correct {
            recordActivityMistake(
                relatedVocabularyID: activity.relatedVocabularyID,
                fallbackHanzi: activity.correctOption,
                kind: .fillBlank
            )
        }
    }

    func moveLine(_ lineID: String, in activity: PathDialogueOrderActivity) {
        if let index = selectedLineOrder.firstIndex(of: lineID) {
            selectedLineOrder.remove(at: index)
        } else {
            selectedLineOrder.append(lineID)
        }
    }

    func submitDialogueOrder(_ activity: PathDialogueOrderActivity) {
        let correct = PathDialogueOrderEvaluator.isCorrect(
            selectedOrder: selectedLineOrder,
            activity: activity
        )
        let spokenHanzi = activity.correctOrder.compactMap { lineID in
            activity.lines.first(where: { $0.id == lineID })?.hanzi
        }.first ?? activity.resultHanzi
        presentAnswerFeedback(
            correct: correct,
            speechHanzi: spokenHanzi,
            explanation: activity.explanation
        )
        if !correct {
            recordActivityMistake(
                relatedVocabularyID: nil,
                fallbackHanzi: activity.lines.first?.hanzi ?? "dialogue",
                kind: .dialogueOrder
            )
        }
    }

    func continueAfterActivity() {
        resetTransientState()
        advance()
    }

    func submitMistakeQuiz(item: PathVocabularyItem, answer: String) {
        let correct = answer == item.localizedTranslation
        presentAnswerFeedback(
            correct: correct,
            speechHanzi: item.hanzi,
            explanation: PathActivityExplanationBuilder.vocabulary(item: item)
        )
        if correct, let mistake = activeMistakes.first(where: { $0.vocabularyID == item.id }) {
            updateLessonProgress { progress in
                PathCourseMistakeRecorder.markRemediated(
                    mistakeID: mistake.id,
                    progress: &progress,
                    smartReviewStore: smartReviewStore,
                    lessonID: lesson.id
                )
            }
        }
    }

    func continueAfterMistakeReview() {
        resetTransientState()
        if activeMistakes.isEmpty {
            advance()
        }
    }

    private func registerQuizResult(item: PathVocabularyItem, correct: Bool, kind: PathMistakeKind) {
        presentAnswerFeedback(
            correct: correct,
            speechHanzi: item.hanzi,
            explanation: PathActivityExplanationBuilder.vocabulary(item: item)
        )
        updateChapterProgress { progress in
            if kind == .quizChinese {
                progress.chineseQuizResults[item.id] = correct
            } else {
                progress.translationQuizResults[item.id] = correct
            }
        }
        if !correct {
            updateLessonProgress { progress in
                PathCourseMistakeRecorder.recordMistake(
                    item: item,
                    lesson: lesson,
                    chapter: chapter,
                    kind: kind,
                    progress: &progress,
                    smartReviewStore: smartReviewStore
                )
            }
        }
    }

    private func presentAnswerFeedback(
        correct: Bool,
        speechHanzi: String,
        explanation: PathLocalizedText?
    ) {
        lastAnswerCorrect = correct
        showFeedback = true
        feedbackExplanation = explanation?.localizedValue()
        if correct {
            HapticService.success()
        } else {
            HapticService.rigid()
        }
        SpeechService.shared.speakIfAudible(speechHanzi)
    }

    private func recordActivityMistake(
        relatedVocabularyID: String?,
        fallbackHanzi: String,
        kind: PathMistakeKind
    ) {
        let item: PathVocabularyItem? = {
            if let relatedVocabularyID,
               let match = chapter.vocabularyItems.first(where: { $0.id == relatedVocabularyID }) {
                return match
            }
            if let exact = chapter.vocabularyItems.first(where: { $0.hanzi == fallbackHanzi }) {
                return exact
            }
            return chapter.vocabularyItems.first(where: {
                fallbackHanzi.contains($0.hanzi) && $0.hanzi.count >= 1
            }) ?? chapter.vocabularyItems.first
        }()

        guard let item else { return }

        updateLessonProgress { progress in
            PathCourseMistakeRecorder.recordMistake(
                item: item,
                lesson: lesson,
                chapter: chapter,
                kind: kind,
                progress: &progress,
                smartReviewStore: smartReviewStore
            )
        }
    }

    private func skipEmptyStepsIfNeeded() {
        var safety = 0
        while safety < steps.count, shouldSkipCurrentStep() {
            safety += 1
            guard chapterProgress.stepIndex < steps.count - 1 else { break }
            updateChapterProgress { progress in
                progress.stepIndex += 1
                resetSubindices(&progress, for: steps[progress.stepIndex])
            }
        }
    }

    private func shouldSkipCurrentStep() -> Bool {
        guard let step = currentStep else { return false }
        switch step {
        case .quizChineseToTranslation:
            return quizChineseItem == nil
        case .quizTranslationToChinese:
            return quizTranslationItem == nil
        case .examples:
            return chapterExamples.isEmpty
        case .mistakeReview:
            return activeMistakes.isEmpty
        default:
            return false
        }
    }

    private func resetSubindices(_ progress: inout PathChapterProgress, for step: PathResolvedStep) {
        switch step {
        case .quizChineseToTranslation:
            progress.quizChineseIndex = 0
        case .quizTranslationToChinese:
            progress.quizTranslationIndex = 0
        case .examples:
            progress.exampleIndex = 0
        default:
            break
        }
    }

    private func resetTransientState() {
        selectedAnswer = nil
        selectedTokenIDs = []
        selectedLineOrder = []
        showFeedback = false
        feedbackExplanation = nil
    }

    private func clampProgressToValidRange() {
        let maxIndex = max(steps.count - 1, 0)
        if chapterProgress.stepIndex > maxIndex {
            updateChapterProgress { $0.stepIndex = maxIndex }
        }
    }

    private func refreshProgress() {
        lessonProgress = pathStore.lessonProgress(for: lesson.id)
        chapterProgress = pathStore.chapterProgress(for: lesson.id, chapterID: chapter.id)
    }

    private func updateChapterProgress(_ transform: (inout PathChapterProgress) -> Void) {
        pathStore.updateChapter(lesson.id, chapterID: chapter.id, transform: transform)
        refreshProgress()
    }

    private func updateLessonProgress(_ transform: (inout PathLessonProgress) -> Void) {
        pathStore.updateLesson(lesson.id, transform: transform)
        refreshProgress()
    }

    private func prepareQuizOptionsIfNeeded() {
        if case .quizChineseToTranslation = currentStep {
            prepareChineseQuizOptions()
        } else if case .quizTranslationToChinese = currentStep {
            prepareTranslationQuizOptions()
        }
    }

    private func prepareChineseQuizOptions() {
        guard let item = quizChineseItem else {
            currentChineseOptions = []
            return
        }
        let seed = optionSeed(index: chapterProgress.quizChineseIndex, mode: 1)
        let candidates = quizVocabularyItems.filter { $0.id != item.id }.map(\.localizedTranslation)
        currentChineseOptions = PathQuizOptionBuilder.translationOptions(
            correct: item.localizedTranslation,
            candidates: candidates,
            seed: seed
        )
    }

    private func prepareTranslationQuizOptions() {
        guard let item = quizTranslationItem else {
            currentTranslationOptions = []
            return
        }
        let seed = optionSeed(index: chapterProgress.quizTranslationIndex, mode: 2)
        let candidates = quizVocabularyItems.filter { $0.id != item.id }
        currentTranslationOptions = PathQuizOptionBuilder.vocabularyOptions(
            correct: item,
            candidates: candidates,
            seed: seed
        )
    }

    func mistakeQuizOptions(for item: PathVocabularyItem) -> [String] {
        let candidates = chapter.vocabularyItems
            .filter { $0.id != item.id }
            .map(\.localizedTranslation)
        return PathQuizOptionBuilder.translationOptions(
            correct: item.localizedTranslation,
            candidates: candidates,
            seed: optionSeed(index: 0, mode: 99)
        )
    }

    private func optionSeed(index: Int, mode: Int) -> UInt64 {
        var hasher = Hasher()
        hasher.combine(lesson.id)
        hasher.combine(chapter.id)
        hasher.combine(index)
        hasher.combine(mode)
        return UInt64(bitPattern: Int64(hasher.finalize()))
    }
}
