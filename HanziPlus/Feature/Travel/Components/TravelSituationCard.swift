//
//  TravelSituationCard.swift
//  HanziPlus
//

import SwiftUI

struct TravelTouristWordsPanel: View {
    let categoryIDs: [String]
    var onSelect: (String) -> Void

    private let chineseRed = Color(red: 0.78, green: 0.14, blue: 0.16)
    private let chineseGold = Color(red: 0.86, green: 0.66, blue: 0.22)

    private var categories: [TravelPhraseCategory] {
        categoryIDs.compactMap { TravelPhraseCategories.category(id: $0) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 10) {
                Rectangle()
                    .fill(chineseGold.opacity(0.35))
                    .frame(height: 1)

                Text("游")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(chineseRed.opacity(0.7))

                Rectangle()
                    .fill(chineseGold.opacity(0.35))
                    .frame(height: 1)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(l10n: "travel.section.tourist_words")
                    .font(.subheadline.weight(.bold))

                Text(l10n: "travel.section.tourist_words.subtitle")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 10),
                    GridItem(.flexible(), spacing: 10)
                ],
                spacing: 10
            ) {
                ForEach(categories) { category in
                    Button {
                        onSelect(category.id)
                    } label: {
                        TravelTouristWordChip(category: category)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.horizontal, AppSpacing.small)
        .padding(.bottom, AppSpacing.small)
    }
}

struct TravelTouristWordChip: View {
    let category: TravelPhraseCategory

    private let chineseGold = Color(red: 0.86, green: 0.66, blue: 0.22)

    private var accent: Color { TravelAccent.color(named: category.accentName) }

    private var sealCharacter: String {
        TravelTouristSituations.routeSealCharacter(for: category.id)
    }

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(accent.opacity(0.12))
                    .frame(width: 44, height: 44)

                Circle()
                    .strokeBorder(accent.opacity(0.35), lineWidth: 1.5)
                    .frame(width: 44, height: 44)

                Text(sealCharacter)
                    .font(.system(size: 20, weight: .medium, design: .serif))
                    .foregroundStyle(accent)

                Image(systemName: category.icon)
                    .font(.system(size: 9, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(3)
                    .background(Circle().fill(accent))
                    .offset(x: 15, y: 15)
            }
            .frame(width: 44, height: 44)

            Text(category.title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.85)
                .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity, minHeight: 96)
        .background {
            RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                        .strokeBorder(accent.opacity(0.22), lineWidth: 1)
                }
        }
        .overlay {
            ChinesePlaqueCorners(color: accent.opacity(0.28))
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(category.title)
        .accessibilityAddTraits(.isButton)
    }
}

private struct ChinesePlaqueCorners: View {
    let color: Color
    private let length: CGFloat = 10

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            corner(at: CGPoint(x: 8, y: 8), horizontal: 1, vertical: 1)
            corner(at: CGPoint(x: w - 8, y: 8), horizontal: -1, vertical: 1)
            corner(at: CGPoint(x: 8, y: h - 8), horizontal: 1, vertical: -1)
            corner(at: CGPoint(x: w - 8, y: h - 8), horizontal: -1, vertical: -1)
        }
        .allowsHitTesting(false)
    }

    private func corner(at origin: CGPoint, horizontal: CGFloat, vertical: CGFloat) -> some View {
        Path { path in
            path.move(to: CGPoint(x: origin.x, y: origin.y + vertical * length))
            path.addLine(to: origin)
            path.addLine(to: CGPoint(x: origin.x + horizontal * length, y: origin.y))
        }
        .stroke(color, style: StrokeStyle(lineWidth: 1.5, lineCap: .round))
    }
}
