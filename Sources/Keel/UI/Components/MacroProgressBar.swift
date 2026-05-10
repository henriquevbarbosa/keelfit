import SwiftUI

struct MacroProgressBar: View {
    let label: String
    let current: Double
    let target: Double
    let color: Color
    
    var progress: Double {
        min(current / max(target, 1), 1.0)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            HStack {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.textSecondary)
                Spacer()
                Text("\(Int(current))g / \(Int(target))g")
                    .font(.caption)
                    .foregroundColor(.textTertiary)
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: Radius.full)
                        .fill(Color.surface)
                        .frame(height: 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: Radius.full)
                                .stroke(Color.divider, lineWidth: 0.5)
                        )
                    RoundedRectangle(cornerRadius: Radius.full)
                        .fill(color)
                        .frame(width: geo.size.width * progress, height: 8)
                }
            }
            .frame(height: 8)
        }
    }
}

#Preview {
    VStack(spacing: Spacing.lg) {
        MacroProgressBar(label: "Proteína", current: 120, target: 180, color: .proteinColor)
        MacroProgressBar(label: "Carboidratos", current: 200, target: 250, color: .carbsColor)
        MacroProgressBar(label: "Gordura", current: 45, target: 70, color: .fatColor)
    }
    .padding()
    .background(Color.appBackground)
}
