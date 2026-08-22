//
//  YourProgressSection.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct YourProgressSection: View {

    @Environment(StatisticsStore.self) private var statistics
    @State private var showResetAlert = false

    var body: some View {
        Group {
            VStack(spacing: 8) {
                Image(systemName: "target")
                    .font(.title2)
                    .foregroundStyle(.blue)

                Text("\(statistics.accuracy)%")
                    .font(.system(size: 36, weight: .bold))

                Text("settings.progress.overall_accuracy")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .listRowBackground(Color(.systemGray6))

            LabeledContent {
                Text("\(statistics.bestAccuracy)%")
                    .fontWeight(.semibold)
            } label: {
                Label(String(localized: "settings.progress.best_accuracy"), systemImage: "trophy.fill")
            }

            LabeledContent {
                Text("\(statistics.quizzesCompleted)")
                    .fontWeight(.semibold)
            } label: {
                Label(String(localized: "settings.progress.quizzes_completed"), systemImage: "checkmark.circle.fill")
            }

            LabeledContent {
                Text("\(statistics.correctAnswers)")
                    .fontWeight(.semibold)
            } label: {
                Label(String(localized: "settings.progress.correct"), systemImage: "hand.thumbsup.fill")
            }

            LabeledContent {
                Text("\(statistics.wrongAnswers)")
                    .fontWeight(.semibold)
            } label: {
                Label(String(localized: "settings.progress.wrong"), systemImage: "xmark.circle.fill")
            }

            achievementRow(
                icon: "1.circle.fill",
                title: String(localized: "settings.progress.first_quiz"),
                unlocked: statistics.quizzesCompleted >= 1
            )

            achievementRow(
                icon: "10.circle.fill",
                title: String(localized: "settings.progress.ten_quizzes"),
                unlocked: statistics.quizzesCompleted >= 10
            )

            achievementRow(
                icon: "target",
                title: String(localized: "settings.progress.perfect_score"),
                unlocked: statistics.bestAccuracy == 100
            )

            VStack(alignment: .leading, spacing: 8) {
                Text("settings.progress.next_goal")
                    .font(.headline)

                ProgressView(
                    value: Double(min(statistics.quizzesCompleted, 10)),
                    total: 10
                )

                Text(String(localized: "settings.progress.quizzes_goal \(statistics.quizzesCompleted)"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)

            Button(role: .destructive) {
                showResetAlert = true
            } label: {
                Label(String(localized: "settings.progress.reset"), systemImage: "trash")
            }
        }
        .alert(String(localized: "settings.progress.reset_alert_title"), isPresented: $showResetAlert) {
            Button(String(localized: "common.cancel"), role: .cancel) {}
            Button(String(localized: "common.reset"), role: .destructive) {
                statistics.reset()
            }
        } message: {
            Text("settings.progress.reset_alert_body")
        }
    }

    @ViewBuilder
    private func achievementRow(icon: String, title: String, unlocked: Bool) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(unlocked ? .yellow : .gray)
                .frame(width: 24)

            Text(title)

            Spacer()

            Image(systemName: unlocked ? "checkmark.seal.fill" : "lock.fill")
                .foregroundStyle(unlocked ? .green : .secondary)
        }
    }
}

#Preview {
    List {
        Section("Your Progress") {
            YourProgressSection()
        }
    }
    .environment(StatisticsStore())
}
