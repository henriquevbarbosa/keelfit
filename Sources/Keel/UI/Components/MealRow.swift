import SwiftUI

struct MealRow: View {
    let meal: MealEntry
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: Spacing.md) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(meal.name)
                    .font(.bodyMedium)
                    .foregroundColor(.textPrimary)
                Text(meal.mealType)
                    .font(.caption)
                    .foregroundColor(.textTertiary)
            }
            
            Spacer()
            
            HStack(spacing: Spacing.sm) {
                macroPill("P", value: meal.protein, color: .proteinColor)
                macroPill("C", value: meal.carbs, color: .carbsColor)
                macroPill("G", value: meal.fat, color: .fatColor)
            }
            
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .font(.caption)
                    .foregroundColor(.error)
            }
        }
        .padding(.vertical, Spacing.sm)
    }
    
    private func macroPill(_ label: String, value: Double, color: Color) -> some View {
        HStack(spacing: 2) {
            Text(label)
                .font(.system(size: 9, weight: .bold))
                .foregroundColor(color)
            Text("\(Int(value))")
                .font(.caption)
                .foregroundColor(.textSecondary)
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 2)
        .background(color.opacity(0.12))
        .cornerRadius(Radius.sm)
    }
}

#Preview {
    VStack(spacing: Spacing.md) {
        MealRow(meal: MealEntry(name: "Frango + arroz", protein: 35, carbs: 45, fat: 8, mealType: "Almoço"), onDelete: {})
        MealRow(meal: MealEntry(name: "Whey", protein: 25, carbs: 3, fat: 1, mealType: "Lanche"), onDelete: {})
    }
    .padding()
    .background(Color.appBackground)
}
