import SwiftUI

struct SpaceBackground: View {
    var body: some View {
        LinearGradient(
            colors: [DS.bgTop, DS.bgMid, DS.bgBot],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .overlay(
            ZStack {
                Circle()
                    .fill(Color(red:0.48,green:0.20,blue:0.90).opacity(0.18))
                    .frame(width: 340)
                    .offset(x: -120, y: -260)
                    .blur(radius: 60)
                Circle()
                    .fill(Color(red:0.08,green:0.55,blue:0.92).opacity(0.15))
                    .frame(width: 280)
                    .offset(x: 140, y: 120)
                    .blur(radius: 50)
                Circle()
                    .fill(Color(red:0.92,green:0.28,blue:0.55).opacity(0.10))
                    .frame(width: 220)
                    .offset(x: 60, y: 360)
                    .blur(radius: 50)
            }
        )
        .ignoresSafeArea()
    }
}
