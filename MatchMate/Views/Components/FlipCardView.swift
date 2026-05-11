import SwiftUI

struct FlipCardView: View {
    let card: GameCard
    let onTap: () -> Void

    @State private var rotation: Double = 0

    var body: some View {
        ZStack {
            // Back face
            backFace
                .opacity(rotation < 90 ? 1 : 0)

            // Front face
            frontFace
                .opacity(rotation >= 90 ? 1 : 0)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
        .aspectRatio(0.72, contentMode: .fit)
        .onTapGesture {
            guard !card.isMatched else { return }
            onTap()
        }
        .onChange(of: card.isFaceUp) { _, faceUp in
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                rotation = faceUp ? 180 : 0
            }
        }
        .onAppear {
            rotation = card.isFaceUp ? 180 : 0
        }
        .opacity(card.isMatched ? 0.32 : 1.0)
        .animation(.easeOut(duration: 0.25), value: card.isMatched)
    }

    private var backFace: some View {
        RoundedRectangle(cornerRadius: 18, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [Color(red:0.48,green:0.25,blue:0.92), Color(red:0.25,green:0.18,blue:0.78)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.white.opacity(0.15), lineWidth: 1)
            )
            .overlay(
                VStack(spacing: 5) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                    Text("TAP")
                        .font(.system(size: 10, weight: .black, design: .rounded))
                        .tracking(2)
                }
                .foregroundColor(.white.opacity(0.85))
            )
            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 6)
    }

    private var frontFace: some View {
        RoundedRectangle(cornerRadius: 18, style: .continuous)
            .fill(
                LinearGradient(
                    colors: card.gradient,
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.white.opacity(0.22), lineWidth: 1)
            )
            .overlay(
                Image(systemName: card.content)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
            )
            .shadow(color: card.gradient.first?.opacity(0.5) ?? .clear, radius: 10, x: 0, y: 6)
    }
}
