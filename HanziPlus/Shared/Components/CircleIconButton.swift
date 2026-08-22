//
//  CircleIconButton.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//
import SwiftUI

struct CircleIconButton: View {

    let systemImage: String
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            Image(systemName: systemImage)
                .font(.title3.weight(.semibold))
                .frame(width: 56, height: 56)
                .background(.ultraThinMaterial)
                .clipShape(Circle())

        }
        .buttonStyle(.plain)

    }

}

#Preview {

    CircleIconButton(systemImage: "speaker.wave.2.fill") {

    }

}
