//
//  ExampleRowView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/27.
//

import SwiftUI

struct ExampleRowView: View {

    enum Style {
        case compact
        case detailed
    }

    let example: Example
    var style: Style = .detailed

    private var textAlignment: TextAlignment {
        style == .compact ? .center : .leading
    }

    private var frameAlignment: Alignment {
        style == .compact ? .center : .leading
    }

    private var stackAlignment: HorizontalAlignment {
        style == .compact ? .center : .leading
    }

    var body: some View {
        VStack(alignment: stackAlignment, spacing: style == .compact ? 6 : 4) {
            Text(example.hanzi)
                .font(style == .compact ? .body.weight(.semibold) : .body.weight(.medium))
                .multilineTextAlignment(textAlignment)
                .frame(maxWidth: .infinity, alignment: frameAlignment)

            if let pinyin = example.pinyin {
                Text(pinyin)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(textAlignment)
                    .frame(maxWidth: .infinity, alignment: frameAlignment)
            }

            if let translation = example.localizedMeaning {
                Text(translation)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                    .multilineTextAlignment(textAlignment)
                    .frame(maxWidth: .infinity, alignment: frameAlignment)
            }
        }
    }
}

#Preview("Legacy") {
    ExampleRowView(example: .legacyPreview, style: .detailed)
        .padding()
}

#Preview("Modern") {
    ExampleRowView(example: .modernPreview, style: .detailed)
        .padding()
}

#Preview("Compact") {
    ExampleRowView(example: .modernPreview, style: .compact)
        .padding()
}
