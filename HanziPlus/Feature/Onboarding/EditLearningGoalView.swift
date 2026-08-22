//
//  EditLearningGoalView.swift
//  HanziPlus
//

import SwiftUI

struct EditLearningGoalView: View {

    @Environment(UserProfileStore.self) private var profileStore
    @Environment(\.dismiss) private var dismiss

    @State private var goal: PrimaryGoal
    @State private var level: ChineseLevel
    @State private var minutes: DailyMinutes
    @State private var hasTravelDate: Bool
    @State private var travelDate: Date

    private let tint = Color.orange

    init(profile: UserProfile) {
        _goal = State(initialValue: profile.primaryGoal)
        _level = State(initialValue: profile.chineseLevel)
        _minutes = State(initialValue: profile.dailyMinutes)
        _hasTravelDate = State(initialValue: profile.hasTravelDate)
        _travelDate = State(
            initialValue: profile.travelDate
                ?? Calendar.current.date(byAdding: .month, value: 3, to: Date())
                ?? Date()
        )
    }

    var body: some View {
        Form {
            Section("Goal") {
                ForEach(PrimaryGoal.allCases) { option in
                    selectionRow(
                        title: option.title,
                        subtitle: option.subtitle,
                        icon: option.icon,
                        selected: goal == option
                    ) {
                        goal = option
                        if !option.includesTravel {
                            hasTravelDate = false
                        }
                    }
                }
            }

            Section("Level") {
                ForEach(ChineseLevel.allCases) { option in
                    selectionRow(
                        title: option.title,
                        subtitle: option.subtitle,
                        icon: option.icon,
                        selected: level == option
                    ) {
                        level = option
                    }
                }
            }

            Section("Daily time") {
                ForEach(DailyMinutes.allCases) { option in
                    selectionRow(
                        title: option.title,
                        subtitle: option.subtitle,
                        icon: option.icon,
                        selected: minutes == option
                    ) {
                        minutes = option
                    }
                }
            }

            if goal.includesTravel {
                Section("Travel date") {
                    Toggle("I have a travel date", isOn: $hasTravelDate)
                    if hasTravelDate {
                        DatePicker(
                            "Date",
                            selection: $travelDate,
                            in: Date()...,
                            displayedComponents: .date
                        )
                    }
                }
            }
        }
        .navigationTitle("Edit Learning Goal")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    profileStore.saveEdits(
                        goal: goal,
                        level: level,
                        minutes: minutes,
                        travelDate: travelDate,
                        hasTravelDate: hasTravelDate && goal.includesTravel
                    )
                    dismiss()
                }
                .accessibilityLabel("Save learning goal")
            }
        }
    }

    private func selectionRow(
        title: String,
        subtitle: String,
        icon: String,
        selected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundStyle(tint)
                    .frame(width: 24)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .foregroundStyle(.primary)
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if selected {
                    Image(systemName: "checkmark")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(tint)
                }
            }
        }
        .accessibilityLabel("\(title). \(subtitle)")
        .accessibilityAddTraits(selected ? [.isSelected, .isButton] : .isButton)
    }
}
