//
//  SpeechService.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import AVFoundation

final class SpeechService {

    static let shared = SpeechService()

    enum Rate {
        case normal
        case slow

        var value: Float {
            switch self {
            case .normal: 0.45
            case .slow: 0.28
            }
        }
    }

    private let synthesizer = AVSpeechSynthesizer()

    private init() {}

    /// False when hardware volume is fully down (avoid auto-play while muted).
    var canAutoPlay: Bool {
        activateSessionIfNeeded()
        return AVAudioSession.sharedInstance().outputVolume > 0
    }

    func speak(_ text: String, rate: Rate = .normal) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        utterance.rate = rate.value
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }

    func speakSlow(_ text: String) {
        speak(text, rate: .slow)
    }

    /// Speaks only when system output volume is above zero.
    func speakIfAudible(_ text: String, rate: Rate = .normal) {
        guard canAutoPlay else { return }
        speak(text, rate: rate)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }

    private func activateSessionIfNeeded() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playback, options: [.mixWithOthers])
        try? session.setActive(true)
    }
}
