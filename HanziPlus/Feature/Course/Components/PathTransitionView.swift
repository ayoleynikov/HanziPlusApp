//
//  PathTransitionView.swift
//  HanziPlus
//

import SwiftUI

struct PathTransitionView: View {

    let text: String
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            Spacer(minLength: 0)

            Text(text)
                .font(.title2.weight(.semibold))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, AppSpacing.medium)

            Spacer(minLength: 0)

            Button(action: onContinue) {
                Text(PathStrings.next)
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .frame(minHeight: 44)
                    .background(Capsule(style: .continuous).fill(Color.teal))
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    PathTransitionView(text: PathStrings.continueConversation, onContinue: {})
        .padding()
}
