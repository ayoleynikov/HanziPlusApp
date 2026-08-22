//
//  LiveGameScenes.swift
//  HanziPlus
//

import SwiftUI

// MARK: - Live scene router

struct LiveGameScene: View {
    let game: GameDefinition
    let height: CGFloat

    var body: some View {
        switch game.kind {
        case .hanziMemory: LiveMemoryScene(height: height, tint: game.color)
        case .speedChallenge: LiveSpeedScene(height: height)
        case .listeningQuiz: LiveListeningScene(height: height, tint: game.color)
        case .typingChallenge: LiveTypingScene(height: height)
        case .smartReview: LiveReviewScene(height: height, tint: game.color)
        case .matchPairs: LiveMatchPairsScene(height: height, tint: game.color)
        case .findTheHanzi: LiveFindHanziScene(height: height, tint: game.color)
        case .sentenceBuilder: LiveSentenceScene(height: height, tint: game.color)
        case .dailyChallenge: LiveDailyScene(height: height)
        }
    }
}

// MARK: - Shared primitives

private struct DriftingParticle: View {
    let index: Int
    let height: CGFloat
    let color: Color
    let amplitude: CGFloat
    let speed: Double

    @State private var drift = false

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: particleSize, height: particleSize)
            .blur(radius: particleSize > 4 ? 0.5 : 0)
            .offset(
                x: startX + (drift ? amplitude : -amplitude * 0.4),
                y: startY + (drift ? -amplitude * 0.6 : amplitude * 0.35)
            )
            .opacity(drift ? 0.75 : 0.25)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: speed)
                    .repeatForever(autoreverses: true)
                    .delay(Double(index) * 0.22)
                ) {
                    drift = true
                }
            }
    }

    private var particleSize: CGFloat {
        CGFloat(2 + (index % 3))
    }

    private var startX: CGFloat {
        cos(Double(index) * 1.35) * height * 0.32
    }

    private var startY: CGFloat {
        sin(Double(index) * 0.95) * height * 0.22
    }
}

private struct SoftGlow: View {
    let color: Color
    let size: CGFloat
    let pulse: Bool

    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    colors: [color.opacity(pulse ? 0.42 : 0.24), .clear],
                    center: .center,
                    startRadius: 0,
                    endRadius: size * 0.5
                )
            )
            .frame(width: size, height: size)
            .blur(radius: size * 0.08)
    }
}

// MARK: - Memory Match · floating cards · periodic flip · soft glow

private struct LiveMemoryScene: View {
    let height: CGFloat
    let tint: Color

    @State private var float = false
    @State private var cardFlip = false
    @State private var glowPulse = false
    @State private var flipIndex = 0

    private let characters = ["学", "习", "中", "文"]

    var body: some View {
        ZStack {
            SoftGlow(color: tint, size: height * 0.72, pulse: glowPulse)
                .offset(x: height * 0.12, y: height * 0.02)

            ForEach(0..<4, id: \.self) { index in
                memoryCard(index: index)
            }

            ForEach(0..<8, id: \.self) { i in
                DriftingParticle(
                    index: i,
                    height: height,
                    color: .white.opacity(0.55),
                    amplitude: 10,
                    speed: 3.6 + Double(i % 3) * 0.4
                )
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 3.4).repeatForever(autoreverses: true)) {
                float = true
                glowPulse = true
            }
            startFlipLoop()
        }
    }

    private func memoryCard(index: Int) -> some View {
        let isFlipping = index == flipIndex
        let baseRotation = Double(index - 1) * 9
        let floatY = float ? -5.0 : 5.0

        return ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [.white.opacity(0.96), .white.opacity(0.82)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(.white.opacity(0.5), lineWidth: 0.5)
                }

            Text(isFlipping && cardFlip ? "?" : characters[index])
                .font(.system(size: height * 0.085, weight: .bold))
                .foregroundStyle(isFlipping && cardFlip ? tint.opacity(0.5) : tint)
                .rotation3DEffect(.degrees(isFlipping && cardFlip ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        }
        .frame(width: height * 0.15, height: height * 0.19)
        .rotationEffect(.degrees(baseRotation + (float ? Double(index - 1) * 1.5 : Double(1 - index) * 1.2)))
        .offset(
            x: CGFloat(index - 1) * height * 0.11 + height * 0.08,
            y: CGFloat(index % 2 == 0 ? -1 : 1) * 8 + floatY
        )
        .shadow(color: tint.opacity(0.18), radius: 10, y: 6)
        .zIndex(isFlipping ? 2 : Double(index))
    }

    private func startFlipLoop() {
        Task { @MainActor in
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(3.2))
                withAnimation(.spring(response: 0.55, dampingFraction: 0.72)) {
                    cardFlip = true
                }
                try? await Task.sleep(for: .milliseconds(900))
                withAnimation(.spring(response: 0.5, dampingFraction: 0.78)) {
                    cardFlip = false
                }
                flipIndex = (flipIndex + 1) % characters.count
            }
        }
    }
}

// MARK: - Word Match · connecting lines · sliding pairs · connect particles

private struct LiveMatchPairsScene: View {
    let height: CGFloat
    let tint: Color

    @State private var lineProgress: CGFloat = 0
    @State private var slideIn = false
    @State private var spark = false
    @State private var activePair = 0

    private let pairs: [(hanzi: String, english: String)] = [
        ("龙", "Dragon"),
        ("水", "Water")
    ]

    var body: some View {
        ZStack {
            ForEach(0..<6, id: \.self) { i in
                DriftingParticle(
                    index: i + 2,
                    height: height,
                    color: tint.opacity(0.45),
                    amplitude: 8,
                    speed: 4.2
                )
            }

            if lineProgress > 0 {
                AnimatedMatchLine(height: height, progress: lineProgress, tint: tint)
            }

            if spark {
                ForEach(0..<5, id: \.self) { i in
                    ConnectSpark(index: i, height: height)
                }
            }

            pairColumn(index: 0, side: -1)
            pairColumn(index: 1, side: 1)
        }
        .onAppear {
            startPairLoop()
        }
    }

    private func pairColumn(index: Int, side: Int) -> some View {
        let pair = pairs[index]
        let xBase = CGFloat(side) * height * 0.22
        let slideOffset = slideIn ? 0 : CGFloat(side) * 22

        return VStack(spacing: height * 0.06) {
            matchTile(text: pair.hanzi, isHanzi: true)
            matchTile(text: pair.english, isHanzi: false)
        }
        .offset(x: xBase + slideOffset, y: CGFloat(index) * 4)
        .opacity(index == activePair ? 1 : 0.45)
        .scaleEffect(index == activePair ? 1 : 0.92)
    }

    private func matchTile(text: String, isHanzi: Bool) -> some View {
        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .fill(.white.opacity(0.92))
            .frame(width: height * 0.2, height: height * 0.11)
            .overlay {
                Text(text)
                    .font(.system(size: isHanzi ? height * 0.07 : height * 0.045, weight: .bold))
                    .foregroundStyle(isHanzi ? .orange : .blue.opacity(0.85))
            }
            .shadow(color: .black.opacity(0.1), radius: 6, y: 3)
    }

    private func startPairLoop() {
        Task { @MainActor in
            while !Task.isCancelled {
                slideIn = false
                lineProgress = 0
                spark = false

                withAnimation(.spring(response: 0.7, dampingFraction: 0.82)) {
                    slideIn = true
                }

                try? await Task.sleep(for: .milliseconds(600))

                withAnimation(.easeInOut(duration: 1.1)) {
                    lineProgress = 1
                }

                try? await Task.sleep(for: .milliseconds(950))

                withAnimation(.easeOut(duration: 0.35)) {
                    spark = true
                }

                try? await Task.sleep(for: .seconds(2))

                activePair = (activePair + 1) % pairs.count
            }
        }
    }
}

private struct AnimatedMatchLine: View {
    let height: CGFloat
    let progress: CGFloat
    let tint: Color

    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: -height * 0.08, y: -height * 0.04))
            path.addQuadCurve(
                to: CGPoint(x: height * 0.08, y: height * 0.04),
                control: CGPoint(x: 0, y: -height * 0.1)
            )
        }
        .trim(from: 0, to: progress)
        .stroke(
            LinearGradient(colors: [tint.opacity(0.3), tint, .cyan], startPoint: .leading, endPoint: .trailing),
            style: StrokeStyle(lineWidth: 2.5, lineCap: .round)
        )
        .shadow(color: tint.opacity(0.45), radius: 4)
    }
}

// MARK: - Speed Challenge · train · skyline · streak lines

private struct LiveSpeedScene: View {
    let height: CGFloat

    @State private var trainOffset: CGFloat = -18
    @State private var lightsOn = true
    @State private var streakPhase = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.indigo.opacity(0.88), Color(red: 0.08, green: 0.05, blue: 0.22)],
                startPoint: .top,
                endPoint: .bottom
            )

            ForEach(0..<4, id: \.self) { i in
                Capsule()
                    .fill(.white.opacity(streakPhase ? 0.18 : 0.06))
                    .frame(width: height * 0.28, height: 1.5)
                    .offset(x: -height * 0.35 + CGFloat(i) * 18, y: CGFloat(i - 2) * 14)
            }

            HStack(spacing: 6) {
                ForEach(Array([14, 22, 18, 26, 16, 24, 20, 28].enumerated()), id: \.offset) { i, h in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.yellow.opacity(lightsOn || i % 2 == 0 ? 0.8 : 0.32))
                        .frame(width: 4, height: CGFloat(h))
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, height * 0.08)

            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(LinearGradient(colors: [.white, .orange.opacity(0.88)], startPoint: .leading, endPoint: .trailing))
                .frame(width: height * 0.72, height: height * 0.14)
                .overlay {
                    HStack(spacing: 8) {
                        ForEach(0..<4, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 3)
                                .fill(.cyan.opacity(0.85))
                                .frame(width: height * 0.08, height: height * 0.06)
                        }
                    }
                }
                .shadow(color: .orange.opacity(0.35), radius: 12, y: 4)
                .offset(x: trainOffset, y: height * 0.12)

            Image(systemName: "bolt.fill")
                .font(.system(size: height * 0.11, weight: .bold))
                .foregroundStyle(.yellow)
                .shadow(color: .yellow.opacity(0.6), radius: 8)
                .offset(x: height * 0.3, y: -height * 0.2)
                .symbolEffect(.pulse, options: .repeating)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true)) {
                trainOffset = 16
            }
            withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
                lightsOn.toggle()
            }
            withAnimation(.linear(duration: 1.4).repeatForever(autoreverses: false)) {
                streakPhase = true
            }
        }
    }
}

// MARK: - Listening · waveform · pulsing headphones · expanding rings

private struct LiveListeningScene: View {
    let height: CGFloat
    let tint: Color

    @State private var wavePhase = false
    @State private var headphonePulse = false
    @State private var ringExpand = false

    var body: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { i in
                Circle()
                    .stroke(tint.opacity(ringExpand ? 0 : 0.35 - Double(i) * 0.08), lineWidth: 1.5)
                    .frame(width: height * (0.28 + CGFloat(i) * 0.14))
                    .scaleEffect(ringExpand ? 1.35 : 0.85)
                    .offset(x: -height * 0.04)
            }

            waveform
                .offset(y: height * 0.18)

            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [tint.opacity(0.55), .purple.opacity(0.45)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: height * 0.24)

                Image(systemName: "headphones")
                    .font(.system(size: height * 0.13, weight: .semibold))
                    .foregroundStyle(.white)
                    .scaleEffect(headphonePulse ? 1.06 : 0.94)
            }
            .offset(x: -height * 0.04, y: -height * 0.02)
            .shadow(color: tint.opacity(0.35), radius: 14)

            ForEach(0..<5, id: \.self) { i in
                Image(systemName: "music.note")
                    .font(.system(size: height * 0.045))
                    .foregroundStyle(.white.opacity(0.45))
                    .offset(
                        x: (wavePhase ? height * 0.32 : -height * 0.34) + CGFloat(i) * 8,
                        y: -height * 0.12 + CGFloat(i % 3) * 10
                    )
                    .opacity(0.35 + Double(i) * 0.08)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.85).repeatForever(autoreverses: true)) {
                wavePhase = true
            }
            withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                headphonePulse = true
            }
            withAnimation(.easeOut(duration: 2.4).repeatForever(autoreverses: false)) {
                ringExpand = true
            }
        }
    }

    private var waveform: some View {
        HStack(spacing: 3) {
            ForEach(0..<14, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(.white.opacity(0.55))
                    .frame(width: 3, height: barHeight(index: index))
            }
        }
    }

    private func barHeight(index: Int) -> CGFloat {
        let base = abs(sin(Double(index) * 0.65 + (wavePhase ? 1.2 : 0)))
        return height * 0.04 + height * 0.1 * base
    }
}

// MARK: - Character Builder · brush strokes · ink trail · particles

private struct LiveTypingScene: View {
    let height: CGFloat

    @State private var strokeProgress: CGFloat = 0
    @State private var brushOffset: CGSize = .zero
    @State private var inkDrip = false

    var body: some View {
        ZStack {
            SoftGlow(color: .orange, size: height * 0.5, pulse: strokeProgress > 0.5)

            ZStack {
                ForEach(0..<3, id: \.self) { index in
                    BrushStrokeSegment(index: index, progress: strokeProgress, height: height)
                }

                Text("文")
                    .font(.system(size: height * 0.26, weight: .bold, design: .serif))
                    .foregroundStyle(.white.opacity(0.15))
                    .offset(x: height * 0.14, y: -height * 0.04)
            }

            Image(systemName: "paintbrush.pointed.fill")
                .font(.system(size: height * 0.16, weight: .semibold))
                .foregroundStyle(
                    LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
                )
                .rotationEffect(.degrees(-28))
                .offset(
                    x: -height * 0.08 + brushOffset.width,
                    y: height * 0.1 + brushOffset.height
                )
                .shadow(color: .orange.opacity(0.5), radius: 8)

            ForEach(0..<6, id: \.self) { i in
                Circle()
                    .fill(.orange.opacity(0.7))
                    .frame(width: 3, height: 3)
                    .offset(
                        x: height * 0.14 + CGFloat(i * 3),
                        y: height * 0.02 + (inkDrip ? 16 : 0)
                    )
                    .opacity(inkDrip ? 0 : 0.8)
            }
        }
        .onAppear {
            startStrokeLoop()
        }
    }

    private func startStrokeLoop() {
        Task { @MainActor in
            while !Task.isCancelled {
                strokeProgress = 0
                inkDrip = false
                brushOffset = CGSize(width: -12, height: 8)

                withAnimation(.easeInOut(duration: 2.4)) {
                    strokeProgress = 1
                    brushOffset = CGSize(width: 18, height: -10)
                }

                try? await Task.sleep(for: .milliseconds(1800))

                withAnimation(.easeOut(duration: 0.5)) {
                    inkDrip = true
                }

                try? await Task.sleep(for: .seconds(1.8))
            }
        }
    }
}

private struct BrushStrokeSegment: View {
    let index: Int
    let progress: CGFloat
    let height: CGFloat

    var body: some View {
        let segmentStart = CGFloat(index) / 3
        let segmentEnd = CGFloat(index + 1) / 3
        let localProgress = min(max((progress - segmentStart) / (segmentEnd - segmentStart), 0), 1)

        Capsule()
            .fill(
                LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing)
            )
            .frame(width: height * segmentWidth, height: height * 0.035)
            .scaleEffect(x: localProgress, y: 1, anchor: .leading)
            .rotationEffect(.degrees(segmentAngle))
            .offset(segmentOffset)
            .shadow(color: .yellow.opacity(0.55), radius: 6)
    }

    private var segmentWidth: CGFloat {
        switch index {
        case 0: 0.14
        case 1: 0.1
        default: 0.12
        }
    }

    private var segmentAngle: Double {
        switch index {
        case 0: -8
        case 1: 90
        default: -42
        }
    }

    private var segmentOffset: CGSize {
        switch index {
        case 0: CGSize(width: height * 0.06, height: -height * 0.06)
        case 1: CGSize(width: height * 0.14, height: -height * 0.02)
        default: CGSize(width: height * 0.1, height: height * 0.05)
        }
    }
}

// MARK: - Find the Hanzi · scanning beam · pinyin floats · target glow

private struct LiveFindHanziScene: View {
    let height: CGFloat
    let tint: Color

    @State private var scanX: CGFloat = 0
    @State private var targetGlow = false
    @State private var toneBounce = false

    private let gridChars = ["己", "已", "巳", "巴"]
    private let pinyinParts: [(String, String)] = [("jǐ", "ˇ"), ("yǐ", "ˇ"), ("sì", "ˋ")]

    var body: some View {
        ZStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 2), spacing: 8) {
                ForEach(Array(gridChars.enumerated()), id: \.offset) { index, char in
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(.white.opacity(index == 2 ? (targetGlow ? 0.95 : 0.75) : 0.55))
                        .frame(width: height * 0.13, height: height * 0.13)
                        .overlay {
                            Text(char)
                                .font(.system(size: height * 0.065, weight: .bold))
                                .foregroundStyle(index == 2 ? tint : .white.opacity(0.85))
                        }
                        .overlay {
                            if index == 2 {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .strokeBorder(tint.opacity(targetGlow ? 0.9 : 0.3), lineWidth: 2)
                            }
                        }
                        .shadow(color: index == 2 ? tint.opacity(0.35) : .clear, radius: 8)
                }
            }
            .frame(width: height * 0.32)
            .offset(x: -height * 0.06, y: height * 0.04)

            RoundedRectangle(cornerRadius: 4, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [.clear, tint.opacity(0.35), .clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: height * 0.08, height: height * 0.34)
                .offset(x: scanX, y: height * 0.04)
                .blur(radius: 1)

            Image(systemName: "magnifyingglass")
                .font(.system(size: height * 0.11, weight: .bold))
                .foregroundStyle(.white.opacity(0.92))
                .offset(x: height * 0.28, y: -height * 0.16)
                .offset(y: toneBounce ? -2 : 2)

            HStack(spacing: 10) {
                ForEach(Array(pinyinParts.enumerated()), id: \.offset) { index, part in
                    HStack(spacing: 1) {
                        Text(part.0)
                            .font(.system(size: height * 0.038, weight: .semibold, design: .rounded))
                        Text(part.1)
                            .font(.system(size: height * 0.034, weight: .bold))
                            .offset(y: toneBounce ? -3 : 1)
                    }
                    .foregroundStyle(.white.opacity(0.75))
                    .offset(y: CGFloat(index - 1) * (toneBounce ? -2 : 2))
                }
            }
            .offset(y: -height * 0.2)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.8).repeatForever(autoreverses: true)) {
                scanX = height * 0.12
                targetGlow = true
                toneBounce = true
            }
        }
    }
}

// MARK: - Sentence Builder · sliding words · slot snap · sparkles

private struct LiveSentenceScene: View {
    let height: CGFloat
    let tint: Color

    @State private var assemblyStep = 0
    @State private var sparkle = false
    @State private var wordOffsets: [CGFloat] = [ -24, -24, -24, -24 ]

    private let words = ["我", "喜欢", "学习", "中文"]
    private let slotCount = 4

    var body: some View {
        ZStack {
            HStack(spacing: height * 0.025) {
                ForEach(0..<slotCount, id: \.self) { index in
                    sentenceSlot(index: index)
                }
            }

            if sparkle {
                ForEach(0..<6, id: \.self) { i in
                    SparkleBurst(index: i, height: height, active: sparkle)
                }
            }
        }
        .onAppear {
            startAssemblyLoop()
        }
    }

    private func sentenceSlot(index: Int) -> some View {
        let filled = index < assemblyStep

        return ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .strokeBorder(.white.opacity(filled ? 0 : 0.35), style: StrokeStyle(lineWidth: 1.5, dash: filled ? [] : [4, 4]))
                .frame(width: height * wordWidth(index: index), height: height * 0.08)
                .background {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(.white.opacity(filled ? 0.9 : 0.08))
                }

            if filled {
                Text(words[index])
                    .font(.system(size: height * 0.042, weight: .bold))
                    .foregroundStyle(tint)
                    .offset(y: wordOffsets[index])
            }
        }
        .scaleEffect(filled && sparkle ? 1.04 : 1)
        .animation(.spring(response: 0.45, dampingFraction: 0.68), value: assemblyStep)
    }

    private func wordWidth(index: Int) -> CGFloat {
        switch index {
        case 1: 0.16
        case 2: 0.14
        default: 0.1
        }
    }

    private func startAssemblyLoop() {
        Task { @MainActor in
            while !Task.isCancelled {
                assemblyStep = 0
                sparkle = false
                wordOffsets = [-24, -24, -24, -24]

                for step in 1...slotCount {
                    try? await Task.sleep(for: .milliseconds(650))
                    let index = step - 1
                    withAnimation(.spring(response: 0.55, dampingFraction: 0.72)) {
                        assemblyStep = step
                        wordOffsets[index] = 0
                    }
                }

                try? await Task.sleep(for: .milliseconds(300))
                withAnimation(.easeOut(duration: 0.4)) {
                    sparkle = true
                }

                try? await Task.sleep(for: .seconds(1.6))
            }
        }
    }
}

// MARK: - Quiz Challenge · card flip · active glow · floating stack

private struct LiveReviewScene: View {
    let height: CGFloat
    let tint: Color

    @State private var float = false
    @State private var cardFlip = false
    @State private var activeGlow = false

    private let prompts = ["词", "?", "汇"]

    var body: some View {
        ZStack {
            SoftGlow(color: tint, size: height * 0.55, pulse: activeGlow)
                .offset(x: height * 0.06, y: -height * 0.02)

            ForEach(Array(prompts.enumerated()), id: \.offset) { index, prompt in
                quizCard(prompt: prompt, index: index)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 3.2).repeatForever(autoreverses: true)) {
                float = true
                activeGlow = true
            }
            startFlipLoop()
        }
    }

    private func quizCard(prompt: String, index: Int) -> some View {
        let isTop = index == prompts.count - 1
        let displayPrompt = isTop && cardFlip ? "义" : prompt

        return RoundedRectangle(cornerRadius: 12, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [
                        .white.opacity(isTop ? 0.95 : 0.72),
                        .white.opacity(isTop ? 0.82 : 0.55)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: height * 0.2, height: height * 0.26)
            .overlay {
                Text(displayPrompt)
                    .font(.system(size: height * 0.09, weight: .bold))
                    .foregroundStyle(tint)
                    .rotation3DEffect(.degrees(isTop && cardFlip ? 180 : 0), axis: (x: 0, y: 1, z: 0))
            }
            .overlay {
                if isTop {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(tint.opacity(activeGlow ? 0.55 : 0.2), lineWidth: 2)
                }
            }
            .rotationEffect(.degrees(Double(index - 1) * 4))
            .offset(
                x: CGFloat(index - 1) * 10,
                y: CGFloat(index - 1) * 8 + (float ? -4 : 4)
            )
            .shadow(color: .black.opacity(isTop ? 0.16 : 0.08), radius: isTop ? 10 : 4, y: 5)
            .zIndex(Double(index))
    }

    private func startFlipLoop() {
        Task { @MainActor in
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(2.8))
                withAnimation(.spring(response: 0.55, dampingFraction: 0.74)) {
                    cardFlip = true
                }
                try? await Task.sleep(for: .milliseconds(800))
                withAnimation(.spring(response: 0.5, dampingFraction: 0.78)) {
                    cardFlip = false
                }
            }
        }
    }
}

private struct ConnectSpark: View {
    let index: Int
    let height: CGFloat

    @State private var burst = false

    var body: some View {
        Circle()
            .fill(.yellow.opacity(0.9))
            .frame(width: 4, height: 4)
            .offset(
                x: height * 0.02 + cos(Double(index) * 1.4) * (burst ? 22 : 2),
                y: sin(Double(index) * 1.4) * (burst ? 16 : 2)
            )
            .opacity(burst ? 0 : 1)
            .onAppear {
                withAnimation(.easeOut(duration: 0.45)) {
                    burst = true
                }
            }
    }
}

private struct SparkleBurst: View {
    let index: Int
    let height: CGFloat
    let active: Bool

    @State private var burst = false

    var body: some View {
        Image(systemName: "sparkle")
            .font(.system(size: height * 0.035))
            .foregroundStyle(.yellow.opacity(0.9))
            .offset(
                x: cos(Double(index) * 1.1) * (burst ? 30 : 4),
                y: sin(Double(index) * 1.1) * (burst ? 22 : 4)
            )
            .opacity(burst ? 0 : 1)
            .onChange(of: active) { _, isActive in
                guard isActive else { return }
                burst = false
                withAnimation(.easeOut(duration: 0.5)) {
                    burst = true
                }
            }
            .onAppear {
                if active {
                    withAnimation(.easeOut(duration: 0.5)) {
                        burst = true
                    }
                }
            }
    }
}

// MARK: - Daily Challenge · sun rays · calendar pulse

private struct LiveDailyScene: View {
    let height: CGFloat

    @State private var sunRotation = false
    @State private var calendarPulse = false
    @State private var checkBounce = false

    var body: some View {
        ZStack {
            ForEach(0..<8, id: \.self) { i in
                Capsule()
                    .fill(.yellow.opacity(0.2))
                    .frame(width: 2, height: height * 0.08)
                    .offset(y: -height * 0.14)
                    .rotationEffect(.degrees(Double(i) * 45 + (sunRotation ? 6 : 0)))
            }

            Image(systemName: "sun.max.fill")
                .font(.system(size: height * 0.18))
                .foregroundStyle(.yellow.opacity(0.9))
                .offset(x: height * 0.24, y: -height * 0.18)
                .rotationEffect(.degrees(sunRotation ? 12 : 0))

            Image(systemName: "calendar")
                .font(.system(size: height * 0.15, weight: .semibold))
                .foregroundStyle(.white.opacity(0.92))
                .scaleEffect(calendarPulse ? 1.05 : 0.96)

            HStack(spacing: height * 0.04) {
                ForEach(0..<3, id: \.self) { i in
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green.opacity(0.85))
                        .font(.system(size: height * 0.05))
                        .offset(y: checkBounce ? -2 : 2)
                        .opacity(Double(i + 1) * 0.25 + (checkBounce ? 0.15 : 0))
                }
            }
            .offset(y: height * 0.18)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                sunRotation = true
            }
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                calendarPulse = true
                checkBounce = true
            }
        }
    }
}
