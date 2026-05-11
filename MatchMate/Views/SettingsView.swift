import SwiftUI
import Combine

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var settings: GameSettings
    @State private var showResetAlert = false

    var body: some View {
        ZStack {
            SpaceBackground()
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Settings")
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
                .padding(.bottom, 24)

                VStack(spacing: 12) {
                    settingToggle(icon: "speaker.wave.2.fill", label: "Sound Effects", isOn: $settings.soundEnabled)
                    settingToggle(icon: "hand.tap.fill", label: "Haptic Feedback", isOn: $settings.hapticsEnabled)

                    GlassCard(cornerRadius: 18) {
                        Button {
                            showResetAlert = true
                        } label: {
                            HStack {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(Color(red:1,green:0.35,blue:0.35))
                                Text("Reset All Best Scores")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundColor(Color(red:1,green:0.35,blue:0.35))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white.opacity(0.3))
                            }
                            .padding(18)
                        }
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
            }
        }
        .alert("Reset Best Scores?", isPresented: $showResetAlert) {
            Button("Reset", role: .destructive) { settings.resetBests() }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This will permanently clear all saved bests.")
        }
    }

    private func settingToggle(icon: String, label: String, isOn: Binding<Bool>) -> some View {
        GlassCard(cornerRadius: 18) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(DS.gold)
                    .frame(width: 28)
                Text(label)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
                Toggle("", isOn: isOn)
                    .labelsHidden()
                    .tint(Color(red:0.48,green:0.25,blue:0.92))
            }
            .padding(18)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(GameSettings())
}
