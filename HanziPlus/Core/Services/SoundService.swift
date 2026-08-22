//
//  SoundService.swift
//  HanziPlus
//

import AudioToolbox
import Foundation

enum SoundService {
    static func success() {
        AudioServicesPlaySystemSound(1057)
    }

    static func error() {
        AudioServicesPlaySystemSound(1053)
    }

    static func tap() {
        AudioServicesPlaySystemSound(1104)
    }
}
