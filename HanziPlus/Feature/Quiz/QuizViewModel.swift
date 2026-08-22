import Foundation
import Observation

@Observable
final class QuizViewModel {

    let studySet: StudySet
    private let defaults = UserDefaults.standard
    private let statisticsStore: StatisticsStore
    private(set) var words: [Word]

    private(set) var currentIndex = 0
    private(set) var selectedAnswer: String?
    private(set) var correctAnswers = 0
    private(set) var wrongAnswers = 0
private(set) var showResult = false
private(set) var isFinished = false

    init(
        studySet: StudySet,
        questionCount: Int = 20,
        statisticsStore: StatisticsStore
    ) {
        self.studySet = studySet
        self.statisticsStore = statisticsStore

        let loadedWords = WordLoader.load(fileName: studySet.fileName).shuffled()
        self.words = Array(loadedWords.prefix(questionCount))
    }

    var currentWord: Word? {
        guard !words.isEmpty, currentIndex < words.count else { return nil }
        return words[currentIndex]
    }

    var progress: Double {
        guard !words.isEmpty else { return 0 }
        return Double(currentIndex + 1) / Double(words.count)
    }

    var progressText: String {
        words.isEmpty ? "No words" : "\(currentIndex + 1) / \(words.count)"
    }

    var bestScore: Int {
        defaults.integer(forKey: "bestScore_\(studySet.fileName)")
    }

    var options: [String] {
        guard let currentWord else { return [] }

        var answers = words
            .filter { $0.id != currentWord.id }
            .map(\.english)
            .shuffled()

        answers = Array(answers.prefix(3))
        answers.append(currentWord.english)

        return answers.shuffled()
    }

    func select(_ answer: String) {

        guard let currentWord else { return }
        guard selectedAnswer == nil else { return }

        selectedAnswer = answer
        showResult = true

        if answer == currentWord.english {
            correctAnswers += 1
        } else {
            wrongAnswers += 1
        }
    }

    func nextQuestion() {

        if currentIndex < words.count - 1 {

            currentIndex += 1
            selectedAnswer = nil
            showResult = false

        } else {

            let score = Int(Double(correctAnswers) / Double(max(1, words.count)) * 100)

            if score > bestScore {
                defaults.set(score, forKey: "bestScore_\(studySet.fileName)")
            }

            statisticsStore.addQuiz(
                correct: correctAnswers,
                wrong: wrongAnswers
            )

            isFinished = true

        }
    }
    func restart() {
        words = words.shuffled()
        currentIndex = 0
        selectedAnswer = nil
        correctAnswers = 0
        wrongAnswers = 0
        showResult = false
        isFinished = false
    }
}
