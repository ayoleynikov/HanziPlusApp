//
//  SettingsView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct SettingsView: View {

    @Environment(UserProfileStore.self) private var profileStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {

        NavigationStack {

            List {

                Section("Learning") {
                    NavigationLink {
                        EditLearningGoalView(profile: profileStore.profile)
                    } label: {
                        Label("Edit Learning Goal", systemImage: "target")
                    }
                    .accessibilityLabel("Edit Learning Goal")

                    LabeledContent("Goal", value: profileStore.profile.primaryGoal.title)
                    LabeledContent("Level", value: profileStore.profile.chineseLevel.title)
                    LabeledContent("Daily time", value: profileStore.profile.dailyMinutes.title)
                }

                Section("Your Progress") {
                    YourProgressSection()
                }

                Section("Reset Study Progress") {
                    StudyProgressResetSection()
                }

                Section("About") {
                    LabeledContent("Version", value: appVersion)
                }

                Section {
                    Text("HanziPlus stores your progress, favorites, and game statistics locally on this device. No account is required and no data is sent to external servers.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                } header: {
                    Text("Privacy")
                }

            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .accessibilityLabel("Close Settings")
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
}
