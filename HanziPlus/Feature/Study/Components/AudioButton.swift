//
//  AudioButton.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct AudioButton: View {

    let text: String

    var body: some View {

        Button {

            SpeechService.shared.speak(text)

        } label: {

            Label("Listen", systemImage: "speaker.wave.2.fill")
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    AudioButton(text: "你好")
}
