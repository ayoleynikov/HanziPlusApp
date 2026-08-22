//
//  TravelPhraseDetailView.swift
//  HanziPlus
//

import SwiftUI
import UIKit

struct TravelPhraseDetailView: View {
    let phrase: TravelPhrase

    @Environment(TravelPhraseStore.self) private var phraseStore
    @State private var showToLocal = false
    @State private var didCopy = false

    private var isFavorite: Bool {
        phraseStore.isFavorite(phrase.id)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(phrase.simplifiedChinese)
                        .font(.system(size: 40, weight: .bold))
                        .minimumScaleFactor(0.5)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(phrase.pinyin)
                        .font(.title3)
                        .foregroundStyle(.secondary)

                    Text(phrase.english)
                        .font(.title3.weight(.medium))
                        .fixedSize(horizontal: false, vertical: true)
                }

                if let note = phrase.usageNote, !note.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Usage")
                            .font(.subheadline.weight(.semibold))
                        Text(note)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background {
                        RoundedRectangle(cornerRadius: AppRadius.medium, style: .continuous)
                            .fill(Color(.secondarySystemGroupedBackground))
                    }
                }

                if let replies = phrase.possibleReplies, !replies.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Possible replies")
                            .font(.headline)

                        ForEach(replies) { reply in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(reply.chinese)
                                    .font(.body.weight(.semibold))
                                Text(reply.pinyin)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text(reply.english)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(14)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background {
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(Color(.secondarySystemGroupedBackground))
                            }
                        }
                    }
                }

                VStack(spacing: 12) {
                    actionButton(title: "Play", systemImage: "speaker.wave.2.fill", tint: .orange) {
                        markUsed()
                        HapticService.light()
                        SpeechService.shared.speak(phrase.simplifiedChinese)
                    }

                    actionButton(title: "Play Slowly", systemImage: "tortoise.fill", tint: .blue) {
                        markUsed()
                        HapticService.light()
                        SpeechService.shared.speakSlow(phrase.simplifiedChinese)
                    }

                    actionButton(
                        title: isFavorite ? "Favorited" : "Favorite",
                        systemImage: isFavorite ? "heart.fill" : "heart",
                        tint: .red
                    ) {
                        HapticService.light()
                        phraseStore.toggleFavorite(phrase.id)
                    }

                    actionButton(title: didCopy ? "Copied" : "Copy Chinese", systemImage: "doc.on.doc", tint: .indigo) {
                        UIPasteboard.general.string = phrase.simplifiedChinese
                        didCopy = true
                        HapticService.success()
                        markUsed()
                    }

                    actionButton(title: "Show to Local", systemImage: "iphone", tint: .primary) {
                        markUsed()
                        showToLocal = true
                    }
                }
            }
            .padding(AppSpacing.medium)
            .padding(.bottom, AppSpacing.extraLarge)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Phrase")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { markUsed() }
        .fullScreenCover(isPresented: $showToLocal) {
            TravelShowToLocalView(phrase: phrase)
        }
    }

    private func markUsed() {
        phraseStore.markUsed(phrase.id)
    }

    private func actionButton(
        title: String,
        systemImage: String,
        tint: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Label(title, systemImage: systemImage)
                .font(.body.weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background {
                    Capsule(style: .continuous)
                        .fill(tint == .primary
                              ? Color(.secondarySystemGroupedBackground)
                              : tint.opacity(0.14))
                }
                .foregroundStyle(tint == .primary ? Color.primary : tint)
        }
        .accessibilityLabel(title)
    }
}
