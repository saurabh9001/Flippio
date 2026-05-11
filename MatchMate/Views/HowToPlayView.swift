import SwiftUI

struct HowToPlayView: View {
    @Environment(\.dismiss) private var dismiss

    private let steps: [(icon: String, title: String, desc: String)] = [
        ("hand.tap", "Flip Cards", "Tap any two cards to reveal them."),
        ("checkmark.circle.fill", "Match Pairs", "Matched pairs stay face-up and earn you 2 points."),
        ("sparkles", "Use Power-Ups", "Reveal All, Peek Two, or Shuffle to get unstuck."),
        ("flag.checkered", "Chase Records", "Fewer moves and higher scores set new bests."),
    ]

    var body: some View {
        ZStack {
            SpaceBackground()
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("How to Play")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                    Spacer()
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 26))
                            .foregroundColor(.white.opacity(0.4))
                    }
                }
                .padding([.top,.horizontal], 24)
                .padding(.bottom, 20)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 14) {
                        ForEach(steps, id: \.title) { step in
                            GlassCard(cornerRadius: 18) {
                                HStack(spacing: 14) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                                            .fill(LinearGradient(colors:[Color(red:0.48,green:0.25,blue:0.92).opacity(0.5), Color(red:0.25,green:0.18,blue:0.78).opacity(0.5)], startPoint:.topLeading, endPoint:.bottomTrailing))
                                            .frame(width: 44, height: 44)
                                        Image(systemName: step.icon)
                                            .font(.system(size: 18, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(step.title)
                                            .font(.system(size: 15, weight: .bold, design: .rounded))
                                            .foregroundColor(.white)
                                        Text(step.desc)
                                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                                            .foregroundColor(.white.opacity(0.6))
                                    }
                                    Spacer()
                                }
                                .padding(16)
                            }
                        }

                        Text("POWER-UPS")
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .tracking(1.5)
                            .foregroundColor(.white.opacity(0.4))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 6)

                        ForEach([
                            ("eye.fill","Reveal All","Shows all unmatched cards for 2 seconds."),
                            ("sparkles","Peek Two","Flips two random hidden cards briefly."),
                            ("shuffle","Shuffle","Randomly rearranges all unmatched cards.")
                        ], id: \.1) { icon, title, desc in
                            GlassCard(cornerRadius: 18) {
                                HStack(spacing: 14) {
                                    Image(systemName: icon)
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(DS.gold)
                                        .frame(width: 36)
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(title)
                                            .font(.system(size: 14, weight: .bold, design: .rounded))
                                            .foregroundColor(.white)
                                        Text(desc)
                                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                                            .foregroundColor(.white.opacity(0.55))
                                    }
                                    Spacer()
                                }
                                .padding(14)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

#Preview {
    HowToPlayView()
}
