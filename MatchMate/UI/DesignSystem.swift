import SwiftUI

enum DS {
    // Deep space background palette
    static let bgTop    = Color(red: 0.06, green: 0.04, blue: 0.18)
    static let bgMid    = Color(red: 0.10, green: 0.07, blue: 0.26)
    static let bgBot    = Color(red: 0.04, green: 0.12, blue: 0.22)

    // Accent
    static let gold     = Color(red: 0.98, green: 0.80, blue: 0.12)
    static let goldDim  = Color(red: 0.96, green: 0.65, blue: 0.08)

    // Glass surface
    static let glass    = Color.white.opacity(0.07)
    static let glassBorder = Color.white.opacity(0.13)

    // Card gradients (front face)
    static let cardGradients: [[Color]] = [
        [Color(red:0.98,green:0.35,blue:0.45), Color(red:0.75,green:0.15,blue:0.55)],
        [Color(red:0.25,green:0.78,blue:0.92), Color(red:0.10,green:0.45,blue:0.90)],
        [Color(red:0.42,green:0.90,blue:0.55), Color(red:0.05,green:0.62,blue:0.45)],
        [Color(red:0.98,green:0.68,blue:0.15), Color(red:0.92,green:0.38,blue:0.10)],
        [Color(red:0.72,green:0.40,blue:0.98), Color(red:0.42,green:0.18,blue:0.88)],
        [Color(red:0.98,green:0.45,blue:0.72), Color(red:0.75,green:0.18,blue:0.50)],
        [Color(red:0.18,green:0.90,blue:0.78), Color(red:0.05,green:0.55,blue:0.72)],
        [Color(red:0.95,green:0.82,blue:0.25), Color(red:0.88,green:0.52,blue:0.05)],
        [Color(red:0.50,green:0.70,blue:0.98), Color(red:0.18,green:0.35,blue:0.92)],
        [Color(red:0.98,green:0.55,blue:0.30), Color(red:0.82,green:0.22,blue:0.18)],
        [Color(red:0.60,green:0.92,blue:0.35), Color(red:0.25,green:0.68,blue:0.18)],
        [Color(red:0.92,green:0.38,blue:0.90), Color(red:0.55,green:0.10,blue:0.80)],
    ]

    static let symbols: [String] = [
        "bolt.fill","leaf.fill","moon.stars.fill","flame.fill","suit.heart.fill","star.fill",
        "cloud.fill","sparkles","sun.max.fill","snowflake","tortoise.fill","hare.fill"
    ]
}
