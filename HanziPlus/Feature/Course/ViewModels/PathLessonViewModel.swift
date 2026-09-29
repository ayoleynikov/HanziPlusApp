//
//  PathLessonViewModel.swift
//  HanziPlus
//

import Foundation
import Observation

@Observable
@MainActor
final class PathLessonViewModel {

    let lesson: PathLesson
    private let pathStore: PathCourseStore
    private let steps: [PathResolvedStep]

    private(set) var lessonProgress: PathLessonProgress
    private(set) var currentChineseOptions: [String] = []
    private(set) var currentTranslationOptions: [PathVocabularyItem] = []
    private(set) var selectedAnswer: String?
    private(set) var showFeedback = false
    private(set) var lastAnswerCorrect = false

    init(lesson: PathLesson, pathStore: PathCourseStore) {
        self.lesson = lesson
        self.pathStore = pathStore
        self.steps = PathLessonFlowResolver.resolve(lesson)
        self.lessonProgress = pathStore.lessonProgress(for: lesson.id)
        pathStore.startLesson(lesson.id)
        clampProgressToValidRange()
        prepareQuizOptionsIfNeeded()
    }

    var currentStep: PathResolvedStep? {
        guard lessonProgress.stepIndex < steps.count else { return nil }
        return steps[lessonProgress.stepIndex]
    }

    var currentStepIndex: Int? {
        guard lessonProgress.stepIndex < steps.count else { return nil }
        return lessonProgress.stepIndex
    }

    var quizVocabulary: [PathVocabularyItem] {
        lesson.quizVocabulary
    }

    var quizChineseItem: PathVocabularyItem? {
        guard lessonProgress.quizChineseIndex < quizVocabulary.count else { return nil }
        return quizVocabulary[lessonProgress.quizChineseIndex]
    }

    var quizTranslationItem: PathVocabularyItem? {
        guard lessonProgress.quizTranslationIndex < quizVocabulary.count else { return nil }
        return quizVocabulary[lessonProgress.quizTranslationIndex]
    }

    var currentExample: PathExample? {
        let examples = lesson.examples
        guard lessonProgress.exampleIndex < examples.count else { return nil }
        return examples[lessonProgress.exampleIndex]
    }

    var progressFraction: Double {
        guard !steps.isEmpty else { return 0 }
        let base = Double(lessonProgress.stepIndex) / Double(steps.count)

        switch currentStep {
        case .quizChineseToTranslation:
            guard !quizVocabulary.isEmpty else { return base }
            let quizFraction = Double(lessonProgress.quizChineseIndex) / Double(quizVocabulary.count)
            return min(1, base + quizFraction * (1.0 / Double(steps.count)))
        case .quizTranslationToChinese:
            guard !quizVocabulary.isEmpty else { return base }
            let quizFraction = Double(lessonProgress.quizTranslationIndex) / Double(quizVocabulary.count)
            return min(1, base + quizFraction * (1.0 / Double(steps.count)))
        case .examples:
            let examples = lesson.examples
            guard !examples.isEmpty else { return base }
            let exampleFraction = Double(lessonProgress.exampleIndex) / Double(examples.count)
            return min(1, base + exampleFraction * (1.0 / Double(steps.count)))
        default:
            return min(1, base)
        }
    }

    func advance() {
        selectedAnswer = nil
        showFeedback = false

        if case .completion = currentStep {
            return
        }

        guard lessonProgress.stepIndex < steps.count - 1 else {
            if !lessonProgress.isCompleted {
                pathStore.completeLesson(lesson.id)
                lessonProgress = pathStore.lessonProgress(for: lesson.id)
            }
            return
        }

        updateProgress { progress in
            progress.stepIndex += 1
            if progress.stepIndex < steps.count {
                if case .quizChineseToTranslation = steps[progress.stepIndex] {
                    progress.quizChineseIndex = 0
                }
                if case .quizTranslationToChinese = steps[progress.stepIndex] {
                    progress.quizTranslationIndex = 0
                }
                if case .examples = steps[progress.stepIndex] {
                    progress.exampleIndex = 0
                }
            }
        }

        if case .completion = currentStep, !lessonProgress.isCompleted {
            pathStore.completeLesson(lesson.id)
            lessonProgress = pathStore.lessonProgress(for: lesson.id)
        }

        prepareQuizOptionsIfNeeded()
    }

    func selectChineseQuizAnswer(_ answer: String) {
        guard let item = quizChineseItem, !showFeedback else { return }
        selectedAnswer = answer
        let correct = answer == item.localizedTranslation
        lastAnswerCorrect = correct
        showFeedback = true
        updateProgress { progress in
            progress.chineseQuizResults[item.id] = correct
        }
        if correct {
            HapticService.success()
        } else {
            HapticService.rigid()
        }
    }

    func continueAfterChineseQuiz() {
        guard quizChineseItem != nil else { return }
        selectedAnswer = nil
        showFeedback = false

        if lessonProgress.quizChineseIndex < quizVocabulary.count - 1 {
            updateProgress { $0.quizChineseIndex += 1 }
            prepareChineseQuizOptions()
        } else {
            advance()
        }
    }

    func selectTranslationQuizAnswer(_ item: PathVocabularyItem) {
        guard let target = quizTranslationItem, !showFeedback else { return }
        selectedAnswer = item.id
        let correct = item.id == target.id
        lastAnswerCorrect = correct
        showFeedback = true
        updateProgress { progress in
            progress.translationQuizResults[target.id] = correct
        }
        if correct {
            HapticService.success()
        } else {
            HapticService.rigid()
        }
    }

    func continueAfterTranslationQuiz() {
        guard quizTranslationItem != nil else { return }
        selectedAnswer = nil
        showFeedback = false

        if lessonProgress.quizTranslationIndex < quizVocabulary.count - 1 {
            updateProgress { $0.quizTranslationIndex += 1 }
            prepareTranslationQuizOptions()
        } else {
            advance()
        }
    }

    func continueAfterExample() {
        let examples = lesson.examples
        if lessonProgress.exampleIndex < examples.count - 1 {
            updateProgress { $0.exampleIndex += 1 }
        } else {
            advance()
        }
    }

    func replayDialoguesFromComplete() {
        if let index = steps.firstIndex(where: {
            if case .dialogueRepeat = $0 { return true }
            return false
        }) {
            updateProgress { progress in
                progress.stepIndex = index
            }
        }
    }

    func restartLesson() {
        pathStore.restartLesson(lesson.id, keepCompleted: true)
        lessonProgress = pathStore.lessonProgress(for: lesson.id)
        selectedAnswer = nil
        showFeedback = false
        prepareQuizOptionsIfNeeded()
    }

    func returnToComplete() {
        if let index = steps.firstIndex(where: {
            if case .completion = $0 { return true }
            return false
        }) {
            updateProgress { progress in
                progress.stepIndex = index
            }
        }
    }

    private func clampProgressToValidRange() {
        let maxIndex = max(steps.count - 1, 0)
        if lessonProgress.stepIndex > maxIndex {
            updateProgress { $0.stepIndex = maxIndex }
        }
    }

    private func updateProgress(_ transform: (inout PathLessonProgress) -> Void) {
        pathStore.updateLesson(lesson.id) { progress in
            transform(&progress)
        }
        lessonProgress = pathStore.lessonProgress(for: lesson.id)
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
        let seed = optionSeed(index: lessonProgress.quizChineseIndex, mode: 1)
        let candidates = quizVocabulary
            .filter { $0.id != item.id }
            .map(\.localizedTranslation)
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
        let seed = optionSeed(index: lessonProgress.quizTranslationIndex, mode: 2)
        let candidates = quizVocabulary.filter { $0.id != item.id }
        currentTranslationOptions = PathQuizOptionBuilder.vocabularyOptions(
            correct: item,
            candidates: candidates,
            seed: seed
        )
    }

    private func optionSeed(index: Int, mode: Int) -> UInt64 {
        var hasher = Hasher()
        hasher.combine(lesson.id)
        hasher.combine(index)
        hasher.combine(mode)
        return UInt64(bitPattern: Int64(hasher.finalize()))
    }
}

enum PathQuizOptionBuilder {

    static func translationOptions(
        correct: String,
        candidates: [String],
        count: Int = 4,
        seed: UInt64
    ) -> [String] {
        let unique = Array(Set(candidates.filter { !$0.isEmpty && $0 != correct })).sorted()
        var options = [correct]
        for value in DailyLessonPlanner.seededShuffle(unique, seed: seed) {
            guard options.count < count else { break }
            if !options.contains(value) {
                options.append(value)
            }
        }
        return DailyLessonPlanner.seededShuffle(options, seed: seed &+ 99)
    }

    static func vocabularyOptions(
        correct: PathVocabularyItem,
        candidates: [PathVocabularyItem],
        count: Int = 4,
        seed: UInt64
    ) -> [PathVocabularyItem] {
        var options = [correct]
        for item in DailyLessonPlanner.seededShuffle(candidates, seed: seed) {
            guard options.count < count else { break }
            if !options.contains(where: { $0.id == item.id }) {
                options.append(item)
            }
        }
        return DailyLessonPlanner.seededShuffle(options, seed: seed &+ 99)
    }
}
