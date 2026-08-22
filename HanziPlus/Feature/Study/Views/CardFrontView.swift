//
//  CardFrontView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct CardFrontView: View {

    let word: Word

    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 12)

            Text(word.hanzi)
                .font(.system(size: 88, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)
                .minimumScaleFactor(0.7)
                .lineLimit(1)

            Spacer(minLength: 28)

            VStack(spacing: 14) {
                Text(word.pinyin)
                    .font(.title3.weight(.medium))
                    .foregroundStyle(.secondary)
                    .tracking(0.4)

                Text(word.localizedMeaning)
                    .font(.title2.weight(.regular))
                    .foregroundStyle(.primary.opacity(0.88))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    CardFrontView(word: WordLoader.load(fileName: "hsk1").first!)
        .frame(height: 420)
        .padding()
        .background(Color(.systemGroupedBackground))
}
