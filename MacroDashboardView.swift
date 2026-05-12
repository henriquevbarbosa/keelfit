import SwiftUI
import SkipUI

public struct MacroDashboardView: View {
    @Environment(MacroDashboardViewModel.self) private var viewModel
    @Environment(\.modelContext) private var modelContext
    @State private var showFormula = false
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                bannerView
                macroProgressView
                mealTypeSelectionView
                todaysMealsView
                addMealButton
            }
            .padding(20)
        }
        .background(Color.appBackground)
        .sheet(isPresented: $viewModel.showAddMealSheet) {
            addMealSheet
                .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $viewModel.showFormulaSheet) {
            formulaSheetView
                .presentationDetents([.medium, .large])
        }
        .task {
            viewModel.loadProfileAndMeals(modelContext: modelContext)
        }
    }
    
    @ViewBuilder
    private var bannerView: some View {
        if let message = viewModel.bannerMessage {
            HStack(spacing: 12) {
                Image(systemName: "flame.fill")
                    .foregroundColor(.accent)
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.textPrimary)
                Spacer()
            }
            .padding(16)
            .background(Color.surfaceBackground)
            .cornerRadius(12)
        }
    }
    
    private var macroProgressView: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Macros do dia")
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                Spacer()
                Button(action: {
                    viewModel.showFormulaSheet = true
                }) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.accent)
                }
            }
            
            if let target = viewModel.currentTarget {
                MacroProgressBar(label: "Proteína", current: viewModel.totalProtein, target: target.protein, color: .proteinColor)
                MacroProgressBar(label: "Carboidratos", current: viewModel.totalCarbs, target: target.carbs, color: .carbsColor)
                MacroProgressBar(label: "Gordura", current: viewModel.totalFat, target: target.fat, color: .fatColor)
            }
            
            HStack {
                Text("Total: \(Int(viewModel.totalCalories)) kcal")
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
                Spacer()
            }
        }
        .padding(16)
        .background(Color.surfaceBackground)
        .cornerRadius(12)
    }
    
    private var mealTypeSelectionView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(Array(viewModel.mealTypes.enumerated()), id: \.element) { index, type in
                    Button(action: {
                        viewModel.selectedMealType = viewModel.mealTypes[index]
                    }) {
                        Text(type)
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(viewModel.selectedMealType == type ? Color.accent : Color.surfaceBackground)
                            .foregroundColor(viewModel.selectedMealType == type ? .black : .white)
                            .cornerRadius(20)
                    }
                }
            }
            .padding(.horizontal, 4)
        }
    }
    
    private var todaysMealsView: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Refeições de hoje")
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                Spacer()
                Text("\(viewModel.meals.count)")
                    .font(.caption)
                    .foregroundColor(.textSecondary)
            }
            
            if viewModel.meals.isEmpty {
                Text("Nenhuma refeição registrada hoje")
                    .font(.subheadline)
                    .foregroundColor(.textTertiary)
                    .padding(.vertical, 20)
            } else {
                ForEach(viewModel.meals) { meal in
                    MealRow(meal: meal, onDelete: {
                        viewModel.deleteMeal(meal, modelContext: modelContext)
                    })
                }
            }
        }
    }
    
    private var addMealButton: some View {
        Button(action: {
            viewModel.showAddMealSheet = true
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Adicionar refeição")
            }
            .font(.body.bold())
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accent)
            .foregroundColor(.black)
            .cornerRadius(12)
        }
    }
    
    private var addMealSheet: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Nova refeição")
                .font(.title2.bold())
                .foregroundColor(.textPrimary)
            
            TextField("Nome da refeição", text: $viewModel.newMealName)
                .textFieldStyle(.roundedBorder)
                .foregroundColor(.textPrimary)
            
            HStack(spacing: 12) {
                macroInputField(title: "Proteína (g)", text: $viewModel.newMealProteinText)
                macroInputField(title: "Carbo (g)", text: $viewModel.newMealCarbsText)
                macroInputField(title: "Gordura (g)", text: $viewModel.newMealFatText)
            }
            
            HStack {
                Text("Tipo: \(viewModel.selectedMealType)")
                    .font(.subheadline)
                Spacer()
                Picker("Tipo", selection: $viewModel.selectedMealType) {
                    ForEach(viewModel.mealTypes, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
                .pickerStyle(.menu)
                .tint(.accent)
            }
            
            Button(action: {
                viewModel.addMeal(modelContext: modelContext)
                viewModel.showAddMealSheet = false
            }) {
                Text("Salvar")
                    .font(.body.bold())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accent)
                    .foregroundColor(.black)
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(Color.surfaceBackground)
    }
    
    private var formulaSheetView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Fórmula de cálculo")
                    .font(.title2.bold())
                    .foregroundColor(.textPrimary)
                
                Text(viewModel.formulaDescription)
                    .font(.caption)
                    .foregroundColor(.textSecondary)
                    .monospaced()
            }
            .padding()
        }
        .background(Color.surfaceBackground)
    }
    
    private func macroInputField(title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.textSecondary)
            TextField("0", text: text)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                .foregroundColor(.textPrimary)
        }
    }
}

#Preview {
    MacroDashboardView()
        .environment(MacroDashboardViewModel())
        .environment(\.modelContext, try! ModelContainer(for: UserProfile.self, MealEntry.self).mainContext)
        .preferredColorScheme(.dark)
}

