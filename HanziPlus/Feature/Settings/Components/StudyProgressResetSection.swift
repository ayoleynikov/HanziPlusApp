//
//  StudyProgressResetSection.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct StudyProgressResetSection: View {

    @Environment(LearnedWordsStore.self) private var learnedStore
    @Environment(StudySessionStore.self) private var sessionStore
    @Environment(SmartReviewStore.self) private var smartReviewStore
    @Environment(WordCatalog.self) private var catalog

    @State private var studySetPendingReset: StudySet?

    var body: some View {
        Group {
            ForEach(SampleStudySets.all) { studySet in
                let learned = catalog.learnedCount(for: studySet.fileName, store: learnedStore)
                let total = catalog.wordCount(for: studySet.fileName)
                let hasSession = hasActiveSession(for: studySet)

                Button(role: .destructive) {
                    studySetPendingReset = studySet
                } label: {
                    HStack {
                        Text(String(localized: "settings.reset.set_progress \(studySet.localizedTitle)"))
                        Spacer()
                        Text("\(learned)/\(total)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .disabled(learned == 0 && !hasSession)
            }
        }
        .alert(
            String(localized: "settings.reset.set_alert_title \(studySetPendingReset?.localizedTitle ?? "")"),
            isPresented: Binding(
                get: { studySetPendingReset != nil },
                set: { if !$0 { studySetPendingReset = nil } }
            )
        ) {
            Button(String(localized: "common.cancel"), role: .cancel) {
                studySetPendingReset = nil
            }
            Button(String(localized: "common.reset"), role: .destructive) {
                if let studySet = studySetPendingReset {
                    learnedStore.reset(fileName: studySet.fileName)
                    smartReviewStore.reset(fileName: studySet.fileName)
                    if studySet.hasSections {
                        sessionStore.reset(matchingPrefix: "\(studySet.fileName):")
                        sessionStore.reset(fileName: studySet.fileName)
                    } else {
                        sessionStore.reset(fileName: studySet.fileName)
                    }
                }
                studySetPendingReset = nil
            }
        } message: {
            Text("settings.reset.set_alert_body")
        }
    }

    private func hasActiveSession(for studySet: StudySet) -> Bool {
        if studySet.hasSections {
            return sessionStore.hasSession(matchingPrefix: "\(studySet.fileName):")
                || sessionStore.session(for: studySet.fileName) != nil
        }
        return sessionStore.session(for: studySet.fileName) != nil
    }
}

#Preview {
    List {
        Section("Reset Study Progress") {
            StudyProgressResetSection()
        }
    }
    .environment(LearnedWordsStore())
    .environment(StudySessionStore())
    .environment(SmartReviewStore())
    .environment(WordCatalog())
}
