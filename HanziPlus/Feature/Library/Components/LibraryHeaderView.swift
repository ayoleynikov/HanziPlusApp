//
//  LibraryHeaderView.swift
//  HanziPlus
//
//  Created by Анатолий on 2026/7/18.
//

import SwiftUI

struct LibraryHeaderView: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("learn.header.brand")
                .font(.system(size: 34, weight: .bold, design: .rounded))

            Text("learn.header.tagline")
                .font(.title3.weight(.regular))
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    LibraryHeaderView()
        .padding()
        .background(Color(.systemGroupedBackground))
}
