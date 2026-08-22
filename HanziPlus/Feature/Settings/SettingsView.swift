//
//  SettingsView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct SettingsView: View {

    @Environment(UserProfileStore.self) private var profileStore
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
                                Text(String(localized: String.LocalizationValue(language.settingsTitleKey)))
                                    .foregroundStyle(.primary)
                                Spacer()
                                if languageStore.preference == language {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.orange)
                                        .accessibilityHidden(true)
                                }
                            }
                        }
                        .accessibilityLabel(String(localized: String.LocalizationValue(language.settingsTitleKey)))
                        .accessibilityAddTraits(languageStore.preference == language ? [.isSelected] : [])
                    }
                } header: {
                    Text("language.section")
                } footer: {
                    Text("language.footer")
                }

                Section("settings.section.learning") {
                    NavigationLink {
                        EditLearningGoalView(profile: profileStore.profile)
                    } label: {
                        Label(String(localized: "settings.edit_learning_goal"), systemImage: "target")
                    }
                    .accessibilityLabel(String(localized: "settings.edit_learning_goal"))

                    LabeledContent(
                        String(localized: "settings.label.goal"),
                        value: profileStore.profile.primaryGoal.title
                    )
                    LabeledContent(
                        String(localized: "settings.label.level"),
                        value: profileStore.profile.chineseLevel.title
                    )
                    LabeledContent(
                        String(localized: "settings.label.daily_time"),
                        value: profileStore.profile.dailyMinutes.title
                    )
                }

                Section("settings.section.progress") {
                    YourProgressSection()
                }

                Section("settings.section.reset") {
                    StudyProgressResetSection()
                }

                Section("settings.section.about") {
                    LabeledContent(String(localized: "common.version"), value: appVersion)
                }

                Section {
                    Text("settings.privacy.body")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                } header: {
                    Text("settings.section.privacy")
                }

            }
            .navigationTitle(String(localized: "settings.title"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(String(localized: "common.done")) {
                        dismiss()
                    }
                    .accessibilityLabel(String(localized: "settings.a11y.close"))
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
        .environment(StatisticsStore())
        .environment(LearnedWordsStore())
        .environment(StudySessionStore())
        .environment(SmartReviewStore())
        .environment(WordCatalog())
        .environment(UserProfileStore())
        .environment(LanguageSettingsStore())
}
