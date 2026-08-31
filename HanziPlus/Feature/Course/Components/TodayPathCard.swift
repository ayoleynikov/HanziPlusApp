//
//  TodayPathCard.swift
//  HanziPlus
//

import SwiftUI

struct TodayPathCard: View {

    let hasStarted: Bool
    let currentLessonNumber: Int
    let totalLessons: Int
    let progressFraction: Double
    let tint: Color

    private let chineseRed = Color(red: 0.78, green: 0.14, blue: 0.16)
    private let chineseGold = Color(red: 0.86, green: 0.66, blue: 0.22)

    private var buttonTitle: String {
        hasStarted ? PathStrings.continueCourse : PathStrings.startCourse
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Text("路")
                .font(.system(size: 88, weight: .ultraLight, design: .serif))
                .foregroundStyle(tint.opacity(0.07))
                .offset(x: 10, y: -6)
                .allowsHitTesting(false)

            Text("学")
                .font(.system(size: 54, weight: .ultraLight, design: .serif))
                .foregroundStyle(chineseGold.opacity(0.1))
                .offset(x: -120, y: 72)
                .allowsHitTesting(false)

            VStack(alignment: .leading, spacing: 18) {
                HStack(alignment: .top, spacing: 14) {
                    pathSealBadge

                    VStack(alignment: .leading, spacing: 6) {
                        Text(PathStrings.cardTitle)
                            .font(.title3.weight(.bold))
                            .fixedSize(horizontal: false, vertical: true)

                        Text(PathStrings.cardSubtitle)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(tint)
                            .fixedSize(horizontal: false, vertical: true)

                        Text(PathStrings.cardDetail)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    Spacer(minLength: 0)
                }

                if hasStarted {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(PathStrings.lessonProgress(current: currentLessonNumber, total: totalLessons))
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(L10n.percent(Int(progressFraction * 100)))
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(tint)
                        }

                        ProgressView(value: progressFraction)
                            .tint(tint)
                    }
                }

                HStack(spacing: 8) {
                    Text(buttonTitle)
                        .font(.body.weight(.semibold))

                    Image(systemName: "arrow.right")
                        .font(.subheadline.weight(.bold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background {
                    Capsule(style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [tint, tint.opacity(0.82)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }
                .foregroundStyle(.white)
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    chineseRed.opacity(0.05),
                                    tint.opacity(0.07),
                                    chineseGold.opacity(0.04)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                        .strokeBorder(
                            LinearGradient(
                                colors: [chineseGold.opacity(0.35), tint.opacity(0.28)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
                .overlay {
                    PathCardCornerAccents(color: chineseGold.opacity(0.28))
                }
        }
        .studyCardShadow()
        .accessibilityIdentifier("path_course_card")
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
    }

    private var pathSealBadge: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 11, style: .continuous)
                .fill(chineseRed.opacity(0.14))
                .frame(width: 56, height: 56)
                .overlay {
                    RoundedRectangle(cornerRadius: 11, style: .continuous)
                        .strokeBorder(chineseRed.opacity(0.42), lineWidth: 2)
                }
                .rotationEffect(.degrees(-8))

            VStack(spacing: 0) {
                Text("汉")
                    .font(.system(size: 26, weight: .medium, design: .serif))
                    .foregroundStyle(chineseRed)

                Text("+")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(chineseGold)
                    .offset(y: -2)
            }
            .rotationEffect(.degrees(-8))
        }
        .frame(width: 56, height: 56)
        .accessibilityHidden(true)
    }
}

private struct PathCardCornerAccents: View {
    let color: Color
    private let length: CGFloat = 12

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            accent(at: CGPoint(x: 10, y: 10), horizontal: 1, vertical: 1)
            accent(at: CGPoint(x: w - 10, y: 10), horizontal: -1, vertical: 1)
            accent(at: CGPoint(x: 10, y: h - 10), horizontal: 1, vertical: -1)
            accent(at: CGPoint(x: w - 10, y: h - 10), horizontal: -1, vertical: -1)
        }
        .allowsHitTesting(false)
    }

    private func accent(at origin: CGPoint, horizontal: CGFloat, vertical: CGFloat) -> some View {
        Path { path in
            path.move(to: CGPoint(x: origin.x, y: origin.y + vertical * length))
            path.addLine(to: origin)
            path.addLine(to: CGPoint(x: origin.x + horizontal * length, y: origin.y))
        }
        .stroke(color, style: StrokeStyle(lineWidth: 1.5, lineCap: .round))
    }
}

#Preview {
    VStack(spacing: 16) {
        TodayPathCard(
            hasStarted: false,
            currentLessonNumber: 1,
            totalLessons: 15,
            progressFraction: 0,
            tint: .teal
        )

        TodayPathCard(
            hasStarted: true,
            currentLessonNumber: 3,
            totalLessons: 15,
            progressFraction: 0.12,
            tint: .teal
        )
    }
    .padding()
}
