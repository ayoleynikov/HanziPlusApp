//
//  SectionedStudySetView.swift
//  HanziPlus
//

import SwiftUI

struct SectionedStudySetView: View {

    let studySet: StudySet

    @Environment(LearnedWordsStore.self) private var learnedStore
    @Environment(StudySessionStore.self) private var sessionStore

    private var sections: [StudySetSection] {
        StudySetCatalog.sections(for: studySet.fileName)
    }

    private var totalWords: Int {
        SectionedVocabulary.totalWordCount(fileName: studySet.fileName)
    }

    private var totalLearned: Int {
        SectionedVocabulary.totalLearnedCount(fileName: studySet.fileName, store: learnedStore)
    }

    private var overallProgress: Double {
        guard totalWords > 0 else { return 0 }
        return Double(totalLearned) / Double(totalWords)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                header

                if let continueSection = activeSection {
                    continueSectionBanner(continueSection)
                }

                VStack(alignment: .leading, spacing: AppSpacing.medium) {
                    Text("learn.sections")
                        .font(.title3.weight(.semibold))
                        .padding(.horizontal, AppSpacing.medium)

                    LazyVStack(spacing: AppSpacing.medium) {
                        ForEach(sections) { section in
                            let count = SectionedVocabulary.wordCount(in: section, fileName: studySet.fileName)
                            let learned = SectionedVocabulary.learnedCount(
                                in: section,
                                fileName: studySet.fileName,
                                store: learnedStore
                            )

                            NavigationLink {
                                StudyView(studySet: studySet, studySection: section)
                            } label: {
                                StudySetSectionCard(
                                    section: section,
                                    wordCount: count,
                                    learnedWords: learned,
                                    tint: studySet.color
                                )
                            }
                            .buttonStyle(StudySetCardButtonStyle())
                        }
                    }
                    .padding(.horizontal, AppSpacing.medium)
                }
            }
            .padding(.bottom, AppSpacing.extraLarge)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(studySet.title)
        .navigationBarTitleDisplayMode(.large)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(studySet.color.opacity(0.14))
                        .frame(width: 56, height: 56)

                    Image(systemName: studySet.icon)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(studySet.color)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(studySet.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text("\(totalWords) words · \(sections.count) sections")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.tertiary)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("\(totalLearned) / \(totalWords) learned")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("\(Int(overallProgress * 100))%")
                        .font(.caption.weight(.semibold))
                }

                AnimatedProgressBar(progress: overallProgress, tint: studySet.color)
            }
        }
        .padding(AppSpacing.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
        .padding(.horizontal, AppSpacing.medium)
        .padding(.top, AppSpacing.small)
    }

    private var activeSection: StudySetSection? {
        guard let key = sessionStore.lastActiveFileName,
              let parsed = SectionedVocabulary.parseSessionKey(key),
              parsed.fileName == studySet.fileName,
              sessionStore.session(for: key) != nil,
              let section = StudySetCatalog.section(fileName: studySet.fileName, id: parsed.sectionID)
        else { return nil }
        return section
    }

    @ViewBuilder
    private func continueSectionBanner(_ section: StudySetSection) -> some View {
        let session = sessionStore.session(
            for: SectionedVocabulary.sessionKey(fileName: studySet.fileName, section: section)
        )
        let wordCount = SectionedVocabulary.wordCount(in: section, fileName: studySet.fileName)

        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text("common.continue")
                .font(.title3.weight(.semibold))
                .padding(.horizontal, AppSpacing.medium)

            NavigationLink {
                StudyView(studySet: studySet, studySection: section)
            } label: {
                HStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(studySet.color.opacity(0.14))
                            .frame(width: 44, height: 44)

                        Image(systemName: "play.fill")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(studySet.color)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(section.displayTitle)
                            .font(.headline)

                        if let session {
                            Text(String(localized: "study.card_of \(session.currentIndex + 1) \(wordCount)"))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.tertiary)
                }
                .padding(18)
                .background {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                        .overlay {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .strokeBorder(studySet.color.opacity(0.18), lineWidth: 0.5)
                        }
                }
            }
            .buttonStyle(StudySetCardButtonStyle())
            .padding(.horizontal, AppSpacing.medium)
        }
    }
}

#Preview {
    NavigationStack {
        SectionedStudySetView(studySet: SampleStudySets.travel)
    }
    .environment(LearnedWordsStore())
    .environment(StudySessionStore())
}
