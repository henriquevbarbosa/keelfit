import SwiftUI

public struct WeightInputView: View {
    @Bindable var viewModel: OnboardingViewModel
    
    public init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: Spacing.xl) {
            VStack(spacing: Spacing.sm) {
                Text("Qual é o teu peso?")
                    .font(.title1)
                    .foregroundColor(.accent)
                
                Text("Vamos calcular os teus macros com base no teu peso.")
                    .font(.bodyRegular)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            HStack(spacing: Spacing.lg) {
                VStack(spacing: Spacing.sm) {
                    TextField("0", text: $viewModel.weightText)
                        .font(.system(size: 56, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                        .foregroundColor(.white)
                        .frame(height: 80)
                    
                    HStack(spacing: Spacing.sm) {
                        unitButton(.kg)
                        unitButton(.lb)
                    }
                }
            }
            
            Spacer()
            
            VStack(spacing: Spacing.md) {
                Button(action: { viewModel.nextStep() }) {
                    Text("Continuar")
                        .font(.bodyMedium)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Spacing.md)
                        .background(viewModel.canProceed ? Color.accent : Color.textTertiary)
                        .foregroundColor(.appBackground)
                        .cornerRadius(Radius.md)
                }
                .disabled(!viewModel.canProceed)
            }
        }
        .padding(.horizontal, Spacing.lg)
        .padding(.vertical, Spacing.xl)
        .background(Color.appBackground.ignoresSafeArea())
    }
    
    private func unitButton(_ unit: WeightUnit) -> some View {
        Button(action: { viewModel.selectedUnit = unit }) {
            Text(unit.displayName)
                .font(.bodyMedium)
                .padding(.horizontal, Spacing.lg)
                .padding(.vertical, Spacing.sm)
                .background(viewModel.selectedUnit == unit ? Color.accent : Color.surface)
                .foregroundColor(viewModel.selectedUnit == unit ? .appBackground : .textSecondary)
                .cornerRadius(Radius.full)
        }
    }
}
