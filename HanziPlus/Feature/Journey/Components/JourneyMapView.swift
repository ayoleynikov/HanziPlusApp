//
//  JourneyMapView.swift
//  HanziPlus
//

import SwiftUI

struct JourneyMapView: View {

    let cities: [JourneyCity]
    let progress: JourneyProgress
    let journeyStore: JourneyStore
    var showsRouteTitle: Bool = true
    var onDismissPresentation: (() -> Void)? = nil

    @State private var airplaneProgress: CGFloat = 0
    @State private var animatePlane = false

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            if showsRouteTitle {
                Label(L10n.string("journey.map.route_title"), systemImage: "point.topleft.down.curvedto.point.bottomright.up")
                    .font(.headline.weight(.bold))
                    .padding(.horizontal, 4)
            }

            ZStack {
                chinaMapBackdrop

                VStack(spacing: 0) {
                    ForEach(Array(cities.enumerated()), id: \.element.id) { index, city in
                        cityRow(city: city, index: index)

                        if index < cities.count - 1 {
                            routeConnector(fromIndex: index, fromCity: city)
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
        .navigationDestination(for: String.self) { cityID in
            if let city = cities.first(where: { $0.id == cityID }) {
                CityDetailView(
                    city: city,
                    progress: progress,
                    onDismissPresentation: onDismissPresentation
                )
            }
        }
        .onAppear { playAirplaneIfNeeded() }
        .onChange(of: visitedCount) { _, _ in playAirplaneIfNeeded() }
    }

    private var visitedCount: Int {
        cities.filter { journeyStore.isCompleted($0) }.count
    }

    @ViewBuilder
    private func cityRow(city: JourneyCity, index: Int) -> some View {
        let alignment: HorizontalAlignment = index.isMultiple(of: 2) ? .leading : .trailing

        HStack {
            if alignment == .trailing { Spacer(minLength: 40) }

            NavigationLink(value: city.id) {
                JourneyCityNode(
                    city: city,
                    isVisited: journeyStore.isCompleted(city)
                )
            }
            .buttonStyle(JourneyCityNodeButtonStyle())
            .frame(maxWidth: 280)

            if alignment == .leading { Spacer(minLength: 40) }
        }
        .padding(.horizontal, AppSpacing.small)
    }

    @ViewBuilder
    private func routeConnector(fromIndex: Int, fromCity: JourneyCity) -> some View {
        let goesRight = fromIndex.isMultiple(of: 2)
        let visited = journeyStore.isCompleted(fromCity)

        curvedConnector(fromIndex: fromIndex, fromCity: fromCity, goesRight: goesRight, lit: visited)
    }

    private func curvedConnector(
        fromIndex: Int,
        fromCity: JourneyCity,
        goesRight: Bool,
        lit: Bool
    ) -> some View {
        ZStack {
            CurvedRoutePath(goesRight: goesRight)
                .stroke(
                    lit ? fromCity.theme.primary.opacity(0.45) : Color.primary.opacity(0.1),
                    style: StrokeStyle(lineWidth: lit ? 3.5 : 2.5, lineCap: .round)
                )
                .frame(height: 48)
                .shadow(color: lit ? fromCity.theme.primary.opacity(0.2) : .clear, radius: 6)

            if lit && animatePlane && fromIndex == max(0, visitedCount - 2) {
                Image(systemName: "airplane")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(fromCity.theme.primary)
                    .rotationEffect(.degrees(goesRight ? 35 : -35))
                    .offset(x: goesRight ? airplaneProgress * 80 - 40 : 40 - airplaneProgress * 80, y: -4)
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
        guard visitedCount > 1 else { return }
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

private struct JourneyCityNodeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(response: 0.28, dampingFraction: 0.72), value: configuration.isPressed)
    }
}

private struct JourneyCityNode: View {
    let city: JourneyCity
    let isVisited: Bool

    @State private var pulse = false
    @State private var rippleScale: CGFloat = 0.6
    @State private var rippleOpacity: Double = 0
    @State private var emojiScale: CGFloat = 1
    @State private var didPlayDiscovery = false

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                if rippleOpacity > 0 {
                    Circle()
                        .strokeBorder(city.theme.primary.opacity(rippleOpacity), lineWidth: 2.5)
                        .frame(width: 72, height: 72)
                        .scaleEffect(rippleScale)
                }

                Circle()
                    .fill(city.theme.primary.opacity(isVisited ? 0.2 : (pulse ? 0.22 : 0.14)))
                    .frame(width: 72, height: 72)
                    .scaleEffect(isVisited ? 1 : (pulse ? 1.05 : 1))

                Circle()
                    .strokeBorder(city.theme.primary.opacity(isVisited ? 0.65 : 0.45), lineWidth: 3)
                    .frame(width: 72, height: 72)
                    .shadow(color: isVisited ? city.theme.primary.opacity(0.25) : .clear, radius: 8)

                Text(city.emoji)
                    .font(.system(size: 32))
                    .scaleEffect(emojiScale)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(city.localizedName)
                    .font(.headline.weight(.bold))

                Text(city.localizedFamousFor)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding(14)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.large, style: .continuous)
                        .strokeBorder(city.theme.primary.opacity(0.15), lineWidth: 1)
                }
        }
        .onAppear {
            didPlayDiscovery = isVisited
            if !isVisited {
                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    pulse = true
                }
            }
        }
        .onChange(of: isVisited) { _, visited in
            guard visited, !didPlayDiscovery else { return }
            didPlayDiscovery = true
            playDiscoveryAnimation()
        }
    }

    private func playDiscoveryAnimation() {
        pulse = false
        rippleOpacity = 0.7
        rippleScale = 0.75

        withAnimation(.easeOut(duration: 0.75)) {
            rippleScale = 1.55
            rippleOpacity = 0
        }

        withAnimation(.spring(response: 0.42, dampingFraction: 0.52)) {
            emojiScale = 1.28
        }
        withAnimation(.spring(response: 0.45, dampingFraction: 0.68).delay(0.18)) {
            emojiScale = 1
        }
    }
}
