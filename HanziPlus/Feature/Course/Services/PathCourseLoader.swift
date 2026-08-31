//
//  PathCourseLoader.swift
//  HanziPlus
//

import Foundation
import OSLog

enum PathCourseLoader {

    private static let logger = Logger(subsystem: "ayoleynikov.HanziPlus", category: "PathCourseLoader")

    static func loadCourse() -> PathCourse? {
        load("course", as: PathCourse.self)
    }

    static func loadLesson(fileName: String) -> PathLesson? {
        load(fileName, as: PathLesson.self)
    }

    static func previewCourse() -> PathCourse {
        loadCourse() ?? PathCourse(
            id: "hanzi-plus-path",
            title: "Hanzi+ Path",
            subtitle: "Китайский с нуля — шаг за шагом",
            summary: "",
            description: "",
            volumeCount: 1,
            totalLessons: 15,
            lessons: []
        )
    }

    static func previewLesson() -> PathLesson {
        loadLesson(fileName: "lesson_01") ?? PathLesson(
            id: "lesson_01",
            number: 1,
            sourceLessonNumbers: [1],
            chineseTitle: "你好！",
            chineseSubtitle: nil,
            pinyinTitle: nil,
            translationTitle: nil,
            sections: []
        )
    }

    private static func load<T: Decodable>(_ fileName: String, as type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json", subdirectory: "PathCourse")
            ?? Bundle.main.url(forResource: fileName, withExtension: "json")
        else {
            logger.error("Path course JSON not found: \(fileName).json")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            logger.error("Failed to decode \(fileName).json: \(error.localizedDescription)")
            return nil
        }
    }
}
