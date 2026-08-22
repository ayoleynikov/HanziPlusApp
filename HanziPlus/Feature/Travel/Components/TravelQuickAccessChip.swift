//
//  TravelQuickAccessChip.swift
//  HanziPlus
//

import SwiftUI

enum TravelQuickAccessDestination: Hashable {
    case category(String)
    case phrase(String)
}

struct TravelQuickAccessItem: Identifiable {
    let id: String
    let title: String
    let icon: String
    let accentName: String
    let destination: TravelQuickAccessDestination

    var route: TravelToolkitRoute {
        switch destination {
        case .category(let id): .category(id)
        case .phrase(let id): .phrase(id)
        }
    }
}

enum TravelQuickAccess {
    static let items: [TravelQuickAccessItem] = [
        TravelQuickAccessItem(
            id: "emergency",
            title: "Emergency",
            icon: "cross.case.fill",
            accentName: "red",
            destination: .category("emergency")
        ),
        TravelQuickAccessItem(
            id: "taxi",
            title: "Taxi Address",
            icon: "car.fill",
            accentName: "indigo",
            destination: .phrase("tr-taxi-address")
        ),
        TravelQuickAccessItem(
            id: "food",
            title: "Food & Allergies",
            icon: "fork.knife",
            accentName: "pink",
            destination: .phrase("food-allergy")
        ),
        TravelQuickAccessItem(
            id: "pay",
            title: "Payments",
            icon: "creditcard.fill",
            accentName: "teal",
            destination: .category("shopping")
        ),
        TravelQuickAccessItem(
            id: "hotel",
            title: "Hotel",
            icon: "bed.double.fill",
            accentName: "purple",
            destination: .category("hotel")
        ),
        TravelQuickAccessItem(
            id: "metro",
            title: "Metro & Train",
            icon: "tram.fill",
            accentName: "blue",
            destination: .category("transport")
        )
    ]
}

struct TravelQuickAccessChip: View {
    let item: TravelQuickAccessItem

    private var tint: Color { TravelAccent.color(named: item.accentName) }

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(tint.opacity(item.id == "emergency" ? 0.18 : 0.12))
                    .frame(width: 44, height: 44)

                Image(systemName: item.icon)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(tint)
            }

            Text(item.title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.85)
        }
        .frame(width: 88)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(item.title)
        .accessibilityAddTraits(.isButton)
    }
}
