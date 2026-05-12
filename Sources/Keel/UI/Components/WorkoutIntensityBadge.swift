import SwiftUI

extension WorkoutIntensity {
    var color: Color {
        switch self {
        case .light: return Color(red: 0.267, green: 0.541, blue: 1.0)
        case .moderate: return Color(red: 1.0, green: 0.702, blue: 0.0)
        case .heavy: return Color(red: 1.0, green: 0.322, blue: 0.322)
        }
    }
    var textColor: Color {
        switch self {
        case .light: return .white
        case .moderate, .heavy: return Color(red: 0.039, green: 0.039, blue: 0.039)
        }
    }
}

struct WorkoutIntensityBadge: View {
    let intensity: WorkoutIntensity

    var body: some View {
        Text(intensity.rawValue)
            .font(.caption.weight(.regular))
            .foregroundColor(intensity.textColor)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(intensity.color)
            .cornerRadius(4)
    }
}
