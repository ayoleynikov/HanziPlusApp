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
            title: String(localized: "onboarding.goal.title"),
            subtitle: String(localized: "onboarding.goal.subtitle")
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
            title: String(localized: "onboarding.level.title"),
            subtitle: String(localized: "onboarding.level.subtitle")
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
            title: String(localized: "onboarding.time.title"),
            subtitle: String(localized: "onboarding.time.subtitle")
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
            title: String(localized: "onboarding.trip.title"),
            subtitle: String(localized: "onboarding.trip.subtitle")
        ) {
            OnboardingOptionCard(
                title: String(localized: "onboarding.trip.no_date_title"),
                subtitle: String(localized: "onboarding.trip.no_date_subtitle"),
                icon: "calendar.badge.minus",
                isSelected: !hasTravelDate,
                tint: tint
            ) {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                    hasTravelDate = false
                }
            }

            OnboardingOptionCard(
                title: String(localized: "onboarding.trip.has_date_title"),
                subtitle: String(localized: "onboarding.trip.has_date_subtitle"),
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
                    String(localized: "onboarding.trip.date_label"),
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
                .accessibilityLabel(String(localized: "onboarding.a11y.date_picker"))
            }
        }
    }

    private var planStep: some View {
        stepContainer(
            title: String(localized: "onboarding.plan.ready_title"),
            subtitle: String(localized: "onboarding.plan.ready_subtitle")
        ) {
            planSummaryCard
        }
    }

    private var planSummaryCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            planRow(icon: goal.icon, title: String(localized: "onboarding.plan.row_goal"), value: goal.title)
            planRow(icon: level.icon, title: String(localized: "onboarding.plan.row_level"), value: level.title)
            planRow(icon: minutes.icon, title: String(localized: "onboarding.plan.row_daily_time"), value: minutes.title)

            if goal.includesTravel {
                planRow(
                    icon: "airplane",
                    title: String(localized: "onboarding.plan.row_travel"),
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
            formatter.locale = Locale.current
            formatter.dateStyle = .medium
            return formatter.string(from: travelDate)
        }
        return String(localized: "onboarding.plan.no_date")
    }

    private var planBlurb: String {
        switch goal {
        case .learnChinese:
            return String(localized: "onboarding.plan.blurb_learn")
        case .travelToChina:
            return String(localized: "onboarding.plan.blurb_travel")
        case .both:
            return String(localized: "onboarding.plan.blurb_both")
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
                Button(String(localized: "common.back")) {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.88)) {
                        step -= 1
                    }
                }
                .buttonStyle(.bordered)
                .accessibilityLabel(String(localized: "onboarding.a11y.back"))
            }

            Button(step == planStepIndex ? String(localized: "onboarding.button.start_journey") : String(localized: "common.continue")) {
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
            .accessibilityLabel(step == planStepIndex ? String(localized: "onboarding.a11y.start_journey") : String(localized: "common.continue"))
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
