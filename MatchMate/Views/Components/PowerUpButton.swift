import SwiftUI

struct PowerUpButton: View {
    let icon: String
    let label: String
    let uses: Int
    let disabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                Text(label)
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                Text("\(uses) left")
                    .font(.system(size: 9, weight: .semibold, design: .rounded))
                    .foregroundColor(.white.opacity(0.5))
            }
            .foregroundColor(.white.opacity(disabled ? 0.35 : 0.9))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(DS.glass)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(DS.glassBorder, lineWidth: 1)
                    )
            )
        }
        .disabled(disabled)
        .opacity(disabled ? 0.5 : 1.0)
        .animation(.easeOut(duration: 0.2), value: disabled)
    }
}
