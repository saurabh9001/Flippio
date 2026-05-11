import SwiftUI

struct WinView: View {
    let score: Int
    let moves: Int
    let bestScore: Int
    let bestMoves: Int
    let onReplay: () -> Void
    let onHome: () -> Void

    var isNewBest: Bool { score >= bestScore && bestScore > 0 }

    var body: some View {
        ZStack {
            SpaceBackground()

            VStack(spacing: 24) {
                Spacer()

                VStack(spacing: 6) {
                    Text(isNewBest ? "🏆" : "🎉")
                        .font(.system(size: 64))
                    Text(isNewBest ? "New Record!" : "You Win!")
                        .font(.system(size: 36, weight: .black, design: .rounded))
                        .foregroundStyle(LinearGradient(colors:[DS.gold,DS.goldDim], startPoint:.leading, endPoint:.trailing))
                    Text("Great matching!")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                }

                // Stats grid
                GlassCard(cornerRadius: 22) {
                    VStack(spacing: 0) {
                        winStatRow(label: "Score", value: "\(score)", accent: DS.gold)
                        Divider().background(DS.glassBorder)
                        winStatRow(label: "Moves", value: "\(moves)", accent: .white)
                        Divider().background(DS.glassBorder)
                        winStatRow(label: "Best Score", value: bestScore == 0 ? "—" : "\(bestScore)", accent: Color(red:0.28,green:0.88,blue:0.62))
                        Divider().background(DS.glassBorder)
                        winStatRow(label: "Best Moves", value: bestMoves == 0 ? "—" : "\(bestMoves)", accent: Color(red:0.55,green:0.75,blue:1.0))
                    }
                    .padding(.vertical, 4)
                }
                .padding(.horizontal, 24)

                VStack(spacing: 12) {
                    Button {
                        onReplay()
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "arrow.clockwise")
                            Text("Play Again")
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())

                    Button {
                        onHome()
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "house.fill")
                            Text("Back to Home")
                        }
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(0.85))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(DS.glass)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(DS.glassBorder, lineWidth: 1))
                    }
                }
                .padding(.horizontal, 24)

                Spacer()
            }
        }
    }

    private func winStatRow(label: String, value: String, accent: Color) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundColor(.white.opacity(0.65))
            Spacer()
            Text(value)
                .font(.system(size: 18, weight: .black, design: .rounded))
                .foregroundColor(accent)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }
}

#Preview {
    WinView(score: 24, moves: 12, bestScore: 30, bestMoves: 10, onReplay: {}, onHome: {})
}
