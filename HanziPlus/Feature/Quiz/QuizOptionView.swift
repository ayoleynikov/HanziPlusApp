import SwiftUI

struct QuizOptionView: View {

    let text: String
    let isSelected: Bool
    let action: () -> Void
    let isCorrect: Bool
    let showResult: Bool

    var body: some View {

        Button(action: action) {

            HStack {

                Text(text)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Spacer()

                if showResult {
                    if isCorrect {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                            .transition(.scale.combined(with: .opacity))
                    } else if isSelected {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.red)
                            .transition(.scale.combined(with: .opacity))
                    }
                } else if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.blue)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(backgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(borderColor, lineWidth: 2)
            )
            .shadow(
                color: isCorrect && showResult ? .green.opacity(0.35) : .clear,
                radius: 8
            )
            .scaleEffect(isCorrect && showResult ? 1.02 : 1.0)
            .animation(.spring(response: 0.35, dampingFraction: 0.7), value: showResult)
        }
        .buttonStyle(.plain)
        .disabled(showResult)
    }

    private var backgroundColor: Color {
        guard showResult else {
            return isSelected ? Color.blue.opacity(0.15) : Color(.systemBackground)
        }

        if isCorrect {
            return .green.opacity(0.2)
        }

        if isSelected {
            return .red.opacity(0.2)
        }

        return Color(.systemBackground)
    }

    private var borderColor: Color {
        guard showResult else {
            return isSelected ? .blue : Color.gray.opacity(0.2)
        }

        if isCorrect {
            return .green
        }

        if isSelected {
            return .red
        }

        return Color.gray.opacity(0.2)
    }
}

#Preview {
    VStack(spacing: 16) {
        QuizOptionView(text: "Hello", isSelected: false, action: {}, isCorrect: false, showResult: false)
        QuizOptionView(text: "Study", isSelected: true, action: {}, isCorrect: true, showResult: true)
    }
    .padding()
}
