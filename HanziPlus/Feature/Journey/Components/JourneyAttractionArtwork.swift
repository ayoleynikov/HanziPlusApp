//
//  JourneyAttractionArtwork.swift
//  HanziPlus
//

import SwiftUI

/// Hand-drawn style illustrations built from SwiftUI shapes — no photos, fully original.
struct JourneyAttractionArtwork: View {
    let style: JourneyAttractionVisualStyle
    let tint: Color
    var height: CGFloat = 140
    var cornerRadius: CGFloat = 20

    private static let marketLanternColors: [Color] = [.red, .yellow, .orange, .pink, .cyan]
    private static let caveColors: [Color] = [.cyan, .purple, .pink, .yellow]
    private static let neonColors: [Color] = [.pink, .cyan, .yellow, .orange]
    private static let creamBuilding = Color(red: 0.96, green: 0.93, blue: 0.86)

    private func artAccentColor(index: Int) -> Color {
        switch index {
        case 0: tint
        case 1: .orange
        default: .purple
        }
    }

    private func museumBlockColor(index: Int) -> Color {
        switch index {
        case 0: tint
        case 1: .orange
        default: .mint
        }
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [tint.opacity(0.55), tint.opacity(0.18), tint.opacity(0.32)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            scene
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))

            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.18)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            // Paper texture lines
            Canvas { context, size in
                for i in stride(from: 0, to: Int(size.height), by: 14) {
                    var path = Path()
                    path.move(to: CGPoint(x: 0, y: CGFloat(i)))
                    path.addLine(to: CGPoint(x: size.width, y: CGFloat(i) + 6))
                    context.stroke(path, with: .color(.white.opacity(0.04)), lineWidth: 1)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
        .frame(height: height)
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(.white.opacity(0.14), lineWidth: 0.5)
        }
    }

    @ViewBuilder
    private var scene: some View {
        switch style {
        case .imperialPalace: imperialPalaceScene
        case .greatWall: greatWallScene
        case .sacredTemple, .shrine, .forestTemple: templeScene
        case .localCuisine: cuisineScene
        case .artDistrict, .creativeDistrict, .artVillage: artDistrictScene
        case .terracottaArmy: terracottaScene
        case .ancientFortress: fortressScene
        case .nightMarket: nightMarketScene
        case .pagoda: pagodaScene
        case .wildlifePark: pandaScene
        case .ancientStreet, .canalTown: streetScene
        case .riversidePavilion: pavilionScene
        case .forestPark, .mountainView: forestScene
        case .ancientTown: ancientTownScene
        case .karstRiver: karstScene
        case .countrysideTown: countrysideScene
        case .limestoneCave: caveScene
        case .riceTerraces: terraceScene
        case .colonialWaterfront: bundScene
        case .modernTower, .modernCBD: skylineScene
        case .classicalGarden: gardenScene
        case .shoppingAvenue: shoppingScene
        case .scenicLake, .modernLakefront: lakeScene
        case .teaHills: teaScene
        case .heritageMuseum: museumScene
        case .iceSculpture: iceScene
        case .europeanStreet: europeanStreetScene
        case .cathedral: cathedralScene
        case .waterfrontPromenade: promenadeScene
        case .harborPeak: harborScene
        case .historicFerry: ferryScene
        case .modernArchitecture: operaHouseScene
        case .artMuseum: museumModernScene
        case .modernRetail, .nightLightsDistrict: neonScene
        }
    }

    // MARK: - Scenes

    private var imperialPalaceScene: some View {
        ZStack {
            sunCircle(color: .yellow.opacity(0.85), x: 0.78, y: 0.18)
            ForEach(0..<3, id: \.self) { i in
                roofShape(color: .red.opacity(0.9))
                    .frame(width: height * 0.35, height: height * 0.18)
                    .offset(x: CGFloat(i - 1) * height * 0.22, y: height * 0.08)
            }
            wallRow(count: 5, color: .red.opacity(0.75))
                .offset(y: height * 0.22)
            groundBand(color: tint.opacity(0.35))
        }
    }

    private var greatWallScene: some View {
        ZStack {
            mountainSilhouette(color: tint.opacity(0.45))
            Path { path in
                let w = height * 1.6
                path.move(to: CGPoint(x: -w * 0.1, y: height * 0.55))
                path.addQuadCurve(
                    to: CGPoint(x: w * 0.9, y: height * 0.35),
                    control: CGPoint(x: w * 0.4, y: height * 0.2)
                )
            }
            .stroke(.brown.opacity(0.85), style: StrokeStyle(lineWidth: height * 0.06, lineCap: .round))
            ForEach(0..<8, id: \.self) { i in
                RoundedRectangle(cornerRadius: 2)
                    .fill(.brown.opacity(0.75))
                    .frame(width: height * 0.05, height: height * 0.1)
                    .offset(x: CGFloat(i) * height * 0.14 - height * 0.45, y: height * 0.12)
            }
            sunCircle(color: .orange.opacity(0.8), x: 0.15, y: 0.2)
        }
    }

    private var templeScene: some View {
        ZStack {
            Circle().fill(tint.opacity(0.25)).frame(width: height * 0.7).offset(y: height * 0.2)
            roofShape(color: tint.opacity(0.9))
                .frame(width: height * 0.55, height: height * 0.22)
                .offset(y: -height * 0.05)
            RoundedRectangle(cornerRadius: 4)
                .fill(tint.opacity(0.7))
                .frame(width: height * 0.28, height: height * 0.22)
                .offset(y: height * 0.12)
            ForEach(0..<2, id: \.self) { i in
                treeShape(color: tint.opacity(0.55))
                    .offset(x: i == 0 ? -height * 0.38 : height * 0.38, y: height * 0.18)
            }
        }
    }

    private var cuisineScene: some View {
        ZStack {
            steamWisps
            ForEach(0..<3, id: \.self) { i in
                basketShape
                    .offset(x: CGFloat(i - 1) * height * 0.22, y: height * 0.1)
            }
            Ellipse()
                .fill(tint.opacity(0.25))
                .frame(width: height * 0.9, height: height * 0.2)
                .offset(y: height * 0.28)
        }
    }

    private var artDistrictScene: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { i in
                artFrame(index: i)
            }
            brushStroke.offset(y: height * 0.25)
        }
    }

    private func artFrame(index: Int) -> some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(.white.opacity(0.85))
            .frame(width: height * 0.22, height: height * 0.28)
            .overlay {
                Circle()
                    .fill(artAccentColor(index: index).opacity(0.7))
                    .frame(width: height * 0.12)
            }
            .rotationEffect(.degrees(Double(index - 1) * 8))
            .offset(x: CGFloat(index - 1) * height * 0.24, y: CGFloat(index) * 4)
    }

    private var terracottaScene: some View {
        ZStack {
            ForEach(0..<4, id: \.self) { i in
                warriorSilhouette
                    .offset(x: CGFloat(i - 1) * height * 0.2 - height * 0.1, y: height * 0.08)
                    .opacity(0.75 + Double(i) * 0.05)
            }
            groundBand(color: .brown.opacity(0.35))
        }
    }

    private var fortressScene: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 2)
                .fill(tint.opacity(0.55))
                .frame(width: height * 1.1, height: height * 0.35)
                .offset(y: height * 0.12)
            ForEach(0..<6, id: \.self) { i in
                RoundedRectangle(cornerRadius: 1)
                    .fill(tint.opacity(0.75))
                    .frame(width: height * 0.08, height: height * 0.14)
                    .offset(x: CGFloat(i) * height * 0.16 - height * 0.4, y: -height * 0.08)
            }
            Circle()
                .strokeBorder(.white.opacity(0.5), lineWidth: 2)
                .frame(width: height * 0.18)
                .offset(x: height * 0.32, y: height * 0.18)
        }
    }

    private var nightMarketScene: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [.indigo.opacity(0.7), .purple.opacity(0.4)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            ForEach(0..<5, id: \.self) { i in
                marketLantern(index: i)
            }
            stallRow
        }
    }

    private var pagodaScene: some View {
        ZStack {
            ForEach(0..<5, id: \.self) { i in
                roofShape(color: tint.opacity(0.85 - Double(i) * 0.08))
                    .frame(width: height * (0.42 - CGFloat(i) * 0.05), height: height * 0.08)
                    .offset(y: CGFloat(i) * height * 0.09 - height * 0.18)
            }
            mistBand
        }
    }

    private var pandaScene: some View {
        ZStack {
            ForEach(0..<4, id: \.self) { i in
                bambooStalk
                    .offset(x: CGFloat(i) * height * 0.14 - height * 0.22, y: -height * 0.05)
            }
            ZStack {
                Circle().fill(.white).frame(width: height * 0.28)
                Circle().fill(.black).frame(width: height * 0.07).offset(x: -height * 0.05, y: -height * 0.02)
                Circle().fill(.black).frame(width: height * 0.07).offset(x: height * 0.05, y: -height * 0.02)
                Circle().fill(.black).frame(width: height * 0.09).offset(x: -height * 0.1, y: -height * 0.1)
                Circle().fill(.black).frame(width: height * 0.09).offset(x: height * 0.1, y: -height * 0.1)
            }
            .offset(y: height * 0.12)
        }
    }

    private var streetScene: some View {
        ZStack {
            ForEach(0..<4, id: \.self) { i in
                RoundedRectangle(cornerRadius: 3)
                    .fill(tint.opacity(0.5 + Double(i) * 0.05))
                    .frame(width: height * 0.16, height: height * 0.22)
                    .offset(x: CGFloat(i) * height * 0.2 - height * 0.3, y: height * 0.02)
            }
            lanternRow
            groundBand(color: tint.opacity(0.25))
        }
    }

    private var pavilionScene: some View {
        ZStack {
            waterReflection
            roofShape(color: tint)
                .frame(width: height * 0.5, height: height * 0.2)
                .offset(y: -height * 0.02)
            RoundedRectangle(cornerRadius: 3)
                .fill(tint.opacity(0.65))
                .frame(width: height * 0.12, height: height * 0.28)
                .offset(y: height * 0.12)
        }
    }

    private var forestScene: some View {
        ZStack {
            ForEach(0..<5, id: \.self) { i in
                treeShape(color: tint.opacity(0.45 + Double(i) * 0.08))
                    .scaleEffect(0.7 + CGFloat(i) * 0.08)
                    .offset(x: CGFloat(i) * height * 0.18 - height * 0.36, y: height * 0.1)
            }
            mountainSilhouette(color: tint.opacity(0.3))
                .offset(y: -height * 0.15)
        }
    }

    private var ancientTownScene: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { i in
                RoundedRectangle(cornerRadius: 2)
                    .fill(.gray.opacity(0.55))
                    .frame(width: height * 0.2, height: height * 0.18)
                    .offset(x: CGFloat(i - 1) * height * 0.22, y: height * 0.08)
            }
            Path { path in
                path.move(to: CGPoint(x: 0, y: height * 0.35))
                path.addLine(to: CGPoint(x: height * 1.4, y: height * 0.35))
            }
            .stroke(.brown.opacity(0.5), lineWidth: height * 0.04)
        }
    }

    private var karstScene: some View {
        ZStack {
            ForEach(0..<4, id: \.self) { i in
                karstPeak(color: tint.opacity(0.5 + Double(i) * 0.1))
                    .offset(x: CGFloat(i) * height * 0.2 - height * 0.3, y: height * 0.05)
            }
            raftShape
                .offset(y: height * 0.28)
            mistBand
        }
    }

    private var countrysideScene: some View {
        ZStack {
            karstPeak(color: tint.opacity(0.4))
                .scaleEffect(0.8)
                .offset(x: -height * 0.25, y: -height * 0.05)
            karstPeak(color: tint.opacity(0.55))
                .offset(x: height * 0.2, y: 0)
            bicycleSilhouette.offset(y: height * 0.22)
        }
    }

    private var caveScene: some View {
        ZStack {
            Ellipse()
                .fill(.black.opacity(0.55))
                .frame(width: height * 0.85, height: height * 0.55)
            ForEach(0..<4, id: \.self) { i in
                caveStalactite(index: i)
            }
        }
    }

    private var terraceScene: some View {
        ZStack {
            ForEach(0..<5, id: \.self) { i in
                terraceLayer(color: tint.opacity(0.35 + Double(i) * 0.1))
                    .offset(y: CGFloat(i) * height * 0.08 - height * 0.12)
            }
        }
    }

    private var bundScene: some View {
        ZStack {
            ForEach(0..<4, id: \.self) { i in
                RoundedRectangle(cornerRadius: 2)
                    .fill(.brown.opacity(0.45))
                    .frame(width: height * 0.12, height: height * 0.2 + CGFloat(i) * 6)
                    .offset(x: CGFloat(i) * height * 0.16 - height * 0.24, y: height * 0.05)
            }
            ForEach(0..<3, id: \.self) { i in
                RoundedRectangle(cornerRadius: 3)
                    .fill(tint.opacity(0.65))
                    .frame(width: height * 0.1, height: height * 0.35 + CGFloat(i) * 12)
                    .offset(x: height * 0.2 + CGFloat(i) * height * 0.12, y: -height * 0.02)
            }
            waterReflection.offset(y: height * 0.28)
        }
    }

    private var skylineScene: some View {
        ZStack {
            ForEach(0..<6, id: \.self) { i in
                RoundedRectangle(cornerRadius: 3)
                    .fill(
                        LinearGradient(
                            colors: [tint.opacity(0.85), tint.opacity(0.45)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(
                        width: height * 0.1,
                        height: height * (0.22 + CGFloat([0.35, 0.5, 0.4, 0.55, 0.3, 0.45][i]))
                    )
                    .offset(x: CGFloat(i) * height * 0.16 - height * 0.4, y: height * 0.12)
            }
            sunCircle(color: .orange.opacity(0.75), x: 0.82, y: 0.15)
        }
    }

    private var gardenScene: some View {
        ZStack {
            Circle().fill(tint.opacity(0.2)).frame(width: height * 0.45).offset(x: height * 0.2, y: height * 0.15)
            bridgeShape.offset(y: height * 0.18)
            pavilionScene.scaleEffect(0.75).offset(x: -height * 0.15, y: -height * 0.05)
            ForEach(0..<3, id: \.self) { i in
                treeShape(color: tint.opacity(0.5))
                    .scaleEffect(0.6)
                    .offset(x: CGFloat(i) * height * 0.25 - height * 0.25, y: height * 0.2)
            }
        }
    }

    private var shoppingScene: some View {
        ZStack {
            neonScene
            ForEach(0..<3, id: \.self) { i in
                bagShape
                    .offset(x: CGFloat(i) * height * 0.22 - height * 0.22, y: height * 0.15)
            }
        }
    }

    private var lakeScene: some View {
        ZStack {
            mistBand.offset(y: -height * 0.2)
            ForEach(0..<3, id: \.self) { i in
                willowTree
                    .offset(x: CGFloat(i) * height * 0.28 - height * 0.28, y: -height * 0.05)
            }
            waterReflection.offset(y: height * 0.15)
            bridgeShape.scaleEffect(0.7).offset(y: height * 0.1)
        }
    }

    private var teaScene: some View {
        ZStack {
            ForEach(0..<4, id: \.self) { i in
                terraceLayer(color: .green.opacity(0.35 + Double(i) * 0.08))
                    .scaleEffect(1.1)
                    .offset(x: CGFloat(i) * 8 - 12, y: CGFloat(i) * height * 0.07 - height * 0.1)
            }
            teapotShape.offset(x: height * 0.25, y: height * 0.15)
        }
    }

    private var museumScene: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(tint.opacity(0.55))
                .frame(width: height * 0.7, height: height * 0.35)
            RoundedRectangle(cornerRadius: 4)
                .fill(.white.opacity(0.85))
                .frame(width: height * 0.18, height: height * 0.22)
                .overlay {
                    Text(verbatim: "丝")
                        .font(.system(size: height * 0.12, weight: .bold))
                        .foregroundStyle(tint)
                }
        }
    }

    private var iceScene: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [.cyan.opacity(0.5), .blue.opacity(0.35)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            iceCastle
            ForEach(0..<6, id: \.self) { i in
                Image(systemName: "snowflake")
                    .font(.system(size: height * 0.06))
                    .foregroundStyle(.white.opacity(0.7))
                    .offset(
                        x: CGFloat([-0.3, 0.1, 0.35, -0.15, 0.25, -0.35][i]) * height,
                        y: CGFloat([-0.15, 0.05, -0.05, 0.15, -0.2, 0.1][i]) * height
                    )
            }
        }
    }

    private var europeanStreetScene: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { i in
                europeanBuilding(index: i)
            }
            treeShape(color: .green.opacity(0.55))
                .offset(x: height * 0.35, y: height * 0.15)
        }
    }

    private func europeanBuilding(index: Int) -> some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(Self.creamBuilding.opacity(0.85))
            .frame(width: height * 0.18, height: height * 0.28)
            .overlay {
                RoundedRectangle(cornerRadius: 1)
                    .fill(tint.opacity(0.35))
                    .frame(width: height * 0.06, height: height * 0.1)
                    .offset(y: height * 0.02)
            }
            .offset(x: CGFloat(index) * height * 0.22 - height * 0.22, y: height * 0.05)
    }

    private var cathedralScene: some View {
        ZStack {
            domeBuilding
            snowDust
        }
    }

    private var promenadeScene: some View {
        ZStack {
            skylineScene.scaleEffect(0.85).offset(y: -height * 0.08)
            Path { path in
                path.move(to: CGPoint(x: 0, y: height * 0.42))
                path.addQuadCurve(
                    to: CGPoint(x: height * 1.2, y: height * 0.38),
                    control: CGPoint(x: height * 0.5, y: height * 0.48)
                )
            }
            .stroke(tint.opacity(0.45), lineWidth: height * 0.05)
        }
    }

    private var harborScene: some View {
        ZStack {
            skylineScene.scaleEffect(0.7).offset(y: height * 0.08)
            mountainSilhouette(color: .green.opacity(0.45))
                .scaleEffect(0.8)
                .offset(x: -height * 0.2, y: -height * 0.1)
            waterReflection.offset(y: height * 0.22)
        }
    }

    private var ferryScene: some View {
        ZStack {
            harborScene
            ferryBoat.offset(y: height * 0.2)
        }
    }

    private var operaHouseScene: some View {
        ZStack {
            waterReflection.offset(y: height * 0.25)
            curvedShellBuilding
            sunCircle(color: .pink.opacity(0.7), x: 0.8, y: 0.18)
        }
    }

    private var museumModernScene: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white.opacity(0.9))
                .frame(width: height * 0.75, height: height * 0.32)
                .overlay(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(tint.opacity(0.75))
                        .frame(width: height * 0.22, height: height * 0.32)
                }
            ForEach(0..<3, id: \.self) { i in
                museumBlock(index: i)
            }
        }
    }

    private var neonScene: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [.purple.opacity(0.45), tint.opacity(0.35)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            ForEach(0..<4, id: \.self) { i in
                neonBuilding(index: i)
            }
        }
    }

    // MARK: - Indexed scene parts

    private func marketLantern(index: Int) -> some View {
        Capsule()
            .fill(Self.marketLanternColors[index].opacity(0.9))
            .frame(width: height * 0.06, height: height * 0.14)
            .offset(x: CGFloat(index) * height * 0.16 - height * 0.32, y: -height * 0.22)
    }

    private func caveStalactite(index: Int) -> some View {
        stalactite(color: Self.caveColors[index].opacity(0.8))
            .offset(x: CGFloat(index) * height * 0.16 - height * 0.24, y: -height * 0.05)
    }

    private func museumBlock(index: Int) -> some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(museumBlockColor(index: index).opacity(0.8))
            .frame(width: height * 0.14, height: height * 0.1)
            .offset(x: CGFloat(index) * height * 0.16 - height * 0.1, y: height * 0.2)
    }

    private func neonBuilding(index: Int) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Self.neonColors[index].opacity(0.85))
            .frame(width: height * 0.14, height: height * 0.2)
            .offset(x: CGFloat(index) * height * 0.18 - height * 0.27, y: height * 0.05)
    }

    // MARK: - Shape building blocks

    private func sunCircle(color: Color, x: CGFloat, y: CGFloat) -> some View {
        Circle()
            .fill(color)
            .frame(width: height * 0.16, height: height * 0.16)
            .offset(x: height * x - height * 0.5, y: height * y - height * 0.5)
    }

    private func roofShape(color: Color) -> some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: 0, y: 30))
                path.addLine(to: CGPoint(x: 50, y: 0))
                path.addLine(to: CGPoint(x: 100, y: 30))
                path.closeSubpath()
            }
            .fill(color)
            Capsule()
                .fill(color.opacity(0.85))
                .frame(height: 8)
                .offset(y: 14)
        }
    }

    private func wallRow(count: Int, color: Color) -> some View {
        HStack(spacing: 4) {
            ForEach(0..<count, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 2)
                    .fill(color)
                    .frame(width: height * 0.12, height: height * 0.14)
            }
        }
    }

    private func groundBand(color: Color) -> some View {
        Ellipse()
            .fill(color)
            .frame(width: height * 1.1, height: height * 0.18)
            .offset(y: height * 0.32)
    }

    private func mountainSilhouette(color: Color) -> some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 80))
            path.addLine(to: CGPoint(x: 60, y: 20))
            path.addLine(to: CGPoint(x: 120, y: 55))
            path.addLine(to: CGPoint(x: 180, y: 10))
            path.addLine(to: CGPoint(x: 240, y: 80))
            path.closeSubpath()
        }
        .fill(color)
        .frame(width: height * 1.2, height: height * 0.5)
    }

    private func karstPeak(color: Color) -> some View {
        Path { path in
            path.move(to: CGPoint(x: 20, y: 80))
            path.addQuadCurve(to: CGPoint(x: 50, y: 5), control: CGPoint(x: 25, y: 30))
            path.addQuadCurve(to: CGPoint(x: 80, y: 80), control: CGPoint(x: 75, y: 30))
            path.closeSubpath()
        }
        .fill(color)
        .frame(width: height * 0.28, height: height * 0.45)
    }

    private func treeShape(color: Color) -> some View {
        VStack(spacing: 0) {
            Circle().fill(color).frame(width: height * 0.16, height: height * 0.16)
            RoundedRectangle(cornerRadius: 1)
                .fill(.brown.opacity(0.6))
                .frame(width: height * 0.03, height: height * 0.1)
        }
    }

    private func terraceLayer(color: Color) -> some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 20))
            path.addLine(to: CGPoint(x: 140, y: 20))
            path.addLine(to: CGPoint(x: 120, y: 35))
            path.addLine(to: CGPoint(x: 20, y: 35))
            path.closeSubpath()
        }
        .fill(color)
        .frame(width: height * 0.9, height: height * 0.2)
    }

    private var mistBand: some View {
        Capsule()
            .fill(.white.opacity(0.25))
            .frame(width: height * 1.1, height: height * 0.12)
            .offset(y: height * 0.15)
    }

    private var waterReflection: some View {
        Ellipse()
            .fill(
                LinearGradient(
                    colors: [tint.opacity(0.45), tint.opacity(0.15)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: height * 1.0, height: height * 0.22)
    }

    private var basketShape: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(.brown.opacity(0.65))
                .frame(width: height * 0.22, height: height * 0.14)
            Circle()
                .fill(.orange.opacity(0.85))
                .frame(width: height * 0.1)
                .offset(y: -height * 0.04)
        }
    }

    private var steamWisps: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { i in
                Capsule()
                    .fill(.white.opacity(0.35))
                    .frame(width: height * 0.04, height: height * 0.12)
                    .offset(x: CGFloat(i) * height * 0.08 - height * 0.08, y: -height * 0.18)
            }
        }
    }

    private var brushStroke: some View {
        Capsule()
            .fill(tint.opacity(0.65))
            .frame(width: height * 0.5, height: height * 0.05)
            .rotationEffect(.degrees(-12))
    }

    private var warriorSilhouette: some View {
        VStack(spacing: 2) {
            Circle().fill(.brown.opacity(0.75)).frame(width: height * 0.08)
            RoundedRectangle(cornerRadius: 3)
                .fill(.brown.opacity(0.7))
                .frame(width: height * 0.12, height: height * 0.18)
        }
    }

    private var stallRow: some View {
        HStack(spacing: height * 0.08) {
            ForEach(0..<3, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 3)
                    .fill(.orange.opacity(0.75))
                    .frame(width: height * 0.18, height: height * 0.12)
            }
        }
        .offset(y: height * 0.2)
    }

    private var lanternRow: some View {
        HStack(spacing: height * 0.1) {
            ForEach(0..<3, id: \.self) { _ in
                Circle()
                    .fill(.red.opacity(0.85))
                    .frame(width: height * 0.07)
            }
        }
        .offset(y: -height * 0.15)
    }

    private var bambooStalk: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(.green.opacity(0.65))
            .frame(width: height * 0.04, height: height * 0.45)
    }

    private var raftShape: some View {
        ZStack {
            Capsule()
                .fill(.brown.opacity(0.65))
                .frame(width: height * 0.35, height: height * 0.08)
            Circle()
                .fill(.orange.opacity(0.8))
                .frame(width: height * 0.06)
                .offset(x: -height * 0.04, y: -height * 0.06)
        }
    }

    private func stalactite(color: Color) -> some View {
        Triangle()
            .fill(color)
            .frame(width: height * 0.08, height: height * 0.2)
    }

    private var bridgeShape: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 30))
            path.addQuadCurve(to: CGPoint(x: 100, y: 30), control: CGPoint(x: 50, y: 0))
        }
        .stroke(.brown.opacity(0.65), lineWidth: 4)
        .frame(width: height * 0.5, height: height * 0.2)
    }

    private var willowTree: some View {
        VStack(spacing: 0) {
            ForEach(0..<4, id: \.self) { i in
                Capsule()
                    .fill(.green.opacity(0.45))
                    .frame(width: height * 0.03, height: height * 0.14)
                    .offset(x: CGFloat(i - 1) * 6)
            }
            RoundedRectangle(cornerRadius: 1)
                .fill(.brown.opacity(0.55))
                .frame(width: height * 0.03, height: height * 0.12)
        }
    }

    private var teapotShape: some View {
        ZStack {
            Circle().fill(.green.opacity(0.7)).frame(width: height * 0.14)
            RoundedRectangle(cornerRadius: 2)
                .fill(.green.opacity(0.55))
                .frame(width: height * 0.06, height: height * 0.05)
                .offset(x: height * 0.1)
        }
    }

    private var iceCastle: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: 30, y: 70))
                path.addLine(to: CGPoint(x: 50, y: 20))
                path.addLine(to: CGPoint(x: 70, y: 70))
                path.closeSubpath()
            }
            .fill(.cyan.opacity(0.75))
            .frame(width: height * 0.35, height: height * 0.35)
            .offset(x: -height * 0.1)
            Path { path in
                path.move(to: CGPoint(x: 20, y: 70))
                path.addLine(to: CGPoint(x: 45, y: 10))
                path.addLine(to: CGPoint(x: 70, y: 70))
                path.closeSubpath()
            }
            .fill(.white.opacity(0.8))
            .frame(width: height * 0.3, height: height * 0.38)
            .offset(x: height * 0.12, y: -height * 0.02)
        }
    }

    private var domeBuilding: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 2)
                .fill(Self.creamBuilding.opacity(0.85))
                .frame(width: height * 0.35, height: height * 0.28)
            Ellipse()
                .fill(.green.opacity(0.55))
                .frame(width: height * 0.22, height: height * 0.14)
                .offset(y: -height * 0.16)
        }
    }

    private var snowDust: some View {
        HStack(spacing: height * 0.2) {
            ForEach(0..<3, id: \.self) { _ in
                Image(systemName: "snowflake")
                    .foregroundStyle(.white.opacity(0.6))
            }
        }
        .offset(y: -height * 0.25)
    }

    private var ferryBoat: some View {
        ZStack {
            Capsule()
                .fill(.green.opacity(0.75))
                .frame(width: height * 0.35, height: height * 0.12)
            RoundedRectangle(cornerRadius: 2)
                .fill(.white.opacity(0.85))
                .frame(width: height * 0.2, height: height * 0.08)
                .offset(y: -height * 0.05)
        }
    }

    private var curvedShellBuilding: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { i in
                Capsule()
                    .fill(.white.opacity(0.88 - Double(i) * 0.08))
                    .frame(width: height * (0.45 - CGFloat(i) * 0.06), height: height * 0.2)
                    .rotationEffect(.degrees(Double(i - 1) * 18))
                    .offset(x: CGFloat(i - 1) * height * 0.08, y: -height * 0.02)
            }
        }
    }

    private var bagShape: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(tint.opacity(0.7))
            .frame(width: height * 0.12, height: height * 0.14)
    }

    private var bicycleSilhouette: some View {
        ZStack {
            Circle().strokeBorder(.white.opacity(0.7), lineWidth: 2).frame(width: height * 0.12)
                .offset(x: -height * 0.08)
            Circle().strokeBorder(.white.opacity(0.7), lineWidth: 2).frame(width: height * 0.12)
                .offset(x: height * 0.08)
            Capsule().fill(.white.opacity(0.7)).frame(width: height * 0.18, height: 3)
        }
    }
}

private struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    ScrollView {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(
                [
                    JourneyAttractionVisualStyle.imperialPalace,
                    .greatWall, .karstRiver, .modernTower, .artMuseum, .wildlifePark
                ],
                id: \.self
            ) { style in
                JourneyAttractionArtwork(style: style, tint: .blue, height: 120)
            }
        }
        .padding()
    }
}
