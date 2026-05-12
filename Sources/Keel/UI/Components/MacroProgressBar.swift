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
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(label)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color(red: 0.627, green: 0.627, blue: 0.627))
                Spacer()
                Text("\(Int(current))g / \(Int(target))g")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color(red: 0.420, green: 0.420, blue: 0.420))
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 9999)
                        .fill(Color(red: 0.078, green: 0.078, blue: 0.078))
                        .frame(height: 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 9999)
                                .stroke(Color(red: 0.165, green: 0.165, blue: 0.165), lineWidth: 0.5)
                        )
                    RoundedRectangle(cornerRadius: 9999)
                        .fill(color)
                        .frame(width: geo.size.width * progress, height: 8)
                }
            }
            .frame(height: 8)
        }
    }
}

#if !SKIP
#Preview {
    VStack(spacing: 16) {
        MacroProgressBar(label: "Proteína", current: 120, target: 180, color: Color(red: 1.0, green: 0.420, blue: 0.420))
        MacroProgressBar(label: "Carboidratos", current: 200, target: 250, color: Color(red: 0.306, green: 0.800, blue: 0.769))
        MacroProgressBar(label: "Gordura", current: 45, target: 70, color: Color(red: 1.0, green: 0.898, blue: 0.427))
    }
    .padding()
    .background(Color(red: 0.039, green: 0.039, blue: 0.039))
}
#endif
