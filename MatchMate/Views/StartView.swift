import SwiftUI
import Combine

struct StartView: View {
    @EnvironmentObject private var settings: GameSettings

    @State private var showHowToPlay = false
    @State private var showSettings = false
    @State private var showLeaderboard = false

    private var selectedDifficulty: GameDifficulty {
        GameDifficulty(rawValue: settings.selectedDifficultyRaw) ?? .easy
    }

    var body: some View {
        ZStack {
            SpaceBackground()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Flippo")
                            .font(.system(size: 44, weight: .black, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(colors: [DS.gold, DS.goldDim, DS.gold], startPoint: .leading, endPoint: .trailing)
                            )
                        Text("Find every pair — use your power-ups!")
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundColor(.white.opacity(0.65))
                    }
                    .padding(.top, 32)

                    // Best Score Card
                    GlassCard(cornerRadius: 22) {
                        VStack(spacing: 6) {
                            Text("BEST SCORE · \(selectedDifficulty.title.uppercased())")
                                .font(.system(size: 11, weight: .bold, design: .rounded))
                                .tracking(1.5)
                                .foregroundColor(.white.opacity(0.5))
                            let best = bestScoreForDifficulty(selectedDifficulty)
                            Text(best == 0 ? "—" : "\(best)")
                                .font(.system(size: 52, weight: .black, design: .rounded))
                                .foregroundStyle(
                                    best == 0
                                    ? AnyShapeStyle(Color.white.opacity(0.25))
                                    : AnyShapeStyle(LinearGradient(colors:[DS.gold, DS.goldDim], startPoint:.leading, endPoint:.trailing))
                                )
                            Text(selectedDifficulty.subtitle)
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(.white.opacity(0.4))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 24)
                        .padding(.horizontal, 20)
                    }
                    .padding(.horizontal, 20)

                    // Difficulty Selector
                    VStack(spacing: 12) {
                        Text("DIFFICULTY")
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .tracking(1.5)
                            .foregroundColor(.white.opacity(0.5))

                        HStack(spacing: 10) {
                            ForEach(GameDifficulty.allCases) { diff in
                                DifficultyTile(
                                    difficulty: diff,
                                    isSelected: settings.selectedDifficultyRaw == diff.rawValue
                                ) {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        settings.selectedDifficultyRaw = diff.rawValue
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)

                    // Play Button
                    NavigationLink {
                        MemoryMatchGameView(difficulty: selectedDifficulty, settings: settings)
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "play.fill")
                            Text("Play Now")
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.horizontal, 20)

                    // Bottom Actions
                    HStack(spacing: 10) {
                        Button {
                            showHowToPlay = true
                        } label: {
                            Label("How to Play", systemImage: "questionmark.circle.fill")
                        }
                        .buttonStyle(GhostButtonStyle())

                        Button {
                            showSettings = true
                        } label: {
                            Label("Settings", systemImage: "gearshape.fill")
                        }
                        .buttonStyle(GhostButtonStyle())

                        Button {
                            showLeaderboard = true
                        } label: {
                            Label("Scores", systemImage: "crown.fill")
                        }
                        .buttonStyle(GhostButtonStyle())
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showHowToPlay)   { HowToPlayView() }
        .sheet(isPresented: $showSettings)    { SettingsView() }
        .sheet(isPresented: $showLeaderboard) { LeaderboardView() }
    }

    private func bestScoreForDifficulty(_ difficulty: GameDifficulty) -> Int {
        switch difficulty {
        case .easy:   return settings.bestScoreEasy
        case .medium: return settings.bestScoreMedium
        case .hard:   return settings.bestScoreHard
        }
    }
}

#Preview {
    StartView()
        .environmentObject(GameSettings())
}
