//
//  OnboardingView.swift
//  HanziPlus
//

import SwiftUI

struct OnboardingView: View {

    @Environment(UserProfileStore.self) private var profileStore

    @State private var step = 0
    @State private var goal: PrimaryGoal = .learnChinese
    @State private var level: ChineseLevel = .completeBeginner
    @State private var minutes: DailyMinutes = .ten
    @State private var hasTravelDate = false
    @State private var travelDate = Calendar.current.date(byAdding: .month, value: 3, to: Date()) ?? Date()

    private let tint = Color.orange

    private var showsTravelStep: Bool {
        goal.includesTravel
    }

    private var totalSteps: Int {
        showsTravelStep ? 5 : 4
    }

    private var planStepIndex: Int {
        showsTravelStep ? 4 : 3
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                progressHeader
                    .padding(.horizontal, AppSpacing.medium)
                    .padding(.top, AppSpacing.small)

                TabView(selection: $step) {
                    goalStep.tag(0)
                    levelStep.tag(1)
                    minutesStep.tag(2)
                    if showsTravelStep {
                        travelDateStep.tag(3)
                    }
                    planStep.tag(planStepIndex)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.spring(response: 0.4, dampingFraction: 0.88), value: step)

                bottomBar
                    .padding(.horizontal, AppSpacing.medium)
                    .padding(.bottom, AppSpacing.medium)
                    .padding(.top, AppSpacing.small)
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private var progressHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("HanziPlus")
                .font(.title2.weight(.bold))

            ProgressView(value: Double(step + 1), total: Double(totalSteps))
                .tint(tint)
                .accessibilityLabel("Onboarding progress")
                .accessibilityValue("Step \(step + 1) of \(totalSteps)")
        }
    }

    private var goalStep: some View {
        stepContainer(
            title: "What’s your main goal?",
            subtitle: "We’ll personalize your daily plan."
        ) {
            ForEach(PrimaryGoal.allCases) { option in
                OnboardingOptionCard(
                    title: option.title,
                    subtitle: option.subtitle,
                    icon: option.icon,
                    isSelected: goal == option,
                    tint: tint
                ) {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                        goal = option
                        if !option.includesTravel {
                            hasTravelDate = false
                        }
                    }
                }
            }
        }
    }

    private var levelStep: some View {
        stepContainer(
            title: "What’s your level?",
            subtitle: "We’ll suggest the right starting set."
        ) {
            ForEach(ChineseLevel.allCases) { option in
                OnboardingOptionCard(
                    title: option.title,
                    subtitle: option.subtitle,
                    icon: option.icon,
                    isSelected: level == option,
                    tint: tint
                ) {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                        level = option
                    }
                }
            }
        }
    }

    private var minutesStep: some View {
        stepContainer(
            title: "Daily study time",
            subtitle: "A small habit beats a perfect plan."
        ) {
            ForEach(DailyMinutes.allCases) { option in
                OnboardingOptionCard(
                    title: option.title,
                    subtitle: option.subtitle,
                    icon: option.icon,
                    isSelected: minutes == option,
                    tint: tint
                ) {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                        minutes = option
                    }
                }
            }
        }
    }

    private var travelDateStep: some View {
        stepContainer(
            title: "When is your trip?",
            subtitle: "Optional — helps with countdown and focus."
        ) {
            OnboardingOptionCard(
                title: "No date yet",
                subtitle: "I’ll choose later",
                icon: "calendar.badge.minus",
                isSelected: !hasTravelDate,
                tint: tint
            ) {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                    hasTravelDate = false
                }
            }

            OnboardingOptionCard(
                title: "I have a date",
                subtitle: "Show countdown on Today",
                icon: "calendar",
                isSelected: hasTravelDate,
                tint: tint
            ) {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                    hasTravelDate = true
                }
            }

            if hasTravelDate {
                DatePicker(
                    "Travel date",
                    selection: $travelDate,
                    in: Date()...,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding(12)
                .background {
                    RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                        .fill(Color(.secondarySystemGroupedBackground))
                }
                .accessibilityLabel("Travel date picker")
            }
        }
    }

    private var planStep: some View {
        stepContainer(
            title: "Your plan is ready",
            subtitle: "A calm daily path based on your answers."
        ) {
            planSummaryCard
        }
    }

    private var planSummaryCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            planRow(icon: goal.icon, title: "Goal", value: goal.title)
            planRow(icon: level.icon, title: "Level", value: level.title)
            planRow(icon: minutes.icon, title: "Daily time", value: minutes.title)

            if goal.includesTravel {
                planRow(
                    icon: "airplane",
                    title: "Travel",
                    value: travelPlanValue
                )
            }

            Divider()

            Text(planBlurb)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
        .studyCardShadow()
    }

    private var travelPlanValue: String {
        if hasTravelDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: travelDate)
        }
        return "No date yet"
    }

    private var planBlurb: String {
        switch goal {
        case .learnChinese:
            return "Each day you’ll learn a small set of words, review with Smart Review, and explore China on the map."
        case .travelToChina:
            return "We’ll prioritize Travel Essentials and trip prep, with short reviews to keep phrases ready."
        case .both:
            return "You’ll mix HSK learning with travel prep — study, review, and explore China each day."
        }
    }

    private func planRow(icon: String, title: String, value: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.body.weight(.semibold))
                .foregroundStyle(tint)
                .frame(width: 28)

            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .font(.subheadline.weight(.semibold))
                .multilineTextAlignment(.trailing)
        }
        .accessibilityElement(children: .combine)
    }

    private func stepContainer<Content: View>(
        title: String,
        subtitle: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.medium) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.largeTitle.weight(.bold))
                        .fixedSize(horizontal: false, vertical: true)

                    Text(subtitle)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }

                VStack(spacing: AppSpacing.small) {
                    content()
                }
            }
            .padding(.horizontal, AppSpacing.medium)
            .padding(.top, AppSpacing.large)
            .padding(.bottom, AppSpacing.extraLarge)
        }
    }

    private var bottomBar: some View {
        HStack(spacing: 12) {
            if step > 0 {
                Button("Back") {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.88)) {
                        step -= 1
                    }
                }
                .buttonStyle(.bordered)
                .accessibilityLabel("Go back")
            }

            Button(step == planStepIndex ? "Start My Journey" : "Continue") {
                if step == planStepIndex {
                    finish()
                } else {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.88)) {
                        advance()
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(tint)
            .frame(maxWidth: .infinity)
            .accessibilityLabel(step == planStepIndex ? "Start my journey" : "Continue")
        }
    }

    private func advance() {
        if step == 2 && showsTravelStep {
            step = 3
        } else if step < planStepIndex {
            step = min(step + 1, planStepIndex)
        }
    }

    private func finish() {
        profileStore.completeOnboarding(
            goal: goal,
            level: level,
            minutes: minutes,
            travelDate: travelDate,
            hasTravelDate: hasTravelDate && goal.includesTravel
        )
    }
}

#Preview {
    OnboardingView()
        .environment(UserProfileStore())
}
