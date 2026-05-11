import SwiftUI

struct GameCard: Identifiable {
    let id: UUID
    let content: String
    var isFaceUp: Bool
    var isMatched: Bool
    let gradient: [Color]
}
