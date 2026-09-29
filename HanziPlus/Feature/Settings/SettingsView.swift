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

                    Link(destination: AppLinks.support) {
                        Label(L10n.string("settings.about.contact_support"), systemImage: "envelope.fill")
                    }
                    .accessibilityHint(L10n.string("settings.a11y.opens_mail"))
                }

                Section {
                    Text(l10n: "settings.privacy.body")
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    Link(destination: AppLinks.privacyPolicy(for: LocalizedContent.currentLanguage)) {
                        Label(L10n.string("settings.privacy.policy_link"), systemImage: "hand.raised.fill")
                    }
                    .accessibilityHint(L10n.string("settings.a11y.opens_browser"))
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

/// External links shown in Settings (privacy policy site + support email).
private enum AppLinks {

    private static let siteBase = "https://ayoleynikov.github.io/hanziPlus/"

    static let support = URL(string: "mailto:Ayoleynikov@icloud.com")!

    /// Privacy policy page in the in-app language (English lives at the site root).
    static func privacyPolicy(for language: ContentLanguageCode) -> URL {
        let path: String
        switch language {
        case .en: path = "privacy.html"
        case .ru: path = "ru/privacy.html"
        case .es: path = "es/privacy.html"
        case .ptBR: path = "pt-BR/privacy.html"
        }
        return URL(string: siteBase + path)!
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
