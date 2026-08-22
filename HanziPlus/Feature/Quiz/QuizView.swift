import SwiftUI
import Observation

struct QuizView: View {

    @State private var viewModel: QuizViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var flashColor: Color = .clear

    init(studySet: StudySet, questionCount: Int = 20, statisticsStore: StatisticsStore) {
        _viewModel = State(initialValue: QuizViewModel(
            studySet: studySet,
            questionCount: questionCount,
            statisticsStore: statisticsStore
        ))
    }

    var body: some View {

        NavigationStack {

            

            Group {

                if viewModel.isFinished {

                    ScrollView {
                        VStack(spacing: 24) {
                        let total = max(1, viewModel.correctAnswers + viewModel.wrongAnswers)
                        let accuracy = Int(Double(viewModel.correctAnswers) / Double(total) * 100)

                        Button("Try Again") {
                            viewModel.restart()
                        }
                        .buttonStyle(.borderedProminent)

                        Button("Back to Library") {
                            dismiss()
                        }
                        .buttonStyle(.bordered)

                        Spacer()

                        Group {

                            if accuracy == 100 {

                                Image(systemName: "trophy.fill")
                                    .font(.system(size: 80))
                                    .foregroundStyle(.yellow)

                                Text("Perfect Score!")
                                    .font(.title.bold())
                                    .foregroundStyle(.yellow)

                            } else if accuracy >= 80 {

                                Image(systemName: "medal.fill")
                                    .font(.system(size: 80))
                                    .foregroundStyle(.gray)

                                Text("Excellent!")
                                    .font(.title.bold())

                            } else if accuracy >= 60 {

                                Image(systemName: "medal")
                                    .font(.system(size: 80))
                                    .foregroundStyle(.orange)

                                Text("Good Job!")
                                    .font(.title.bold())

                            } else {

                                Image(systemName: "book.fill")
                                    .font(.system(size: 80))
                                    .foregroundStyle(.blue)

                                Text("Keep Practicing!")
                                    .font(.title.bold())

                            }
                        }
                        .transition(.scale.combined(with: .opacity))
                        .animation(.spring(response: 0.45, dampingFraction: 0.7), value: accuracy)

                        Text("Quiz Complete")
                            .font(.largeTitle.bold())

                        Text("Correct: \(viewModel.correctAnswers)")
                            .font(.title2)

                        Text("Wrong: \(viewModel.wrongAnswers)")
                            .font(.title2)


                        Text("Accuracy: \(accuracy)%")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                        Text("🏅 Best Score: \(viewModel.bestScore)%")
                            .font(.headline)
                            .foregroundStyle(.yellow)

                        if accuracy >= viewModel.bestScore && accuracy > 0 {
                            Text("🎉 New Record!")
                                .font(.title3.bold())
                                .foregroundStyle(.green)
                                .transition(.scale.combined(with: .opacity))
                        }

                        VStack(spacing: 16) {
                            Text("Final Score")
                                .font(.headline)
                                .foregroundStyle(.secondary)

                            ZStack {
                                Circle()
                                    .stroke(Color(.systemGray5), lineWidth: 14)

                                Circle()
                                    .trim(from: 0, to: Double(accuracy) / 100)
                                    .stroke(.green, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                                    .rotationEffect(.degrees(-90))

                                Text("\(accuracy)%")
                                    .font(.largeTitle.bold())
                            }
                            .frame(width: 170, height: 170)
                        }

                        HStack(spacing: 20) {
                            Label("\(viewModel.correctAnswers)", systemImage: "checkmark.circle.fill")
                                .foregroundStyle(.green)

                            Label("\(viewModel.wrongAnswers)", systemImage: "xmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                        .font(.headline)

                        Spacer(minLength: 20)
                    }
                    .padding()
                }

                } else {

                    VStack(spacing: 24) {

                        Spacer()

                        ProgressView(value: viewModel.progress)
                            .tint(.blue)
                            .padding(.horizontal)

                        VStack(spacing: 16) {
                            if let word = viewModel.currentWord {
                                Text(word.hanzi)
                                    .font(.system(size: 64, weight: .bold))
                                    .scaleEffect(viewModel.showResult ? 1.08 : 1.0)
                                    .animation(.spring(duration: 0.35), value: viewModel.showResult)
                            } else {
                                Text("No words available")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 28)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .shadow(color: .black.opacity(0.08), radius: 10, y: 4)

                        Text("Choose the correct meaning")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 4)

                        VStack(spacing: 12) {
                            ForEach(viewModel.options, id: \.self) { option in
                                QuizOptionView(
                                    text: option,
                                    isSelected: viewModel.selectedAnswer == option,
                                    action: {
                                        viewModel.select(option)
                                    },
                                    isCorrect: option == viewModel.currentWord?.localizedMeaning,
                                    showResult: viewModel.showResult
                                )
                                .scaleEffect(viewModel.selectedAnswer == option ? 1.03 : 1.0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.65), value: viewModel.selectedAnswer)
                                .opacity(
                                    viewModel.showResult &&
                                    viewModel.selectedAnswer != option &&
                                    option != viewModel.currentWord?.localizedMeaning ? 0.45 : 1.0
                                )
                                .animation(.easeInOut(duration: 0.25), value: viewModel.showResult)
                            }
                        }

                        Text("Score: \(viewModel.correctAnswers) ✓   \(viewModel.wrongAnswers) ✗")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .padding(.bottom)

                        Spacer()
                    }
                    .background(
                        flashColor
                            .opacity(0.18)
                            .ignoresSafeArea()
                    )
                }
            }
            .padding()
            .navigationTitle("Quiz")
            .onChange(of: viewModel.showResult) { _, showResult in

                guard showResult else { return }

                withAnimation(.easeIn(duration: 0.15)) {
                    flashColor = viewModel.selectedAnswer == viewModel.currentWord?.localizedMeaning ? .green : .red
                }

                Task {
                    try? await Task.sleep(for: .seconds(1))

                    await MainActor.run {
                        withAnimation(.easeOut(duration: 0.25)) {
                            flashColor = .clear
                        }
                    }

                    await MainActor.run {
                        viewModel.nextQuestion()
                    }
                }
            }
            }
        }
    }


#Preview {
    QuizView(
        studySet: SampleStudySets.all[0],
        statisticsStore: StatisticsStore()
    )
}
