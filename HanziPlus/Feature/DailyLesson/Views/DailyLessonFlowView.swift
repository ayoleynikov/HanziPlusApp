//
//  DailyLessonFlowView.swift
//  HanziPlus
//

import SwiftUI

struct DailyLessonFlowView: View {

    @Environment(DailyLessonStore.self) private var lessonStore
    @Environment(LearnedWordsStore.self) private var learnedStore
    @Environment(SmartReviewStore.self) private var smartReviewStore
    @Environment(UserProfileStore.self) private var profileStore
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel: DailyLessonViewModel?

    var body: some View {
        Group {
            if let viewModel {
                content(viewModel)
            } else {
                ProgressView(L10n.string( "lesson.preparing"))
            }
        }
        .navigationTitle(L10n.string( "lesson.nav_title"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if viewModel == nil {
                viewModel = DailyLessonViewModel(
                    lessonStore: lessonStore,
                    learnedStore: learnedStore,
                    smartReviewStore: smartReviewStore,
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
                            wasCorrect: vm.lastAnswerCorrect,
                            onSelect: { vm.selectMeaning($0) },
                            onContinue: { vm.continueAfterMeaning() }
                        )
                    } else {
                        emptyLesson
                    }

                case .summary:
                    summary(vm)
                }
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.bottom, AppSpacing.medium)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if vm.session.phase != .summary {
                    Button(L10n.string( "common.close")) { dismiss() }
                        .accessibilityLabel(L10n.string( "lesson.a11y.close"))
                }
            }
        }
    }

    private var emptyLesson: some View {
        ContentUnavailableView(
            L10n.string( "lesson.empty.title"),
            systemImage: "text.book.closed",
            description: Text(l10n: "lesson.empty.desc")
        )
    }

    private func summary(_ vm: DailyLessonViewModel) -> some View {
        DailyLessonSummaryView(
            studySet: vm.studySet,
            learnedCount: vm.newlyLearnedCount,
            wordCount: vm.session.wordCount,
            meaningAccuracy: vm.session.meaningAccuracy(),
            mistakes: vm.mistakeWords,
            onDone: { dismiss() }
        )
    }

    private func stepLabel(for vm: DailyLessonViewModel) -> String {
        switch vm.session.phase {
        case .preview, .meaning:
            return "\(vm.session.currentIndex + 1) / \(vm.session.wordCount)"
        case .summary:
            return L10n.string( "common.done")
        }
    }
}
