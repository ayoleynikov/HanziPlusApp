//
//  GameEngine.swift
//  HanziPlus
//

import Foundation

/// Shared lifecycle contract for all HanziPlus games.
/// New games conform to this protocol so the hub stays unchanged.
protocol GameSession: AnyObject {
    var studySet: StudySet { get }
    var gameKind: GameKind { get }
    var isFinished: Bool { get }
    var result: GameResult? { get }

    func restart()
}
