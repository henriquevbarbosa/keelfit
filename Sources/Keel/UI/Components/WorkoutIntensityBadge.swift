import SwiftUI

enum WorkoutIntensity: String {
    case light = "Leve"
    case moderate = "Moderado"
    case heavy = "Pesado"
    
    var color: Color {
        switch self {
        case .light: return .info
        case .moderate: return .warning
        case .heavy: return .error
        }
    }
    
    var textColor: Color {
        switch self {
        case .light: return .textPrimary
        case .moderate, .heavy: return .appBackground
        }
    }
}

struct WorkoutIntensityBadge: View {
    let intensity: WorkoutIntensity
    
    var body: some View {
        Text(intensity.rawValue)
            .font(.caption)
            .foregroundColor(intensity.textColor)
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, Spacing.xs)
            .background(intensity.color)
            .cornerRadius(Radius.sm)
    }
}

#Preview {
    HStack(spacing: Spacing.md) {
        WorkoutIntensityBadge(intensity: .light)
        WorkoutIntensityBadge(intensity: .moderate)
        WorkoutIntensityBadge(intensity: .heavy)
    }
    .padding()
    .background(Color.appBackground)
}
