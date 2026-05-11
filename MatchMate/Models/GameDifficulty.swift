import Foundation

enum GameDifficulty: String, CaseIterable, Identifiable {
    case easy, medium, hard
    var id: String { rawValue }

    var title: String {
        switch self {
        case .easy:   return "Easy"
        case .medium: return "Medium"
        case .hard:   return "Hard"
        }
    }

    var emoji: String {
        switch self {
        case .easy:   return "⭐"
        case .medium: return "🔥"
        case .hard:   return "💎"
        }
    }

    var subtitle: String {
        switch self {
        case .easy:   return "6 pairs"
        case .medium: return "8 pairs"
        case .hard:   return "10 pairs"
        }
    }

    var pairCount: Int {
        switch self {
        case .easy:   return 6
        case .medium: return 8
        case .hard:   return 10
        }
    }

    var columns: Int {
        switch self {
        case .easy:   return 3
        case .medium: return 4
        case .hard:   return 4
        }
    }

    var powerUpUses: Int { 1 }
}
