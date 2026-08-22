//
//  JourneyMapView.swift
//  HanziPlus
//

import SwiftUI

struct JourneyMapView: View {

    let cities: [JourneyCity]
    let progress: JourneyProgress
    let journeyStore: JourneyStore

    @State private var lockedCity: JourneyCity?
    @State private var airplaneProgress: CGFloat = 0
    @State private var animatePlane = false

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            Label("Your Route Across China", systemImage: "point.topleft.down.curvedto.point.bottomright.up")
                .font(.headline.weight(.bold))
                .padding(.horizontal, 4)

            ZStack {
                chinaMapBackdrop

                VStack(spacing: 0) {
                    ForEach(Array(cities.enumerated()), id: \.element.id) { index, city in
                        cityRow(city: city, index: index)

                        if index < cities.count - 1 {
                            curvedConnector(
                                fromIndex: index,
                                fromCity: city,
                                toCity: cities[index + 1]
                            )
                        }
                    }
                }
                .padding(.vertical, AppSpacing.medium)
                .padding(.horizontal, AppSpacing.small)
            }
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: AppRadius.studyCard, style: .continuous)
                    .strokeBorder(Color.primary.opacity(0.06), lineWidth: 0.5)
            }
            .studyCardShadow()
        }
        .sheet(item: $lockedCity) { city in
            CityLockedSheet(city: city, progress: progress)
        }
        .navigationDestination(for: String.self) { cityID in
            if let city = cities.first(where: { $0.id == cityID }) {
                CityDetailView(city: city, progress: progress)
            }
        }
        .onAppear { playAirplaneIfNeeded() }
        .onChange(of: completedCount) { _, _ in playAirplaneIfNeeded() }
    }

    private var completedCount: Int {
        cities.filter { journeyStore.isCompleted($0) }.count
    }

    @ViewBuilder
    private func cityRow(city: JourneyCity, index: Int) -> some View {
        let unlocked = journeyStore.isUnlocked(city, progress: progress)
        let alignment: HorizontalAlignment = index.isMultiple(of: 2) ? .leading : .trailing

        HStack {
            if alignment == .trailing { Spacer(minLength: 40) }

            Group {
                if unlocked {
                    NavigationLink(value: city.id) {
                        JourneyCityNode(
                            city: city,
                            progress: progress,
                            journeyStore: journeyStore,
                            isLocked: false
                        )
                    }
                    .buttonStyle(.plain)
                } else {
                    Button {
                        HapticService.light()
                        lockedCity = city
                    } label: {
                        JourneyCityNode(
                            city: city,
                            progress: progress,
                            journeyStore: journeyStore,
                            isLocked: true
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(maxWidth: 280)

            if alignment == .leading { Spacer(minLength: 40) }
        }
        .padding(.horizontal, AppSpacing.small)
    }

    private func curvedConnector(fromIndex: Int, fromCity: JourneyCity, toCity: JourneyCity) -> some View {
        let lit = journeyStore.isCompleted(fromCity)
        let goesRight = fromIndex.isMultiple(of: 2)

        return ZStack {
            CurvedRoutePath(goesRight: goesRight)
                .stroke(
                    lit ? fromCity.theme.primary.opacity(0.55) : Color.primary.opacity(0.08),
                    style: StrokeStyle(lineWidth: lit ? 4 : 2.5, lineCap: .round)
                )
                .frame(height: 56)
                .shadow(color: lit ? fromCity.theme.primary.opacity(0.25) : .clear, radius: 8)
                .animation(.spring(response: 0.5, dampingFraction: 0.82), value: lit)

            if lit && animatePlane && fromIndex == max(0, completedCount - 2) {
                Image(systemName: "airplane")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(fromCity.theme.primary)
                    .rotationEffect(.degrees(goesRight ? 35 : -35))
                    .offset(x: goesRight ? airplaneProgress * 80 - 40 : 40 - airplaneProgress * 80, y: -4)
            } else if lit {
                Image(systemName: "arrow.down")
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(fromCity.theme.primary.opacity(0.7))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 2)
    }

    private var chinaMapBackdrop: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.08, green: 0.22, blue: 0.38).opacity(0.06),
                    Color(red: 0.15, green: 0.45, blue: 0.35).opacity(0.05),
                    Color(.secondarySystemGroupedBackground)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Image(systemName: "map.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.blue.opacity(0.06), Color.green.opacity(0.05)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .padding(40)
                .opacity(0.35)
        }
    }

    private func playAirplaneIfNeeded() {
        guard completedCount > 1 else { return }
        airplaneProgress = 0
        animatePlane = true
        withAnimation(.easeInOut(duration: 1.4)) {
            airplaneProgress = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            animatePlane = false
        }
    }
}

private struct CurvedRoutePath: Shape {
    let goesRight: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let start = goesRight ? CGPoint(x: rect.width * 0.25, y: 0) : CGPoint(x: rect.width * 0.75, y: 0)
        let end = goesRight ? CGPoint(x: rect.width * 0.75, y: rect.height) : CGPoint(x: rect.width * 0.25, y: rect.height)
        let control = CGPoint(x: rect.midX, y: rect.midY)

        path.move(to: start)
        path.addQuadCurve(to: end, control: control)
        return path
    }
}

private struct JourneyCityNode: View {
    let city: JourneyCity
    let progress: JourneyProgress
    let journeyStore: JourneyStore
    let isLocked: Bool

    @State private var pulse = false

    private var isCompleted: Bool { journeyStore.isCompleted(city) }
    private var fraction: Double { journeyStore.progressFraction(for: city, progress: progress) }

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(
                        isLocked
                            ? Color(.tertiarySystemFill)
                            : city.theme.primary.opacity(pulse ? 0.22 : 0.14)
                    )
                    .frame(width: 72, height: 72)
                    .scaleEffect(pulse && !isLocked ? 1.06 : 1)

                Circle()
                    .strokeBorder(
                        isLocked ? Color.primary.opacity(0.1) : city.theme.primary.opacity(0.45),
                        style: isLocked ? StrokeStyle(lineWidth: 2, dash: [5, 4]) : StrokeStyle(lineWidth: 3)
                    )
                    .frame(width: 72, height: 72)

                Text(city.emoji)
                    .font(.system(size: 32))
                    .grayscale(isLocked ? 1 : 0)
                    .opacity(isLocked ? 0.35 : 1)
                    .scaleEffect(isLocked ? 0.9 : 1)

                if isLocked {
                    Image(systemName: "lock.fill")
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(.secondary)
                        .padding(6)
                        .background(Circle().fill(Color(.systemBackground)))
                        .offset(x: 26, y: -26)
                }

                if isCompleted && !isLocked {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(city.theme.primary)
                        .padding(5)
                        .background(Circle().fill(Color(.systemBackground)))
                        .offset(x: 26, y: 26)
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(city.name)
                    .font(.headline.weight(.bold))
                    .foregroundStyle(isLocked ? .secondary : .primary)

                if isLocked {
                    Text("Destination locked")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                } else {
                    AnimatedProgressBar(progress: fraction, tint: city.theme.primary, height: 5)
                    Text(isCompleted ? "Chapter complete" : "\(Int(fraction * 100))% explored")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer(minLength: 0)
        }
        .padding(14)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay {
                    if !isLocked {
                        RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                            .strokeBorder(city.theme.primary.opacity(0.15), lineWidth: 1)
                    }
                }
        }
        .opacity(isLocked ? 0.75 : 1)
        .onAppear {
            guard !isLocked else { return }
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                pulse = true
            }
        }
    }
}
