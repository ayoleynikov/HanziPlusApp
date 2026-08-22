import SwiftUI

/// Legacy entry point — delegates to the scalable Games platform hub.
struct GamesView: View {
    var body: some View {
        GamesHubView()
    }
}

#Preview {
    GamesView()
        .environment(GameScoreStore())
}
