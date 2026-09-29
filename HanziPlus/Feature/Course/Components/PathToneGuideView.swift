//
//  PathToneGuideView.swift
//  HanziPlus
//

import SwiftUI

struct PathToneGuideView: View {

    let guide: PathToneGuide
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(guide.title.localizedValue())
                        .font(.title2.weight(.bold))

                    Text(guide.introduction.localizedValue())
                        .font(.body)
                        .foregroundStyle(.secondary)

                    ForEach(guide.tones) { tone in
                        toneRow(tone)
                    }

                    if let neutral = guide.neutralToneNote?.localizedValueOrNil() {
                        Text(neutral)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    if let mark = guide.toneMarkNote?.localizedValueOrNil() {
                        Text(mark)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }

            PathContinueButton(title: PathStrings.next, action: onContinue)
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("path_tone_guide")
    }

    private func toneRow(_ tone: PathToneGuide.PathToneExample) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Text("T\(tone.toneNumber)")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(PathCourseAccent.primary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background {
                        Capsule(style: .continuous)
                            .fill(PathCourseAccent.primary.opacity(0.12))
                    }
                Text(tone.pinyin)
                    .font(.title.weight(.bold))
                Text(tone.meaning.localizedValue())
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            ToneContourView(toneNumber: tone.toneNumber)
                .frame(height: 44)
                .accessibilityLabel(tone.contourDescription.localizedValue())

            Text(tone.contourDescription.localizedValue())
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        }
    }
}

private struct ToneContourView: View {
    let toneNumber: Int

    var body: some View {
        GeometryReader { proxy in
            Path { path in
                let width = proxy.size.width
                let height = proxy.size.height
                switch toneNumber {
                case 1:
                    // High level flat
                    path.move(to: CGPoint(x: 0, y: height * 0.22))
                    path.addLine(to: CGPoint(x: width, y: height * 0.22))
                case 2:
                    // Rising
                    path.move(to: CGPoint(x: 0, y: height * 0.72))
                    path.addLine(to: CGPoint(x: width, y: height * 0.22))
                case 3:
                    // Dip then rise
                    path.move(to: CGPoint(x: 0, y: height * 0.45))
                    path.addLine(to: CGPoint(x: width * 0.5, y: height * 0.78))
                    path.addLine(to: CGPoint(x: width, y: height * 0.28))
                case 4:
                    // Falling
                    path.move(to: CGPoint(x: 0, y: height * 0.22))
                    path.addLine(to: CGPoint(x: width, y: height * 0.78))
                default:
                    path.move(to: CGPoint(x: 0, y: height * 0.55))
                    path.addLine(to: CGPoint(x: width, y: height * 0.55))
                }
            }
            .stroke(Color.teal, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
        }
    }
}
