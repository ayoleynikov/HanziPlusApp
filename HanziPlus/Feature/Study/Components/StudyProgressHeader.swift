//
//  StudyProgressHeader.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import SwiftUI

struct StudyProgressHeader: View {

    let currentCardIndex: Int
    let learnedCount: Int
    let total: Int
    var tint: Color = .green

    private var learnedProgress: Double {
        guard total > 0 else { return 0 }
        return Double(learnedCount) / Double(total)
    }

    private var percentage: Int {
        Int(learnedProgress * 100)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                Text(L10n.string( "study.progress.card_n \(currentCardIndex + 1)"))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)

                Spacer()

                HStack(alignment: .firstTextBaseline, spacing: 10) {
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("\(learnedCount)")
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.primary)
                            .contentTransition(.numericText())

                        Text(" / \(total)")
                            .font(.title3.weight(.regular))
                            .foregroundStyle(.tertiary)
                    }

                    Text(L10n.percent(percentage))
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(tint)
                        .contentTransition(.numericText())
                        .frame(minWidth: 40, alignment: .trailing)
                }
                .animation(.spring(response: 0.45, dampingFraction: 0.86), value: learnedCount)
                .animation(.spring(response: 0.45, dampingFraction: 0.86), value: percentage)
            }

            AnimatedProgressBar(progress: learnedProgress, tint: tint)
        }
        .padding(.horizontal, 4)
        .animation(.spring(response: 0.45, dampingFraction: 0.86), value: learnedProgress)
    }
}

#Preview {
    StudyProgressHeader(currentCardIndex: 11, learnedCount: 48, total: 150)
        .padding()
}
