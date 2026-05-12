import SwiftUI

public struct OnboardingContainer: View {
    @State private var viewModel: OnboardingViewModel
    @State private var shouldShowOnboarding: Bool? = nil
    @AppStorage("onboardingComplete") private var onboardingComplete = false
    
    private let persistenceService: PersistenceService
    
    public init(persistenceService: PersistenceService = PersistenceService()) {
        self.persistenceService = persistenceService
        _viewModel = State(wrappedValue: OnboardingViewModel(persistenceService: persistenceService))
    }
    
    public var body: some View {
        ZStack {
            if let show = shouldShowOnboarding {
                if show {
                    mainContent
                } else {
                    ContentView()
                }
            } else {
                ProgressView()
                    .tint(.accent)
            }
        }
        .task {
            await checkExistingProfile()
        }
    }
    
    private var mainContent: some View {
        VStack(spacing: 0) {
            ProgressBar(progress: viewModel.progress)
                .padding(.horizontal, Spacing.lg)
                .padding(.top, Spacing.lg)
            
            Group {
                switch viewModel.currentStep {
                case .weight:
                    WeightInputView(viewModel: viewModel)
                case .goal:
                    GoalSelectorView(viewModel: viewModel)
                case .activity:
                    ActivityLevelView(viewModel: viewModel)
                }
            }
        }
        .background(Color.appBackground.ignoresSafeArea())
        .alert("Erro", isPresented: .constant(viewModel.errorMessage != nil), actions: {
            Button("OK") { viewModel.errorMessage = nil }
        }, message: {
            if let msg = viewModel.errorMessage {
                Text(msg)
            }
        })
        .onChange(of: viewModel.isCompleted) { _, completed in
            if completed {
                onboardingComplete = true
                withAnimation {
                    shouldShowOnboarding = false
                }
            }
        }
    }
    
    private func checkExistingProfile() async {
        let exists = await persistenceService.hasExistingProfile()
        withAnimation {
            shouldShowOnboarding = !exists && !onboardingComplete
        }
    }
}

public struct ProgressBar: View {
    let progress: Double
    
    public var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: Radius.full)
                    .fill(Color.surface)
                    .frame(height: 4)
                
                RoundedRectangle(cornerRadius: Radius.full)
                    .fill(Color.accent)
                    .frame(width: geo.size.width * progress, height: 4)
            }
        }
        .frame(height: 4)
    }
}
