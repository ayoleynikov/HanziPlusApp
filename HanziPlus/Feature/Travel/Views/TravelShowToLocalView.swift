//
//  TravelShowToLocalView.swift
//  HanziPlus
//

import SwiftUI

struct TravelShowToLocalView: View {
    let phrase: TravelPhrase

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        GeometryReader { geo in
            let isLandscape = geo.size.width > geo.size.height

            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: isLandscape ? 16 : 28) {
                    HStack {
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.white.opacity(0.85))
                        }
                        .accessibilityLabel("Close")
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                    Spacer(minLength: 0)

                    Text(phrase.simplifiedChinese)
                        .font(.system(size: isLandscape ? 56 : 72, weight: .bold))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.35)
                        .lineLimit(4)
                        .padding(.horizontal, 20)
                        .accessibilityAddTraits(.isHeader)

                    Text(phrase.english)
                        .font(.title3.weight(.medium))
                        .foregroundStyle(.white.opacity(0.72))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)

                    Spacer(minLength: 0)

                    Button {
                        HapticService.light()
                        SpeechService.shared.speak(phrase.simplifiedChinese)
                    } label: {
                        Label("Play", systemImage: "speaker.wave.2.fill")
                            .font(.headline)
                            .foregroundStyle(.black)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 14)
                            .background(Capsule().fill(Color.white))
                    }
                    .accessibilityLabel("Play pronunciation")
                    .padding(.bottom, 28)
                }
            }
        }
        .statusBarHidden(true)
    }
}
