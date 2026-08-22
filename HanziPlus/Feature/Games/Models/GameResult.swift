//
//  GameResult.swift
//  HanziPlus
//

import Foundation

struct GameResult: Equatable {
    let gameKind: GameKind
    let studySetFileName: String
    let score: Int
    let accuracy: Int
    let elapsedSeconds: Int
    let xpEarned: Int
    let correctCount: Int
    let wrongCount: Int
    let comboPeak: Int
    let isNewRecord: Bool
}
