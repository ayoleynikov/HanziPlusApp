//
//  StudyView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct StudyView: View {

    @State private var isFlipped = false
    @State private var navigationTrigger: StudyNavigationDirection?
    @State private var viewModel: StudyViewModel?
    @State private var showCompletion = false
    @State private var showLearnedReview = false
    @State private var isLearnFlowActive = false
    @State private var learnFlowTask: Task<Void, Never>?

    let studySet: StudySet
    var studySection: StudySetSection? = nil

    @Environment(\.dismiss) private var dismiss
    @Environment(FavoritesStore.self) private var favorites
    @Environment(WordCatalog.self) private var catalog
    @Environment(LearnedWordsStore.self) private var learnedStore
    @Environment(StudySessionStore.self) private var sessionStore
    @Environment(SmartReviewStore.self) private var smartReviewStore

    var body: some View {
        Group {
            if let viewModel {
                studyContent(viewModel: viewModel)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemGroupedBackground))
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = StudyViewModel(
                    studySet: studySet,
                    studySection: studySection,
                    sessionStore: sessionStore
                )
            }
        }
        .onDisappear {
            learnFlowTask?.cancel()
            viewModel?.persistSession()
        }
    }

    @ViewBuilder
    private func studyContent(viewModel: StudyViewModel) -> some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            if showCompletion {
                StudyCompletionView(
                    studySet: viewModel.studySet,
                    sectionTitle: studySection?.title,
                    totalWords: totalWords(for: viewModel),
                    onReviewLearned: {
                        showCompletion = false
                        showLearnedReview = true
                    },
                    onStartAgain: {
                        restartSession()
                    },
                    onBackToSets: {
                        dismiss()
                    }
                )
                .transition(.opacity.combined(with: .scale(scale: 0.96)))
            } else if viewModel.hasWords, let currentWord = viewModel.currentWord {
                activeStudyContent(viewModel: viewModel, currentWord: currentWord)
                    .transition(.opacity)
            } else {
                ContentUnavailableView(
                    L10n.string( "study.empty.title"),
                    systemImage: "exclamationmark.triangle",
                    description: Text(l10n: "study.empty.desc")
                )
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.86), value: showCompletion)
        .navigationTitle(navigationTitle(for: viewModel))
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showLearnedReview) {
            LearnedWordsReviewView(studySet: viewModel.studySet)
        }
    }

    @ViewBuilder
    private func activeStudyContent(viewModel: StudyViewModel, currentWord: Word) -> some View {
        let learnedCount = learnedCount(for: viewModel)

        ScrollView {
            VStack(spacing: 0) {
                StudyProgressHeader(
                    currentCardIndex: viewModel.currentIndex,
                    learnedCount: learnedCount,
                    total: totalWords(for: viewModel),
                    tint: viewModel.studySet.color
                )
                .padding(.horizontal, AppSpacing.medium)
                .padding(.top, AppSpacing.small)
                .padding(.bottom, AppSpacing.medium)

                StudyCard(
                    word: currentWord,
                    isFlipped: $isFlipped,
                    navigationTrigger: $navigationTrigger,
                    canGoNext: viewModel.canGoNext,
                    canGoPrevious: viewModel.canGoPrevious,
                    onNavigate: { direction in
                        navigate(viewModel: viewModel, direction: direction)
                    }
                )
                .padding(.horizontal, AppSpacing.medium)
                .id(viewModel.currentIndex)
                .transition(
                    .asymmetric(
                        insertion: .opacity.combined(with: .scale(scale: 0.97)),
                        removal: .opacity
                    )
                )

                MarkAsLearnedButton(
                    isLearned: learnedStore.isLearned(
                        word: currentWord,
                        in: viewModel.studySet
                    ),
                    isDisabled: isLearnFlowActive,
                    action: {
                        handleLearnedTap(viewModel: viewModel, word: currentWord)
                    }
                )
                .padding(.top, AppSpacing.medium)
                .padding(.bottom, AppSpacing.small)

                Text(l10n: "study.hint.flip_swipe")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                    .padding(.bottom, AppSpacing.small)

                StudyControlBar(
                    isFavorite: favorites.isFavorite(currentWord),
                    canGoPrevious: viewModel.canGoPrevious,
                    canGoNext: viewModel.canGoNext,
                    onPrevious: {
                        navigationTrigger = .previous
                    },
                    onAudio: {
                        HapticService.light()
                        SpeechService.shared.speak(currentWord.hanzi)
                    },
                    onFavorite: {
                        HapticService.light()
                        withAnimation(.spring(response: 0.32, dampingFraction: 0.72)) {
                            favorites.toggle(currentWord)
                        }
                    },
                    onNext: {
                        navigationTrigger = .next
                    }
                )
                .padding(.horizontal, AppSpacing.medium)
                .padding(.bottom, AppSpacing.medium)
            }
        }
        .scrollIndicators(.hidden)
    }

    @discardableResult
    private func navigate(viewModel: StudyViewModel, direction: StudyNavigationDirection) -> Bool {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.88)) {
            isFlipped = false
        }

        let succeeded = viewModel.go(to: direction)

        if succeeded {
            HapticService.light()
        }

        return succeeded
    }

    private func handleLearnedTap(viewModel: StudyViewModel, word: Word) {
        guard !isLearnFlowActive else { return }

        let wasLearned = learnedStore.isLearned(word: word, in: viewModel.studySet)

        if wasLearned {
            _ = learnedStore.toggle(word: word, in: viewModel.studySet)
            smartReviewStore.recordAttempt(
                fileName: viewModel.studySet.fileName,
                hanzi: word.hanzi,
                correct: false
            )
            HapticService.light()
            return
        }

        isLearnFlowActive = true
        _ = learnedStore.toggle(word: word, in: viewModel.studySet)
        smartReviewStore.recordAttempt(
            fileName: viewModel.studySet.fileName,
            hanzi: word.hanzi,
            correct: true
        )
        HapticService.success()

        let total = totalWords(for: viewModel)
        let learned = learnedCount(for: viewModel)
        let isSetComplete = learned >= total

        learnFlowTask?.cancel()
        learnFlowTask = Task { @MainActor in
            try? await Task.sleep(for: .seconds(0.6))
            guard !Task.isCancelled else { return }

            if isSetComplete {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.82)) {
                    showCompletion = true
                }
            } else if viewModel.canGoNext {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.88)) {
                    isFlipped = false
                }
                navigationTrigger = .next
            }

            isLearnFlowActive = false
        }
    }

    private func restartSession() {
        learnFlowTask?.cancel()
        isLearnFlowActive = false
        showCompletion = false
        isFlipped = false
        navigationTrigger = nil

        if let viewModel {
            sessionStore.reset(fileName: viewModel.sessionKey)
        }
        viewModel = StudyViewModel(
            studySet: studySet,
            studySection: studySection,
            sessionStore: sessionStore
        )
    }

    private func navigationTitle(for viewModel: StudyViewModel) -> String {
        studySection?.localizedTitle ?? viewModel.studySet.localizedTitle
    }

    private func learnedCount(for viewModel: StudyViewModel) -> Int {
        if let studySection {
            return SectionedVocabulary.learnedCount(
                in: studySection,
                fileName: viewModel.studySet.fileName,
                store: learnedStore
            )
        }
        return learnedStore.learnedCount(for: viewModel.studySet.fileName)
    }

    private func totalWords(for viewModel: StudyViewModel) -> Int {
        if studySection != nil {
            return viewModel.words.count
        }
        return catalog.wordCount(for: viewModel.studySet.fileName)
    }
}

#Preview {
    StudyView(studySet: SampleStudySets.all[0])
        .environment(FavoritesStore())
        .environment(WordCatalog())
        .environment(LearnedWordsStore())
        .environment(StudySessionStore())
        .environment(SmartReviewStore())
}
