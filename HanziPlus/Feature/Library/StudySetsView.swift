//
//  StudySetsView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct StudySetsView: View {

    private let groups = SampleStudySets.groups

    @Environment(WordCatalog.self) private var catalog
    @Environment(LearnedWordsStore.self) private var learnedStore
    @Environment(StudySessionStore.self) private var sessionStore
    @Environment(DailyLessonStore.self) private var lessonStore
    @Environment(UserProfileStore.self) private var profileStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.large) {
                    todayLessonSection

                    if let continueTarget = continueStudyTarget {
                        VStack(alignment: .leading, spacing: AppSpacing.small) {
                            Text("learn.continue")
                                .font(.title2.weight(.semibold))
                                .padding(.horizontal, AppSpacing.medium)

                            continueLink(for: continueTarget)
                                .buttonStyle(StudySetCardButtonStyle())
                                .padding(.horizontal, AppSpacing.medium)
                        }
                    }

                    ForEach(groups) { group in
                        studySetGroup(group)
                    }
                }
                .padding(.bottom, AppSpacing.extraLarge)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(String(localized: "learn.nav_title"))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SearchView()
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .accessibilityLabel(String(localized: "learn.a11y.search"))
                }
            }
        }
    }

    @ViewBuilder
    private var todayLessonSection: some View {
        let session = lessonStore.ensureTodaySession(
            profile: profileStore.profile,
            learnedStore: learnedStore
        )
        let setTitle = SampleStudySets.studySet(fileName: session.fileName)?.localizedTitle ?? session.fileName

        VStack(alignment: .leading, spacing: AppSpacing.small) {
            NavigationLink {
                DailyLessonFlowView()
            } label: {
                TodayLessonCard(
                    setTitle: setTitle,
                    wordCount: session.wordCount,
                    status: lessonStore.status,
                    isReviewLesson: session.isReviewLesson
                )
            }
            .buttonStyle(.plain)
            .padding(.horizontal, AppSpacing.medium)
        }
        .padding(.top, AppSpacing.small)
    }

    @ViewBuilder
    private func studySetGroup(_ group: StudySetGroup) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            Text("\(group.emoji) \(group.title)")
                .font(.title2.weight(.semibold))
                .padding(.horizontal, AppSpacing.medium)

            LazyVStack(spacing: AppSpacing.medium) {
                ForEach(group.sets) { set in
                    let wordCount = catalog.wordCount(for: set.fileName)
                    let learned = catalog.learnedCount(for: set.fileName, store: learnedStore)

                    NavigationLink {
                        studyDestination(for: set)
                    } label: {
                        StudySetCard(
                            studySet: set,
                            wordCount: wordCount,
                            learnedWords: learned
                        )
                    }
                    .buttonStyle(StudySetCardButtonStyle())
                }
            }
            .padding(.horizontal, AppSpacing.medium)
        }
    }

    private struct ContinueTarget {
        let studySet: StudySet
        let studySection: StudySetSection?
    }

    private var continueStudyTarget: ContinueTarget? {
        guard let key = sessionStore.lastActiveFileName else { return nil }

        if let parsed = SectionedVocabulary.parseSessionKey(key),
           let set = SampleStudySets.studySet(fileName: parsed.fileName),
           let section = StudySetCatalog.section(fileName: parsed.fileName, id: parsed.sectionID),
           sessionStore.session(for: key) != nil {
            return ContinueTarget(studySet: set, studySection: section)
        }

        guard let set = SampleStudySets.studySet(fileName: key),
              sessionStore.session(for: key) != nil
        else { return nil }

        return ContinueTarget(studySet: set, studySection: nil)
    }

    @ViewBuilder
    private func studyDestination(for set: StudySet) -> some View {
        if set.hasSections {
            SectionedStudySetView(studySet: set)
        } else {
            StudyView(studySet: set)
        }
    }

    @ViewBuilder
    private func continueLink(for target: ContinueTarget) -> some View {
        if let section = target.studySection {
            NavigationLink {
                StudyView(studySet: target.studySet, studySection: section)
            } label: {
                ContinueStudyBanner(
                    studySet: target.studySet,
                    cardNumber: continueCardNumber(
                        sessionKey: SectionedVocabulary.sessionKey(
                            fileName: target.studySet.fileName,
                            section: section
                        )
                    ),
                    totalWords: SectionedVocabulary.wordCount(
                        in: section,
                        fileName: target.studySet.fileName
                    ),
                    subtitle: section.displayTitle
                )
            }
        } else if target.studySet.hasSections {
            NavigationLink {
                SectionedStudySetView(studySet: target.studySet)
            } label: {
                ContinueStudyBanner(
                    studySet: target.studySet,
                    cardNumber: continueCardNumber(sessionKey: target.studySet.fileName),
                    totalWords: catalog.wordCount(for: target.studySet.fileName)
                )
            }
        } else {
            NavigationLink {
                StudyView(studySet: target.studySet)
            } label: {
                ContinueStudyBanner(
                    studySet: target.studySet,
                    cardNumber: continueCardNumber(sessionKey: target.studySet.fileName),
                    totalWords: catalog.wordCount(for: target.studySet.fileName)
                )
            }
        }
    }

    private func continueCardNumber(sessionKey: String) -> Int {
        guard let session = sessionStore.session(for: sessionKey) else { return 1 }
        return session.currentIndex + 1
    }
}

#Preview {
    StudySetsView()
        .environment(WordCatalog())
        .environment(LearnedWordsStore())
        .environment(StudySessionStore())
        .environment(DailyLessonStore())
        .environment(UserProfileStore())
}
