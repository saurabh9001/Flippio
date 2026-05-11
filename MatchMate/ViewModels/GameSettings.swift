import SwiftUI
import Combine

final class GameSettings: ObservableObject {
    private enum Keys {
        static let selectedDifficulty = "selectedDifficulty"
        static let bestScoreEasy = "bestScore_easy"
        static let bestScoreMedium = "bestScore_medium"
        static let bestScoreHard = "bestScore_hard"
        static let bestMovesEasy = "bestMoves_easy"
        static let bestMovesMedium = "bestMoves_medium"
        static let bestMovesHard = "bestMoves_hard"
        static let soundEnabled = "soundEnabled"
        static let hapticsEnabled = "hapticsEnabled"
    }

    private let defaults: UserDefaults

    @Published var selectedDifficultyRaw: String {
        didSet { defaults.set(selectedDifficultyRaw, forKey: Keys.selectedDifficulty) }
    }

    @Published var bestScoreEasy: Int {
        didSet { defaults.set(bestScoreEasy, forKey: Keys.bestScoreEasy) }
    }

    @Published var bestScoreMedium: Int {
        didSet { defaults.set(bestScoreMedium, forKey: Keys.bestScoreMedium) }
    }

    @Published var bestScoreHard: Int {
        didSet { defaults.set(bestScoreHard, forKey: Keys.bestScoreHard) }
    }

    @Published var bestMovesEasy: Int {
        didSet { defaults.set(bestMovesEasy, forKey: Keys.bestMovesEasy) }
    }

    @Published var bestMovesMedium: Int {
        didSet { defaults.set(bestMovesMedium, forKey: Keys.bestMovesMedium) }
    }

    @Published var bestMovesHard: Int {
        didSet { defaults.set(bestMovesHard, forKey: Keys.bestMovesHard) }
    }

    @Published var soundEnabled: Bool {
        didSet { defaults.set(soundEnabled, forKey: Keys.soundEnabled) }
    }

    @Published var hapticsEnabled: Bool {
        didSet { defaults.set(hapticsEnabled, forKey: Keys.hapticsEnabled) }
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        selectedDifficultyRaw = defaults.string(forKey: Keys.selectedDifficulty) ?? GameDifficulty.easy.rawValue
        bestScoreEasy = defaults.integer(forKey: Keys.bestScoreEasy)
        bestScoreMedium = defaults.integer(forKey: Keys.bestScoreMedium)
        bestScoreHard = defaults.integer(forKey: Keys.bestScoreHard)
        bestMovesEasy = defaults.integer(forKey: Keys.bestMovesEasy)
        bestMovesMedium = defaults.integer(forKey: Keys.bestMovesMedium)
        bestMovesHard = defaults.integer(forKey: Keys.bestMovesHard)
        soundEnabled = defaults.object(forKey: Keys.soundEnabled) as? Bool ?? true
        hapticsEnabled = defaults.object(forKey: Keys.hapticsEnabled) as? Bool ?? true
    }

    func resetBests() {
        bestScoreEasy = 0
        bestScoreMedium = 0
        bestScoreHard = 0
        bestMovesEasy = 0
        bestMovesMedium = 0
        bestMovesHard = 0
    }
}
