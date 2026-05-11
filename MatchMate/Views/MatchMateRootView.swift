import SwiftUI
import Combine

struct MatchMateRootView: View {
    var body: some View {
        NavigationStack {
            StartView()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    MatchMateRootView()
        .environmentObject(GameSettings())
}
