import SwiftUI
import Combine

struct LeaderboardView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var settings: GameSettings

    var body: some View {
        ZStack {
            SpaceBackground()
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Leaderboard")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                    Spacer()
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 26))
                            .foregroundColor(.white.opacity(0.4))
                    }
                }
                .padding([.top,.horizontal], 24)
                .padding(.bottom, 24)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 14) {
                        leaderboardCard(difficulty: .easy, score: settings.bestScoreEasy, moves: settings.bestMovesEasy)
                        leaderboardCard(difficulty: .medium, score: settings.bestScoreMedium, moves: settings.bestMovesMedium)
                        leaderboardCard(difficulty: .hard, score: settings.bestScoreHard, moves: settings.bestMovesHard)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
    }

    private func leaderboardCard(difficulty: GameDifficulty, score: Int, moves: Int) -> some View {
        GlassCard(cornerRadius: 20) {
            VStack(spacing: 14) {
                HStack {
                    HStack(spacing: 8) {
                        Text(difficulty.emoji).font(.system(size: 22))
                        Text(difficulty.title)
                            .font(.system(size: 17, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text(difficulty.subtitle)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.white.opacity(0.45))
                }

                HStack(spacing: 10) {
                    lbStatBox(icon: "star.fill", label: "Best Score", value: score == 0 ? "—" : "\(score)", color: DS.gold)
                    lbStatBox(icon: "arrow.triangle.2.circlepath", label: "Best Moves", value: moves == 0 ? "—" : "\(moves)", color: Color(red:0.55,green:0.75,blue:1.0))
                }
            }
            .padding(18)
        }
    }

    private func lbStatBox(icon: String, label: String, value: String, color: Color) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(color)
            Text(value)
                .font(.system(size: 22, weight: .black, design: .rounded))
                .foregroundColor(.white)
            Text(label)
                .font(.system(size: 10, weight: .bold, design: .rounded))
                .foregroundColor(.white.opacity(0.45))
                .tracking(0.5)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(DS.glass)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(DS.glassBorder, lineWidth: 1))
    }
}

#Preview {
    LeaderboardView()
        .environmentObject(GameSettings())
}
