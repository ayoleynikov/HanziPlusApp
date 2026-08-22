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

                Text("Overall Accuracy")
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
                Label("Best Accuracy", systemImage: "trophy.fill")
            }

            LabeledContent {
                Text("\(statistics.quizzesCompleted)")
                    .fontWeight(.semibold)
            } label: {
                Label("Quizzes Completed", systemImage: "checkmark.circle.fill")
            }

            LabeledContent {
                Text("\(statistics.correctAnswers)")
                    .fontWeight(.semibold)
            } label: {
                Label("Correct Answers", systemImage: "hand.thumbsup.fill")
            }

            LabeledContent {
                Text("\(statistics.wrongAnswers)")
                    .fontWeight(.semibold)
            } label: {
                Label("Wrong Answers", systemImage: "xmark.circle.fill")
            }

            achievementRow(
                icon: "1.circle.fill",
                title: "First Quiz",
                unlocked: statistics.quizzesCompleted >= 1
            )

            achievementRow(
                icon: "10.circle.fill",
                title: "10 Quizzes Completed",
                unlocked: statistics.quizzesCompleted >= 10
            )

            achievementRow(
                icon: "target",
                title: "Perfect Score",
                unlocked: statistics.bestAccuracy == 100
            )

            VStack(alignment: .leading, spacing: 8) {
                Text("Next Goal")
                    .font(.headline)

                ProgressView(
                    value: Double(min(statistics.quizzesCompleted, 10)),
                    total: 10
                )

                Text("\(statistics.quizzesCompleted) / 10 Quizzes Completed")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)

            Button(role: .destructive) {
                showResetAlert = true
            } label: {
                Label("Reset Statistics", systemImage: "trash")
            }
        }
        .alert("Reset Statistics?", isPresented: $showResetAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Reset", role: .destructive) {
                statistics.reset()
            }
        } message: {
            Text("This will permanently delete all quiz statistics.")
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
