//
//  PathHowItWorksSection.swift
//  HanziPlus
//

import SwiftUI

struct PathHowItWorksSection: View {

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(PathStrings.howItWorksTitle)
                .font(.title3.weight(.semibold))

            VStack(spacing: 12) {
                ForEach(Array(PathStrings.howItWorksSteps.enumerated()), id: \.offset) { _, step in
                    HStack(alignment: .top, spacing: 12) {
                        Circle()
                            .fill(Color.teal.opacity(0.15))
                            .frame(width: 8, height: 8)
                            .padding(.top, 6)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(step.title)
                                .font(.subheadline.weight(.semibold))
                            Text(step.detail)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(14)
                    .background {
                        RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                            .fill(Color(.secondarySystemGroupedBackground))
                    }
                }
            }
        }
    }
}

#Preview {
    PathHowItWorksSection()
        .padding()
}
