//
//  DailyLessonFlowView.swift
//  HanziPlus
//

import SwiftUI

struct DailyLessonFlowView: View {

    @Environment(DailyLessonStore.self) private var lessonStore
    @Environment(LearnedWordsStore.self) private var learnedStore
    @Environment(UserProfileStore.self) private var profileStore
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel: DailyLessonViewModel?

    var body: some View {
        Group {
            if let viewModel {
                content(viewModel)
            } else {
                ProgressView("Preparing lesson…")
            }
        }
        .navigationTitle("Today’s Lesson")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if viewModel == nil {
                viewModel = DailyLessonViewModel(
                    lessonStore: lessonStore,
                    learnedStore: learnedStore,
                    profile: profileStore.profile
                )
            }
        }
    }

    @ViewBuilder
    private func content(_ vm: DailyLessonViewModel) -> some View {
        VStack(spacing: AppSpacing.medium) {
            if vm.session.phase != .summary {
                DailyLessonProgressHeader(
                    phaseTitle: vm.phaseTitle,
                    stepLabel: stepLabel(for: vm),
                    progress: vm.session.progressFraction
                )
                .padding(.horizontal, AppSpacing.medium)
            }

            Group {
                switch vm.session.phase {
                case .preview:
                    if let word = vm.currentWord {
                        DailyLessonPreviewView(
                            word: word,
                            index: vm.session.currentIndex,
                            total: vm.session.wordCount,
                            onContinue: { vm.advanceFromPreview() }
                        )
                    } else {
                        emptyLesson
                    }

                case .meaning:
                    if let word = vm.currentWord {
                        DailyLessonMeaningView(
                            word: word,
                            options: vm.meaningOptions,
                            selectedAnswer: vm.selectedAnswer,
                            showFeedback: vm.showFeedback,
                            onSelect: { vm.selectMeaning($0) },
                            onContinue: { vm.continueAfterMeaning() }
                        )
                    } else {
                        emptyLesson
                    }

                case .listening:
                    if let word = vm.currentWord {
                        DailyLessonListeningView(
                            word: word,
                            options: vm.listeningOptions,
                            selectedAnswer: vm.selectedAnswer,
                            showFeedback: vm.showFeedback,
                            onSelect: { vm.selectListening($0) },
                            onContinue: { vm.continueAfterListening() }
                        )
                        .id(word.hanzi)
                    } else {
                        emptyLesson
                    }

                case .summary:
                    DailyLessonSummaryView(
                        learnedCount: vm.newlyLearnedCount,
                        wordCount: vm.session.wordCount,
                        meaningAccuracy: vm.session.meaningAccuracy(),
                        listeningAccuracy: vm.session.listeningAccuracy(),
                        mistakes: vm.mistakeWords,
                        onReviewMistakes: { vm.startReviewMistakes() },
                        onDone: { dismiss() }
                    )

                case .reviewMistakes:
                    if let word = vm.currentWord {
                        DailyLessonReviewMistakesView(
                            word: word,
                            options: vm.meaningOptions,
                            selectedAnswer: vm.selectedAnswer,
                            showFeedback: vm.showFeedback,
                            onSelect: { vm.selectMeaning($0) },
                            onContinue: { vm.continueAfterMeaning() }
                        )
                    } else {
                        emptyLesson
                    }
                }
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.bottom, AppSpacing.medium)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if vm.session.phase != .summary {
                    Button("Close") { dismiss() }
                        .accessibilityLabel("Close lesson and continue later")
                }
            }
        }
    }

    private var emptyLesson: some View {
        ContentUnavailableView(
            "No words available",
            systemImage: "text.book.closed",
            description: Text("Try another study set from Learn.")
        )
    }

    private func stepLabel(for vm: DailyLessonViewModel) -> String {
        let total: Int
        let index: Int
        switch vm.session.phase {
        case .preview, .meaning, .listening:
            total = vm.session.wordCount
            index = vm.session.currentIndex + 1
        case .reviewMistakes:
            total = max(vm.reviewQueue.count, 1)
            index = vm.session.currentIndex + 1
        case .summary:
            return "Done"
        }
        return "\(index) / \(total)"
    }
}
