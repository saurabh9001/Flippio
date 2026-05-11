import SwiftUI

struct ConfettiView: View {
    let colors: [Color] = [.yellow, .pink, .cyan, .green, .orange, .purple, .mint]
    @State private var animate = false

    var body: some View {
        ZStack {
            ForEach(0..<40, id: \.self) { i in
                ConfettiPiece(color: colors[i % colors.count], index: i, animate: animate)
            }
        }
        .onAppear { animate = true }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}

struct ConfettiPiece: View {
    let color: Color
    let index: Int
    let animate: Bool

    private let startX: CGFloat
    private let endY: CGFloat
    private let rotation: Double
    private let size: CGFloat
    private let delay: Double

    init(color: Color, index: Int, animate: Bool) {
        self.color = color
        self.index = index
        self.animate = animate
        startX = CGFloat.random(in: 20...380)
        endY = CGFloat.random(in: 600...900)
        rotation = Double.random(in: 0...720)
        size = CGFloat.random(in: 6...12)
        delay = Double(index) * 0.04
    }

    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(color)
            .frame(width: size, height: size * 0.5)
            .position(x: startX, y: animate ? endY : -20)
            .rotationEffect(.degrees(animate ? rotation : 0))
            .opacity(animate ? 0 : 1)
            .animation(
                .easeIn(duration: Double.random(in: 1.5...2.5)).delay(delay),
                value: animate
            )
    }
}
