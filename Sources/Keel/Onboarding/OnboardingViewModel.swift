import SwiftUI
import Observation

@Observable
public final class OnboardingViewModel {
    public enum Step: Int, CaseIterable {
        case weight = 0
        case goal = 1
        case activity = 2
    }
    
    public var currentStep: Step = .weight
    public var weightText: String = ""
    public var selectedUnit: WeightUnit = .kg
    public var selectedGoal: GoalType = .maintenance
    public var selectedActivity: ActivityLevel = .moderate
    public var isCompleted: Bool = false
    public var isLoading: Bool = false
    public var errorMessage: String?
    
    private let persistenceService: PersistenceService
    
    public init(persistenceService: PersistenceService = PersistenceService()) {
        self.persistenceService = persistenceService
    }
    
    public var weightKg: Double {
        guard let value = Double(weightText.filter { $0.isNumber || $0 == "." }) else { return 0 }
        return selectedUnit.convertToKg(value)
    }
    
    public var progress: Double {
        Double(currentStep.rawValue + 1) / Double(Step.allCases.count)
    }
    
    public var canProceed: Bool {
        switch currentStep {
        case .weight:
            guard let val = Double(weightText.filter { $0.isNumber || $0 == "." }), val > 20, val < 500 else { return false }
            return true
        case .goal: return true
        case .activity: return true
        }
    }
    
    public func nextStep() {
        guard currentStep.rawValue < Step.allCases.count - 1 else { return }
        currentStep = Step(rawValue: currentStep.rawValue + 1) ?? .activity
    }
    
    public func previousStep() {
        guard currentStep.rawValue > 0 else { return }
        currentStep = Step(rawValue: currentStep.rawValue - 1) ?? .weight
    }
    
    public func completeOnboarding() async {
        isLoading = true
        errorMessage = nil
        
        let profile = UserProfile(
            weight: weightKg,
            goal: selectedGoal.rawValue,
            activityLevel: selectedActivity.rawValue
        )
        
        do {
            try await persistenceService.saveProfile(profile)
            isCompleted = true
        } catch {
            errorMessage = "Erro ao guardar perfil. Tenta novamente."
        }
        
        isLoading = false
    }
}
