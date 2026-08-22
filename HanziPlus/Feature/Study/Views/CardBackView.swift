//
//  BackCard.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct CardBackView: View {

    let word: Word
    var scrollEnabled = true

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("study.card_back.examples")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.tertiary)
                    .tracking(1.2)
                    .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(word.examples) { example in
                    VStack(spacing: 0) {
                        ExampleRowView(example: example, style: .compact)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                    .background(Color.primary.opacity(0.04))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
            }
            .padding(.vertical, 4)
        }
        .scrollIndicators(.hidden)
        .scrollDisabled(!scrollEnabled)
    }
}

#Preview {
    CardBackView(
        word: WordLoader.load(fileName: "hsk1").first!
    )
    .frame(height: 420)
    .padding()
    .background(Color(.secondarySystemGroupedBackground))
}
