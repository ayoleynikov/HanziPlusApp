//
//  PathLessonFlowView.swift
//  HanziPlus
//

import SwiftUI

struct PathLessonFlowView: View {

    @Environment(PathCourseStore.self) private var pathStore
    @Environment(LanguageSettingsStore.self) private var languageStore

    let lesson: PathLesson

    @State private var viewModel: PathLessonViewModel?
    @State private var nextLessonID: String?

    var body: some View {
        Group {
            if let viewModel {
                content(viewModel)
            } else {
                ProgressView()
            }
        }
        .navigationTitle("\(PathStrings.lessonPrefix) \(lesson.number)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            if viewModel == nil {
                viewModel = PathLessonViewModel(lesson: lesson, pathStore: pathStore)
            }
        }
        .id(languageStore.refreshToken)
        .accessibilityIdentifier("path_lesson_flow")
        .navigationDestination(item: $nextLessonID) { lessonID in
            if let summary = pathStore.course?.lessons.first(where: { $0.id == lessonID }),
               let contentFile = summary.contentFile,
               let loadedLesson = PathCourseLoader.loadLesson(fileName: contentFile) {
                PathLessonFlowView(lesson: loadedLesson)
            }
        }
    }

    @ViewBuilder
    private func content(_ vm: PathLessonViewModel) -> some View {
        VStack(spacing: AppSpacing.medium) {
            if !isCompletionStep(vm) {
                progressHeader(vm)
            }

            Group {
                switch vm.currentStep {
                case .dialogue(let dialogue, let continueTitle, let showHeader):
                    PathDialogueView(
                        lesson: lesson,
                        dialogue: dialogue,
                        title: dialogue.title,
                        buttonTitle: continueTitle,
                        showLessonHeader: showHeader,
                        highlightVocabulary: studiedVocabulary(before: vm),
                        onContinue: { vm.advance() }
                    )

                case .transition(let text):
                    PathTransitionView(text: text, onContinue: { vm.advance() })

                case .vocabularyItem(let item, let groupTitle, let index, let total):
                    PathVocabularyStudyView(
                        item: item,
                        sectionTitle: groupTitle,
                        index: index,
                        total: total,
                        onContinue: { vm.advance() }
                    )

                case .vocabularySummary:
                    PathVocabularySummaryView(
                        groups: lesson.resolvedVocabularySummaryGroups(),
                        outsideDialogueWords: PathDialogueVocabularyHelper.vocabularyNotInDialogues(
                            lesson: lesson,
                            dialogues: lesson.dialogues
                        ),
                        onContinue: { vm.advance() }
                    )

                case .dialogueRepeat(let dialogue, let title):
                    PathDialogueView(
                        lesson: lesson,
                        dialogue: dialogue,
                        title: title,
                        buttonTitle: PathStrings.next,
                        showLessonHeader: false,
                        highlightVocabulary: lesson.allVocabulary,
                        onContinue: {
                            if vm.lessonProgress.isCompleted {
                                vm.returnToComplete()
                            } else {
                                vm.advance()
                            }
                        }
                    )

                case .quizChineseToTranslation:
                    if let item = vm.quizChineseItem {
                        PathChineseQuizView(
                            item: item,
                            options: vm.currentChineseOptions,
                            selectedAnswer: vm.selectedAnswer,
                            showFeedback: vm.showFeedback,
                            wasCorrect: vm.lastAnswerCorrect,
                            onSelect: { vm.selectChineseQuizAnswer($0) },
                            onContinue: { vm.continueAfterChineseQuiz() }
                        )
                    }

                case .quizTranslationToChinese:
                    if let item = vm.quizTranslationItem {
                        PathTranslationQuizView(
                            item: item,
                            options: vm.currentTranslationOptions,
                            selectedAnswerID: vm.selectedAnswer,
                            showFeedback: vm.showFeedback,
                            wasCorrect: vm.lastAnswerCorrect,
                            onSelect: { vm.selectTranslationQuizAnswer($0) },
                            onContinue: { vm.continueAfterTranslationQuiz() }
                        )
                    }

                case .examples:
                    if let example = vm.currentExample {
                        let exampleIndex = vm.lessonProgress.exampleIndex
                        let previousGroup = exampleIndex > 0
                            ? lesson.examples[exampleIndex - 1].group
                            : nil
                        PathExamplesView(
                            example: example,
                            showsGroupHeader: example.group != previousGroup,
                            index: exampleIndex,
                            total: lesson.examples.count,
                            onContinue: { vm.continueAfterExample() }
                        )
                    }

                case .completion:
                    PathLessonCompleteView(
                        lesson: lesson,
                        onReplayDialogues: { vm.replayDialoguesFromComplete() },
                        onRetryLesson: {
                            vm.restartLesson()
                        },
                        onNextLesson: nextLessonSummary == nil ? nil : {
                            nextLessonID = nextLessonSummary?.id
                        }
                    )

                case .none:
                    ContentUnavailableView(
                        PathStrings.lessonUnavailable,
                        systemImage: "exclamationmark.triangle"
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, AppSpacing.medium)
            .padding(.bottom, AppSpacing.medium)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }

    private func isCompletionStep(_ vm: PathLessonViewModel) -> Bool {
        if case .completion = vm.currentStep { return true }
        return false
    }

    private func progressHeader(_ vm: PathLessonViewModel) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            ProgressView(value: vm.progressFraction)
                .tint(.teal)
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.top, AppSpacing.small)
    }

    private var nextLessonSummary: PathLessonSummary? {
        guard let course = pathStore.course else { return nil }
        guard let index = course.lessons.firstIndex(where: { $0.id == lesson.id }) else { return nil }

        return course.lessons[(index + 1)...].first(where: {
            $0.isAvailable && $0.contentFile != nil
        })
    }

    private func studiedVocabulary(before vm: PathLessonViewModel) -> [PathVocabularyItem] {
        guard let stepIndex = vm.currentStepIndex else { return [] }

        var items: [PathVocabularyItem] = []
        let steps = PathLessonFlowResolver.resolve(lesson)

        for index in 0..<stepIndex {
            if case .vocabularyItem(let item, _, _, _) = steps[index] {
                items.append(item)
            }
        }

        return items
    }
}

#Preview {
    NavigationStack {
        PathLessonFlowView(lesson: PathCourseLoader.previewLesson())
            .environment(PathCourseStore())
    }
}
