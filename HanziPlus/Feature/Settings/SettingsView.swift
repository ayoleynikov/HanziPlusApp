//
//  SettingsView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct SettingsView: View {

    @Environment(LanguageSettingsStore.self) private var languageStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {

        NavigationStack {

            List {

                Section {
                    ForEach(AppLanguage.allCases) { language in
                        Button {
                            languageStore.preference = language
                            HapticService.light()
                        } label: {
                            HStack {
                                Text(L10n.dynamic(language.settingsTitleKey))
                                    .foregroundStyle(.primary)
                                Spacer()
                                if languageStore.preference == language {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.orange)
                                        .accessibilityHidden(true)
                                }
                            }
                        }
                        .accessibilityLabel(L10n.dynamic(language.settingsTitleKey))
                        .accessibilityAddTraits(languageStore.preference == language ? [.isSelected] : [])
                    }
                } header: {
                    Text(l10n: "language.section")
                } footer: {
                    Text(l10n: "language.footer")
                }

                Section(L10n.string("settings.section.progress")) {
                    YourProgressSection()
                }

                Section {
                    StudyProgressResetSection()
                } header: {
                    Text(L10n.string("settings.section.reset"))
                } footer: {
                    Text(l10n: "settings.reset.all_footer")
                }

                Section(L10n.string("settings.section.about")) {
                    LabeledContent(L10n.string( "common.version"), value: appVersion)
                }

                Section {
                    Text(l10n: "settings.privacy.body")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                } header: {
                    Text(l10n: "settings.section.privacy")
                }

            }
            .navigationTitle(L10n.string( "settings.title"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(L10n.string( "common.done")) {
                        dismiss()
                    }
                    .accessibilityLabel(L10n.string( "settings.a11y.close"))
                }
            }

        }

    }

    private var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(version) (\(build))"
    }
}

#Preview {
    SettingsView()
        .environment(DailyLessonStore())
        .environment(LearnedWordsStore())
        .environment(SmartReviewStore())
        .environment(GameScoreStore())
        .environment(GamesDailyProgressStore())
        .environment(DailyChallengeStore())
        .environment(JourneyStore())
        .environment(StatisticsStore())
        .environment(StudySessionStore())
        .environment(WordCatalog())
        .environment(PathCourseStore())
        .environment(TravelPhraseStore())
        .environment(AchievementStore())
        .environment(GamesPlayHistoryStore())
        .environment(LanguageSettingsStore())
        .environmentObject(FavoritesStore())
}
