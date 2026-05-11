import SwiftUI
import Combine
import UIKit
import AudioToolbox

final class GameViewModel: ObservableObject {
    let difficulty: GameDifficulty
    private let settings: GameSettings

    @Published var cards: [GameCard]
    @Published var score = 0
    @Published var moves = 0
    @Published var revealAllUses: Int
    @Published var peekTwoUses: Int
    @Published var shuffleUses: Int
    @Published var showWinSheet = false
    @Published var matchedCount = 0
    @Published var showConfetti = false
    @Published var isResolvingTurn = false

    private var firstFlippedIndex: Int?

    init(difficulty: GameDifficulty, settings: GameSettings) {
        self.difficulty = difficulty
        self.settings = settings
        cards = Self.buildDeck(pairs: difficulty.pairCount)
        revealAllUses = difficulty.powerUpUses
        peekTwoUses = difficulty.powerUpUses
        shuffleUses = difficulty.powerUpUses
    }

    var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 10), count: difficulty.columns)
    }

    var isComplete: Bool { matchedCount == difficulty.pairCount }

    var canUsePowerUps: Bool {
        !isResolvingTurn && firstFlippedIndex == nil && !isComplete
    }

    func handleTap(at index: Int) {
        guard !isResolvingTurn, !cards[index].isMatched, !cards[index].isFaceUp else { return }

        cards[index].isFaceUp = true

        if let first = firstFlippedIndex {
            moves += 1
            if cards[first].content == cards[index].content {
                cards[first].isMatched = true
                cards[index].isMatched = true
                score += 2
                matchedCount += 1
                firstFlippedIndex = nil
                fireMatchFeedback()
            } else {
                isResolvingTurn = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    self.cards[first].isFaceUp = false
                    self.cards[index].isFaceUp = false
                    self.firstFlippedIndex = nil
                    self.isResolvingTurn = false
                }
            }
        } else {
            firstFlippedIndex = index
        }
    }

    func resetGame() {
        cards = Self.buildDeck(pairs: difficulty.pairCount)
        firstFlippedIndex = nil
        isResolvingTurn = false
        score = 0
        moves = 0
        matchedCount = 0
        revealAllUses = difficulty.powerUpUses
        peekTwoUses = difficulty.powerUpUses
        shuffleUses = difficulty.powerUpUses
    }

    func useRevealAll() {
        guard canUsePowerUps, revealAllUses > 0 else { return }
        revealAllUses -= 1
        let indices = cards.indices.filter { !cards[$0].isMatched }
        indices.forEach { cards[$0].isFaceUp = true }
        isResolvingTurn = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            indices.forEach { if !self.cards[$0].isMatched { self.cards[$0].isFaceUp = false } }
            self.isResolvingTurn = false
        }
    }

    func usePeekTwo() {
        guard canUsePowerUps, peekTwoUses > 0 else { return }
        let candidates = cards.indices.filter { !cards[$0].isMatched && !cards[$0].isFaceUp }
        guard candidates.count >= 2 else { return }
        peekTwoUses -= 1
        let picked = Array(candidates.shuffled().prefix(2))
        picked.forEach { cards[$0].isFaceUp = true }
        isResolvingTurn = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            picked.forEach { if !self.cards[$0].isMatched { self.cards[$0].isFaceUp = false } }
            self.isResolvingTurn = false
        }
    }

    func useShuffle() {
        guard canUsePowerUps, shuffleUses > 0 else { return }
        shuffleUses -= 1
        let indices = cards.indices.filter { !cards[$0].isMatched }
        var unmatched = indices.map { cards[$0] }
        unmatched.shuffle()
        for (offset, idx) in indices.enumerated() { cards[idx] = unmatched[offset] }
    }

    func handleMatchCompletion() {
        updateBestStats()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.showConfetti = true
            self.showWinSheet = true
        }
    }

    func bestScoreValue() -> Int {
        switch difficulty {
        case .easy: return settings.bestScoreEasy
        case .medium: return settings.bestScoreMedium
        case .hard: return settings.bestScoreHard
        }
    }

    func bestMovesValue() -> Int {
        switch difficulty {
        case .easy: return settings.bestMovesEasy
        case .medium: return settings.bestMovesMedium
        case .hard: return settings.bestMovesHard
        }
    }

    func setBestScore(_ value: Int) {
        switch difficulty {
        case .easy: settings.bestScoreEasy = value
        case .medium: settings.bestScoreMedium = value
        case .hard: settings.bestScoreHard = value
        }
    }

    func setBestMoves(_ value: Int) {
        switch difficulty {
        case .easy: settings.bestMovesEasy = value
        case .medium: settings.bestMovesMedium = value
        case .hard: settings.bestMovesHard = value
        }
    }

    private func updateBestStats() {
        if score > bestScoreValue() { setBestScore(score) }
        if bestMovesValue() == 0 || moves < bestMovesValue() { setBestMoves(moves) }
    }

    private func fireMatchFeedback() {
        if settings.hapticsEnabled { UIImpactFeedbackGenerator(style: .medium).impactOccurred() }
        if settings.soundEnabled { AudioServicesPlaySystemSound(1104) }
    }

    private static func buildDeck(pairs: Int) -> [GameCard] {
        let n = min(pairs, DS.symbols.count)
        var deck: [GameCard] = []
        for i in 0..<n {
            let sym = DS.symbols[i]
            let grad = DS.cardGradients[i % DS.cardGradients.count]
            deck.append(GameCard(id: UUID(), content: sym, isFaceUp: false, isMatched: false, gradient: grad))
            deck.append(GameCard(id: UUID(), content: sym, isFaceUp: false, isMatched: false, gradient: grad))
        }
        return deck.shuffled()
    }
}
