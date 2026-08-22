//
//  ContinueStudyBanner.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct ContinueStudyBanner: View {

    let studySet: StudySet
    let cardNumber: Int
    let totalWords: Int
    var subtitle: String? = nil

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(studySet.color.opacity(0.14))
                    .frame(width: 44, height: 44)

                Image(systemName: "play.fill")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(studySet.color)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Continue \(studySet.title)")
                    .font(.headline)

                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Text("Card \(cardNumber) of \(totalWords)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(18)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
                .overlay {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(studySet.color.opacity(0.18), lineWidth: 0.5)
                }
        }
    }
}

#Preview {
    ContinueStudyBanner(
        studySet: SampleStudySets.all[0],
        cardNumber: 12,
        totalWords: 150
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}
