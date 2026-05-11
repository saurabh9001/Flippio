import SwiftUI

struct DifficultyTile: View {
    let difficulty: GameDifficulty
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 6) {
                Text(difficulty.emoji)
                    .font(.system(size: 26))
                Text(difficulty.title)
                    .font(.system(size: 14, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                Text(difficulty.subtitle)
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundColor(.white.opacity(0.55))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(isSelected
                          ? LinearGradient(colors: [Color(red:0.48,green:0.25,blue:0.92).opacity(0.55), Color(red:0.25,green:0.18,blue:0.78).opacity(0.55)], startPoint: .topLeading, endPoint: .bottomTrailing)
                          : LinearGradient(colors: [DS.glass, DS.glass], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(isSelected ? Color(red:0.58,green:0.35,blue:0.98) : DS.glassBorder, lineWidth: isSelected ? 1.5 : 1)
                    )
            )
            .shadow(color: isSelected ? Color(red:0.48,green:0.25,blue:0.92).opacity(0.4) : .clear, radius: 12, x: 0, y: 6)
        }
        .buttonStyle(.plain)
    }
}
