import SwiftUI

struct NutritionBanner: View {
    let lastWorkout: WorkoutSession?

    private var message: String {
        guard let workout = lastWorkout else {
            return "Bora treinar? Registre seu treino para ajustar seus macros."
        }
        let calendar = Calendar.current
        let isToday = calendar.isDateInToday(workout.date)
        guard isToday else {
            return "Ultimo treino: \(workout.formattedDate). Mantenha a consistencia!"
        }
        switch workout.intensity {
        case "Leve":
            return "Treino leve — foque em proteinas e mantenha a dieta no alvo."
        case "Pesado":
            return "Treino intenso hoje — priorize proteina e carboidratos para recuperacao."
        default:
            return "Bom trabalho! Mantenha os macros no alvo."
        }
    }

    private var accentColor: Color {
        guard let workout = lastWorkout,
              Calendar.current.isDateInToday(workout.date) else {
            return .gray
        }
        switch workout.intensity {
        case "Pesado": return Color(red: 1.0, green: 0.420, blue: 0.420)
        case "Leve": return Color(red: 0.306, green: 0.800, blue: 0.769)
        default: return Color.accent
        }
    }

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: bannerIcon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(accentColor)
            Text(message)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)
            Spacer()
        }
        .padding(14)
        .background(Color(red: 0.078, green: 0.078, blue: 0.078))
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0.165, green: 0.165, blue: 0.165), lineWidth: 0.5))
    }

    private var bannerIcon: String {
        guard let workout = lastWorkout else { return "figure.walk" }
        switch workout.intensity {
        case "Pesado": return "flame.fill"
        case "Leve": return "leaf.fill"
        default: return "checkmark.seal.fill"
        }
    }
}
