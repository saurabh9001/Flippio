import SwiftUI
import Combine

struct MemoryMatchGameView: View {
    let difficulty: GameDifficulty
    private let settings: GameSettings

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: GameViewModel

    init(difficulty: GameDifficulty, settings: GameSettings) {
        self.difficulty = difficulty
        self.settings = settings
        _viewModel = StateObject(wrappedValue: GameViewModel(difficulty: difficulty, settings: settings))
    }

    var body: some View {
        ZStack {
            SpaceBackground()

            VStack(spacing: 0) {
                // Top HUD
                topHUD
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 10)

                // Stats
                statsRow
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)

                // Power-ups
                powerUpsRow
                    .padding(.horizontal, 16)
                    .padding(.bottom, 14)

                // Progress bar
                progressBar
                    .padding(.horizontal, 16)
                    .padding(.bottom, 14)

                // Card grid
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: viewModel.columns, spacing: 10) {
                        ForEach(Array(viewModel.cards.enumerated()), id: \.element.id) { index, card in
                            FlipCardView(card: card) {
                                viewModel.handleTap(at: index)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 30)
                }
            }

            if viewModel.showConfetti { ConfettiView() }
        }
        .navigationBarHidden(true)
        .onChange(of: viewModel.matchedCount) { _, count in
            if count == difficulty.pairCount {
                viewModel.handleMatchCompletion()
            }
        }
        .sheet(isPresented: $viewModel.showWinSheet) {
            WinView(
                score: viewModel.score, moves: viewModel.moves,
                bestScore: viewModel.bestScoreValue(), bestMoves: viewModel.bestMovesValue()
            ) {
                viewModel.resetGame()
                viewModel.showWinSheet = false
                viewModel.showConfetti = false
            } onHome: {
                viewModel.showWinSheet = false
                viewModel.showConfetti = false
                dismiss()
            }
        }
    }

    // MARK: Sub-views

    private var topHUD: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 13, weight: .bold))
                    Text("Home")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                }
                .foregroundColor(.white.opacity(0.8))
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(DS.glass)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(DS.glassBorder, lineWidth: 1))
            }

            Spacer()

            VStack(spacing: 1) {
                Text("Flippo")
                    .font(.system(size: 17, weight: .black, design: .rounded))
                    .foregroundStyle(LinearGradient(colors:[DS.gold, DS.goldDim], startPoint:.leading, endPoint:.trailing))
                Text("\(difficulty.emoji) \(difficulty.title) · \(difficulty.subtitle)")
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundColor(.white.opacity(0.5))
            }

            Spacer()

            Button("New") {
                withAnimation { viewModel.resetGame() }
            }
            .font(.system(size: 14, weight: .bold, design: .rounded))
            .foregroundColor(.white.opacity(0.8))
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(DS.glass)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(DS.glassBorder, lineWidth: 1))
        }
    }

    private var statsRow: some View {
        HStack(spacing: 10) {
            statPill(icon: "star.fill", label: "Score", value: "\(viewModel.score)", accent: DS.gold)
            statPill(icon: "arrow.triangle.2.circlepath", label: "Moves", value: "\(viewModel.moves)", accent: .white)
            statPill(icon: "checkmark.circle.fill", label: "Pairs", value: "\(viewModel.matchedCount)/\(difficulty.pairCount)", accent: Color(red:0.28,green:0.88,blue:0.62))
        }
    }

    private func statPill(icon: String, label: String, value: String, accent: Color) -> some View {
        GlassCard(cornerRadius: 14) {
            VStack(spacing: 3) {
                Image(systemName: icon)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(accent)
                Text(value)
                    .font(.system(size: 20, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                Text(label)
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundColor(.white.opacity(0.45))
                    .tracking(0.5)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
        }
    }

    private var powerUpsRow: some View {
        HStack(spacing: 8) {
            PowerUpButton(icon: "eye.fill", label: "Reveal All", uses: viewModel.revealAllUses, disabled: !viewModel.canUsePowerUps || viewModel.revealAllUses == 0) { viewModel.useRevealAll() }
            PowerUpButton(icon: "sparkles", label: "Peek Two", uses: viewModel.peekTwoUses, disabled: !viewModel.canUsePowerUps || viewModel.peekTwoUses == 0) { viewModel.usePeekTwo() }
            PowerUpButton(icon: "shuffle", label: "Shuffle", uses: viewModel.shuffleUses, disabled: !viewModel.canUsePowerUps || viewModel.shuffleUses == 0) { viewModel.useShuffle() }
        }
    }

    private var progressBar: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(DS.glass)
                    .frame(height: 6)

                RoundedRectangle(cornerRadius: 6)
                    .fill(LinearGradient(colors:[DS.gold, DS.goldDim], startPoint:.leading, endPoint:.trailing))
                    .frame(width: geo.size.width * CGFloat(viewModel.matchedCount) / CGFloat(difficulty.pairCount), height: 6)
                    .animation(.spring(response: 0.4, dampingFraction: 0.7), value: viewModel.matchedCount)
            }
        }
        .frame(height: 6)
    }
}

#Preview {
    MemoryMatchGameView(difficulty: .easy, settings: GameSettings())
}
