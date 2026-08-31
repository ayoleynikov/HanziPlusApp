//
//  StudySessionStore.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/28.
//

import Foundation
import Observation

struct StudySession: Codable, Equatable {

    var wordOrder: [String]
    var currentIndex: Int
}

@Observable
final class StudySessionStore {

    private let defaults = UserDefaults.standard
    private let sessionsKey = "studySessions"
    private let lastActiveKey = "lastActiveStudySet"

    private var sessions: [String: StudySession] = [:]
    private(set) var lastActiveFileName: String?

    init() {
        load()
    }

    func session(for fileName: String) -> StudySession? {
        sessions[fileName]
    }

    func hasSession(matchingPrefix prefix: String) -> Bool {
        sessions.keys.contains { $0.hasPrefix(prefix) }
    }

    func save(fileName: String, wordOrder: [String], currentIndex: Int) {
        guard !wordOrder.isEmpty else {
            sessions.removeValue(forKey: fileName)
            persistSessions()
            return
        }

        let safeIndex = min(max(currentIndex, 0), wordOrder.count - 1)
        sessions[fileName] = StudySession(wordOrder: wordOrder, currentIndex: safeIndex)
        persistSessions()
    }

    func setLastActive(_ fileName: String) {
        lastActiveFileName = fileName
        defaults.set(fileName, forKey: lastActiveKey)
    }

    func reset(matchingPrefix prefix: String) {
        sessions = sessions.filter { !$0.key.hasPrefix(prefix) }
        persistSessions()

        if let lastActive = lastActiveFileName, lastActive.hasPrefix(prefix) {
            lastActiveFileName = nil
            defaults.removeObject(forKey: lastActiveKey)
        }
    }

    func reset(fileName: String) {
        sessions.removeValue(forKey: fileName)
        persistSessions()

        if lastActiveFileName == fileName {
            lastActiveFileName = nil
            defaults.removeObject(forKey: lastActiveKey)
        }
    }

    func resetAll() {
        sessions.removeAll()
        lastActiveFileName = nil
        defaults.removeObject(forKey: lastActiveKey)
        persistSessions()
    }

    func restoreWords(from loadedWords: [Word], fileName: String) -> (words: [Word], index: Int) {
        guard !loadedWords.isEmpty else {
            return ([], 0)
        }

        guard
            let session = sessions[fileName],
            session.wordOrder.count == loadedWords.count,
            let restored = restoreWordOrder(session.wordOrder, from: loadedWords)
        else {
            let shuffled = loadedWords.shuffled()
            save(fileName: fileName, wordOrder: shuffled.map(\.hanzi), currentIndex: 0)
            return (shuffled, 0)
        }

        let index = min(max(session.currentIndex, 0), restored.count - 1)
        return (restored, index)
    }

    /// Rebuilds the saved shuffle order, matching duplicate hanzi entries safely.
    private func restoreWordOrder(_ order: [String], from loadedWords: [Word]) -> [Word]? {
        var remaining = loadedWords
        var restored: [Word] = []

        for hanzi in order {
            guard let index = remaining.firstIndex(where: { $0.hanzi == hanzi }) else {
                return nil
            }
            restored.append(remaining.remove(at: index))
        }

        guard restored.count == loadedWords.count else { return nil }
        return restored
    }

    private func load() {
        if let data = defaults.data(forKey: sessionsKey),
           let decoded = try? JSONDecoder().decode([String: StudySession].self, from: data) {
            sessions = decoded
        }

        lastActiveFileName = defaults.string(forKey: lastActiveKey)
    }

    private func persistSessions() {
        guard let data = try? JSONEncoder().encode(sessions) else { return }
        defaults.set(data, forKey: sessionsKey)
    }
}
