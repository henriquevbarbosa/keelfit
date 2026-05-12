import SwiftUI

struct NutritionView: View {
    @State private var viewModel = NutritionViewModel()
    @State private var profile: UserProfile? = nil
    @State private var mealName: String = ""
    @State private var proteinText: String = ""
    @State private var carbsText: String = ""
    @State private var fatText: String = ""

    private var isValid: Bool {
        let p = Double(proteinText) ?? 0
        let c = Double(carbsText) ?? 0
        let f = Double(fatText) ?? 0
        return !mealName.isEmpty && (p + c + f) > 0
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                NutritionBanner(lastWorkout: viewModel.lastWorkout)

                VStack(spacing: 16) {
                    HStack {
                        Text("Macros de hoje")
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(Int(viewModel.totalCalories)) kcal")
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.gray)
                    }

                    MacroProgressBar(
                        label: "Proteina",
                        current: viewModel.totalProtein,
                        target: viewModel.target.protein,
                        color: Color(red: 1.0, green: 0.420, blue: 0.420)
                    )
                    MacroProgressBar(
                        label: "Carboidratos",
                        current: viewModel.totalCarbs,
                        target: viewModel.target.carbs,
                        color: Color(red: 0.306, green: 0.800, blue: 0.769)
                    )
                    MacroProgressBar(
                        label: "Gordura",
                        current: viewModel.totalFat,
                        target: viewModel.target.fat,
                        color: Color(red: 1.0, green: 0.898, blue: 0.427)
                    )
                }
                .padding(16)
                .background(Color(red: 0.141, green: 0.141, blue: 0.141))
                .cornerRadius(12)

                VStack(spacing: 12) {
                    TextField("Nome da refeicao", text: $mealName)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color(red: 0.078, green: 0.078, blue: 0.078))
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0.165, green: 0.165, blue: 0.165), lineWidth: 0.5))

                    HStack(spacing: 8) {
                        HStack {
                            TextField("P", text: $proteinText)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.center)
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Text("g").font(.caption).foregroundColor(.gray)
                        }
                        .padding(8)
                        .background(Color(red: 0.078, green: 0.078, blue: 0.078))
                        .cornerRadius(8)
                        HStack {
                            TextField("C", text: $carbsText)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.center)
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Text("g").font(.caption).foregroundColor(.gray)
                        }
                        .padding(8)
                        .background(Color(red: 0.078, green: 0.078, blue: 0.078))
                        .cornerRadius(8)
                        HStack {
                            TextField("G", text: $fatText)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.center)
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Text("g").font(.caption).foregroundColor(.gray)
                        }
                        .padding(8)
                        .background(Color(red: 0.078, green: 0.078, blue: 0.078))
                        .cornerRadius(8)
                    }

                    PrimaryButton(title: "Adicionar refeicao") {
                        guard let p = Double(proteinText),
                              let c = Double(carbsText),
                              let f = Double(fatText) else { return }
                        viewModel.addMeal(name: mealName, protein: p, carbs: c, fat: f)
                        mealName = ""
                        proteinText = ""
                        carbsText = ""
                        fatText = ""
                    }
                    .disabled(!isValid)
                    .opacity(isValid ? 1.0 : 0.5)
                }

                if !viewModel.meals.isEmpty {
                    VStack(spacing: 8) {
                        ForEach(viewModel.meals) { meal in
                            MealRowView(meal: meal, onDelete: { viewModel.removeMeal(meal: meal) })
                        }
                    }
                }

                if let p = profile {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Formula de calculo")
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.white)
                        Text(viewModel.formulaBreakdown(profile: p))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(12)
                    .background(Color(red: 0.078, green: 0.078, blue: 0.078))
                    .cornerRadius(8)
                }
            }
            .padding(16)
        }
        .background(Color(red: 0.039, green: 0.039, blue: 0.039))
        .onAppear {
            profile = PersistenceService.shared.load(UserProfile.self, key: "userProfile")
        }
    }
}

struct MealRowView: View {
    let meal: MealEntry
    var onDelete: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(meal.name)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.white)
                Text("P:\(Int(meal.protein))g C:\(Int(meal.carbs))g G:\(Int(meal.fat))g")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("\(Int(meal.calories)) kcal")
                .font(.caption.weight(.medium))
                .foregroundColor(.gray)
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(Color(red: 1.0, green: 0.322, blue: 0.322))
            }
        }
        .padding(8)
        .background(Color(red: 0.078, green: 0.078, blue: 0.078))
        .cornerRadius(8)
    }
}
