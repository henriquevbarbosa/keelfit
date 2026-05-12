import SwiftUI

public struct GoalSelectorView: View {
    @Bindable var viewModel: OnboardingViewModel
    
    public init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: Spacing.xl) {
            VStack(spacing: Spacing.sm) {
                Text("Qual é o teu objetivo?")
                    .font(.title1)
                    .foregroundColor(.accent)
                
                Text("Vamos ajustar os teus macros ao teu objetivo.")
                    .font(.bodyRegular)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            VStack(spacing: Spacing.md) {
                ForEach([GoalType.bulk, GoalType.maintenance, GoalType.cut], id: \.self) { goal in
                    GoalCard(
                        goal: goal,
                        isSelected: viewModel.selectedGoal == goal,
                        action: { viewModel.selectedGoal = goal }
                    )
                }
            }
            
            Spacer()
            
            HStack(spacing: Spacing.md) {
                Button(action: { viewModel.previousStep() }) {
                    Text("Voltar")
                        .font(.bodyMedium)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Spacing.md)
                        .background(Color.surface)
                        .foregroundColor(.accent)
                        .cornerRadius(Radius.md)
                }
                
                Button(action: { viewModel.nextStep() }) {
                    Text("Continuar")
                        .font(.bodyMedium)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Spacing.md)
                        .background(Color.accent)
                        .foregroundColor(.appBackground)
                        .cornerRadius(Radius.md)
                }
            }
        }
        .padding(.horizontal, Spacing.lg)
        .padding(.vertical, Spacing.xl)
        .background(Color.appBackground.ignoresSafeArea())
    }
}

struct GoalCard: View {
    let goal: GoalType
    let isSelected: Bool
    let action: () -> Void
    
    private var iconName: String {
        switch goal {
        case .bulk: return "arrow.up.circle.fill"
        case .maintenance: return "minus.circle.fill"
        case .cut: return "arrow.down.circle.fill"
        }
    }
    
    private var displayName: String {
        switch goal {
        case .bulk: return "Ganhar Massa"
        case .maintenance: return "Manter"
        case .cut: return "Perder Gordura"
        }
    }
    
    private var description: String {
        switch goal {
        case .bulk: return "Calorias acima da manutenção"
        case .maintenance: return "Calorias ao nível da manutenção"
        case .cut: return "Calorias abaixo da manutenção"
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.md) {
                Image(systemName: iconName)
                    .font(.title3)
                    .foregroundColor(isSelected ? .appBackground : .accent)
                    .frame(width: 44, height: 44)
                    .background(isSelected ? Color.accent : Color.surface)
                    .cornerRadius(Radius.md)
                
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text(displayName)
                        .font(.bodyMedium)
                        .foregroundColor(.white)
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.accent)
                }
            }
            .padding(Spacing.md)
            .background(isSelected ? Color.surfaceElevated : Color.surface)
            .overlay(
                RoundedRectangle(cornerRadius: Radius.md)
                    .stroke(isSelected ? Color.accent : Color.clear, lineWidth: 2)
            )
            .cornerRadius(Radius.md)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
