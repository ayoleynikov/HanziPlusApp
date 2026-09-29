//
//  PathLessonFlowView.swift
//  HanziPlus
//

import SwiftUI

struct PathLessonFlowView: View {

    @Environment(PathCourseStore.self) private var pathStore
    @Environment(SmartReviewStore.self) private var smartReviewStore
    @Environment(LanguageSettingsStore.self) private var languageStore

    let lesson: PathLesson
    var autoResumeChapter: Bool = false

    @State private var selectedChapter: PathLessonChapter?
    @State private var chapterViewModel: PathChapterViewModel?
    @State private var nextLessonID: String?
    @State private var replayDialogueIndex: Int?
    @State private var showsRestartConfirmation = false

    var body: some View {
        ZStack {
            if let index = replayDialogueIndex, index < lesson.dialogues.count {
                replayDialogueContent(at: index)
            } else if let chapterViewModel {
                chapterContent(chapterViewModel)
            } else {
                PathChapterMapView(
                    lesson: lesson,
                    onSelectChapter: { chapter in
                        selectedChapter = chapter
                        chapterViewModel = PathChapterViewModel(
                            lesson: lesson,
                            chapter: chapter,
                            pathStore: pathStore,
                            smartReviewStore: smartReviewStore
                        )
                    },
                    onContinue: {
                        if let chapter = pathStore.currentChapter(for: lesson) {
                            selectedChapter = chapter
                            chapterViewModel = PathChapterViewModel(
                                lesson: lesson,
                                chapter: chapter,
                                pathStore: pathStore,
                                smartReviewStore: smartReviewStore
                            )
                        }
                    }
                )
            }
        }
        .navigationTitle("\(PathStrings.lessonPrefix) \(lesson.number)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            if chapterViewModel == nil, hasLessonProgress {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showsRestartConfirmation = true
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 32, height: 32)
                            .background(Circle().fill(Color.red))
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(PathStrings.retryLesson)
                    .accessibilityIdentifier("path_restart_lesson_button")
                }
            }
        }
        .confirmationDialog(
            PathStrings.retryLessonConfirmTitle,
            isPresented: $showsRestartConfirmation,
            titleVisibility: .visible
        ) {
            Button(PathStrings.retryLesson, role: .destructive) {
                restartLesson()
            }
            Button(L10n.string("common.cancel"), role: .cancel) {}
        } message: {
            Text(PathStrings.retryLessonConfirmMessage)
        }
        .id(languageStore.refreshToken)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("path_lesson_flow")
        .navigationDestination(item: $nextLessonID) { lessonID in
            if let summary = pathStore.course?.lessons.first(where: { $0.id == lessonID }),
               let contentFile = summary.contentFile,
               let loadedLesson = PathCourseLoader.loadLesson(fileName: contentFile) {
                PathLessonFlowView(lesson: loadedLesson)
            }
        }
        .onAppear {
            pathStore.startLesson(lesson.id)
            resumeChapterIfNeeded()
        }
    }

    private func resumeChapterIfNeeded() {
        guard autoResumeChapter, chapterViewModel == nil else { return }
        guard let chapter = pathStore.currentChapter(for: lesson) else { return }
        selectedChapter = chapter
        chapterViewModel = PathChapterViewModel(
            lesson: lesson,
            chapter: chapter,
            pathStore: pathStore,
            smartReviewStore: smartReviewStore
        )
    }

    @ViewBuilder
    private func chapterContent(_ vm: PathChapterViewModel) -> some View {
        VStack(spacing: AppSpacing.medium) {
            Button(PathStrings.backToChapters) {
                chapterViewModel = nil
                selectedChapter = nil
            }
            .font(.subheadline.weight(.semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: 44)
            .accessibilityIdentifier("path_back_to_chapters_button")

            if !isTerminalStep(vm) {
                progressHeader(vm)
            }

            Group {
                switch vm.currentStep {
                case .toneGuide(let guide):
                    PathToneGuideView(guide: guide, onContinue: { vm.advance() })

                case .dialogue(let dialogue, let continueTitle, let showHeader):
                    PathDialogueView(
                        lesson: lesson,
                        dialogue: dialogue,
                        title: dialogue.title,
                        buttonTitle: continueTitle,
                        showLessonHeader: showHeader,
                        highlightVocabulary: chapterVocabulary(vm.chapter),
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
                        highlightVocabulary: vm.chapter.vocabularyItems,
                        onContinue: { vm.advance() }
                    )

                case .grammar(let card):
                    PathGrammarCardView(card: card, onContinue: { vm.advance() })

                case .sentenceBuilder(let activity):
                    PathSentenceBuilderView(
                        activity: activity,
                        selectedTokenIDs: vm.selectedTokenIDs,
                        showFeedback: vm.showFeedback,
                        wasCorrect: vm.lastAnswerCorrect,
                        explanation: vm.feedbackExplanation,
                        onToggleToken: { vm.toggleToken($0, activity: activity) },
                        onSubmit: { vm.submitSentenceBuilder(activity) },
                        onContinue: { vm.continueAfterActivity() }
                    )

                case .fillBlank(let activity):
                    PathFillBlankView(
                        activity: activity,
                        selectedAnswer: vm.selectedAnswer,
                        showFeedback: vm.showFeedback,
                        wasCorrect: vm.lastAnswerCorrect,
                        explanation: vm.feedbackExplanation,
                        onSelect: { vm.submitFillBlank(activity, option: $0) },
                        onContinue: { vm.continueAfterActivity() }
                    )

                case .dialogueOrder(let activity):
                    PathDialogueOrderView(
                        activity: activity,
                        selectedOrder: vm.selectedLineOrder,
                        showFeedback: vm.showFeedback,
                        wasCorrect: vm.lastAnswerCorrect,
                        explanation: vm.feedbackExplanation,
                        onToggleLine: { vm.moveLine($0, in: activity) },
                        onSubmit: { vm.submitDialogueOrder(activity) },
                        onContinue: { vm.continueAfterActivity() }
                    )

                case .quizChineseToTranslation:
                    if let item = vm.quizChineseItem {
                        PathChineseQuizView(
                            item: item,
                            options: vm.currentChineseOptions,
                            selectedAnswer: vm.selectedAnswer,
                            showFeedback: vm.showFeedback,
                            wasCorrect: vm.lastAnswerCorrect,
                            explanation: vm.feedbackExplanation,
                            onSelect: { vm.selectChineseQuizAnswer($0) },
                            onContinue: { vm.continueAfterChineseQuiz() }
                        )
                    } else {
                        PathTransitionView(text: PathStrings.next, onContinue: { vm.advance() })
                    }

                case .quizTranslationToChinese:
                    if let item = vm.quizTranslationItem {
                        PathTranslationQuizView(
                            item: item,
                            options: vm.currentTranslationOptions,
                            selectedAnswerID: vm.selectedAnswer,
                            showFeedback: vm.showFeedback,
                            wasCorrect: vm.lastAnswerCorrect,
                            explanation: vm.feedbackExplanation,
                            onSelect: { vm.selectTranslationQuizAnswer($0) },
                            onContinue: { vm.continueAfterTranslationQuiz() }
                        )
                    } else {
                        PathTransitionView(text: PathStrings.next, onContinue: { vm.advance() })
                    }

                case .examples:
                    if let example = vm.currentExample {
                        PathExamplesView(
                            example: example,
                            showsGroupHeader: false,
                            index: vm.chapterProgress.exampleIndex,
                            total: vm.chapterExamples.count,
                            onContinue: { vm.continueAfterExample() }
                        )
                    }

                case .mistakeReview:
                    if let mistake = vm.activeMistakes.first(where: { !$0.isRemediated }),
                       let item = vm.chapter.vocabularyItems.first(where: { $0.id == mistake.vocabularyID }) {
                        PathMistakeReviewView(
                            mistakes: vm.activeMistakes,
                            item: item,
                            options: vm.mistakeQuizOptions(for: item),
                            selectedAnswer: vm.selectedAnswer,
                            showFeedback: vm.showFeedback,
                            wasCorrect: vm.lastAnswerCorrect,
                            explanation: vm.feedbackExplanation,
                            onSelect: { vm.submitMistakeQuiz(item: item, answer: $0) },
                            onContinue: { vm.continueAfterMistakeReview() }
                        )
                    } else {
                        Color.clear
                            .onAppear { vm.continueAfterMistakeReview() }
                    }

                case .chapterComplete:
                    PathChapterCompleteView(
                        chapter: vm.chapter,
                        wordCount: vm.chapter.vocabularyItems.filter(\.countsInLessonTotal).count,
                        mistakesReviewed: vm.activeMistakes.filter(\.isRemediated).count
                    ) {
                        chapterViewModel = nil
                        selectedChapter = nil
                    }
                    .onAppear { vm.advance() }

                case .completion:
                    PathLessonCompleteView(
                        lesson: lesson,
                        onReplayDialogues: {
                            replayDialogueIndex = lesson.dialogues.isEmpty ? nil : 0
                        },
                        onRetryLesson: {
                            pathStore.restartLesson(lesson.id, keepCompleted: false)
                            chapterViewModel = nil
                            selectedChapter = nil
                            replayDialogueIndex = nil
                        },
                        onNextLesson: nextLessonSummary == nil ? nil : {
                            nextLessonID = nextLessonSummary?.id
                        }
                    )
                    .onAppear { vm.advance() }

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

    private func replayDialogueContent(at index: Int) -> some View {
        let dialogue = lesson.dialogues[index]
        return PathDialogueView(
            lesson: lesson,
            dialogue: dialogue,
            title: dialogue.title,
            buttonTitle: index < lesson.dialogues.count - 1 ? PathStrings.next : PathStrings.backToChapters,
            showLessonHeader: false,
            highlightVocabulary: lesson.allVocabulary,
            onContinue: {
                if index < lesson.dialogues.count - 1 {
                    replayDialogueIndex = index + 1
                } else {
                    replayDialogueIndex = nil
                }
            }
        )
    }

    private func isTerminalStep(_ vm: PathChapterViewModel) -> Bool {
        switch vm.currentStep {
        case .completion, .chapterComplete:
            return true
        default:
            return false
        }
    }

    private func progressHeader(_ vm: PathChapterViewModel) -> some View {
        PathFlowStepHeader(
            chapterTitle: vm.chapter.localizedTitle,
            progress: vm.progressFraction
        )
        .padding(.horizontal, AppSpacing.medium)
        .padding(.top, AppSpacing.small)
    }

    private func restartLesson() {
        pathStore.restartLesson(lesson.id, keepCompleted: false)
        chapterViewModel = nil
        selectedChapter = nil
        replayDialogueIndex = nil
    }

    private var hasLessonProgress: Bool {
        guard let progress = pathStore.progress.lessonProgress[lesson.id] else { return false }
        return progress.isCompleted
            || !progress.chapterProgress.isEmpty
            || progress.currentChapterID != nil
    }

    private func chapterVocabulary(_ chapter: PathLessonChapter) -> [PathVocabularyItem] {
        chapter.vocabularyItems
    }

    private var nextLessonSummary: PathLessonSummary? {
        guard let course = pathStore.course else { return nil }
        guard let index = course.lessons.firstIndex(where: { $0.id == lesson.id }) else { return nil }
        return course.lessons[(index + 1)...].first(where: { $0.isAvailable && $0.contentFile != nil })
    }
}

private extension PathLessonChapter {
    var localizedTitle: String { title.localizedValue() }
}

#Preview {
    NavigationStack {
        PathLessonFlowView(lesson: PathCourseLoader.previewLesson())
            .environment(PathCourseStore())
            .environment(SmartReviewStore())
    }
}
