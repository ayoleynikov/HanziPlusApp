//
//  GameSessionStore.swift
//  HanziPlus
//

import Foundation
import Observation

struct ActiveGameSession: Codable, Equatable {
    let gameKind: GameKind
    let studySetFileName: String
    let studySetTitle: String
    let difficulty: GameDifficulty
    let memoryMode: MemoryMatchMode?
    let progressLabel: String
    let progressValue: Double
    let savedAt: Date

    var gameTitle: String {
        GameDefinition.definition(for: gameKind).title
    }
}

@Observable
final class GameSessionStore {

    private let defaults = UserDefaults.standard
    private let sessionKey = "games.activeSession"

    private(set) var activeSession: ActiveGameSession?

    init() {
        load()
    }

    var hasActiveSession: Bool {
        activeSession != nil
    }

    func save(_ session: ActiveGameSession) {
        activeSession = session
        persist()
    }

    func clear() {
        activeSession = nil
        defaults.removeObject(forKey: sessionKey)
    }

    func updateProgress(label: String, value: Double) {
        guard var session = activeSession else { return }
        session = ActiveGameSession(
            gameKind: session.gameKind,
            studySetFileName: session.studySetFileName,
            studySetTitle: session.studySetTitle,
            difficulty: session.difficulty,
            memoryMode: session.memoryMode,
            progressLabel: label,
            progressValue: value,
            savedAt: Date()
        )
        activeSession = session
        persist()
    }

    private func load() {
        guard
            let data = defaults.data(forKey: sessionKey),
            let decoded = try? JSONDecoder().decode(ActiveGameSession.self, from: data)
        else { return }
        activeSession = decoded
    }

    private func persist() {
        guard let session = activeSession else { return }
        guard let data = try? JSONEncoder().encode(session) else { return }
        defaults.set(data, forKey: sessionKey)
    }
}
