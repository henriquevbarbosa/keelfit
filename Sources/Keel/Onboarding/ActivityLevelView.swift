import SwiftUI

public struct ActivityLevelView: View {
    @Bindable var viewModel: OnboardingViewModel
    
    public init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }
    
    private let levels: [ActivityLevel] = [.light, .moderate, .active]
    
    public var body: some View {
        VStack(spacing: Spacing.xl) {
            VStack(spacing: Spacing.sm) {
                Text("Qual é o teu nível de atividade?")
                    .font(.title1)
                    .foregroundColor(.accent)
                
                Text("Isto ajuda a calcular as tuas necessidades calóricas.")
                    .font(.bodyRegular)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            VStack(spacing: Spacing.md) {
                ForEach(levels, id: \.self) { level in
                    ActivityCard(
                        level: level,
                        isSelected: viewModel.selectedActivity == level,
                        action: { viewModel.selectedActivity = level }
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
                
                Button(action: { Task { await viewModel.completeOnboarding() } }) {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.appBackground)
                        }
                        Text("Começar")
                            .font(.bodyMedium)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Spacing.md)
                    .background(Color.accent)
                    .foregroundColor(.appBackground)
                    .cornerRadius(Radius.md)
                }
                .disabled(viewModel.isLoading)
            }
        }
        .padding(.horizontal, Spacing.lg)
        .padding(.vertical, Spacing.xl)
        .background(Color.appBackground.ignoresSafeArea())
    }
}

struct ActivityCard: View {
    let level: ActivityLevel
    let isSelected: Bool
    let action: () -> Void
    
    private var iconName: String {
        switch level {
        case .sedentary, .light: return "figure.walk"
        case .moderate: return "figure.run"
        case .active, .veryActive: return "figure.highintensity.intervaltraining"
        }
    }
    
    private var displayName: String {
        switch level {
        case .sedentary: return "Sedentário"
        case .light: return "Leve"
        case .moderate: return "Moderada"
        case .active: return "Intensa"
        case .veryActive: return "Muito Intensa"
        }
    }
    
    private var description: String {
        switch level {
        case .sedentary: return "Pouco ou nenhum exercício"
        case .light: return "1-2x por semana"
        case .moderate: return "3-4x por semana"
        case .active: return "5-6x por semana"
        case .veryActive: return "Atleta / treino intenso diário"
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
