import SwiftUI
import Combine

/// Main tab view for the app. Contains the Macro Dashboard, Workout, History, and Settings tabs.
struct ContentView: View {
    // MARK: - Environment & State
    @State private var selectedTab = 0
    @StateObject private var subscriptionViewModel = SubscriptionViewModel()
    @State private var showPaywall = false
    @EnvironmentObject private var persistence: PersistenceService
    
    // MARK: - Constants
    private let tabSymbols = ["fork.knife", "figure.strengthtraining.traditional", "clock.arrow.circlepath", "gearshape.fill"]
    private let tabNames = ["Nutrição", "Treino", "Histórico", "Config"]
    
    var body: some View {
        ZStack {
            // Background
            Color(red: 0.039, green: 0.039, blue: 0.039)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Content Area
                TabView(selection: $selectedTab) {
                    NutritionView()
                        .tag(0)
                    
                    WorkoutView()
                        .tag(1)
                    
                    HistoryView()
                        .tag(2)
                    
                    SettingsView()
                        .tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                // Custom Tab Bar
                customTabBar
            }
        }
        .onAppear {
            checkSubscriptionAndShowPaywall()
        }
        .fullScreenCover(isPresented: $showPaywall) {
            PaywallView(viewModel: subscriptionViewModel)
        }
    }
    
    // MARK: - Custom Tab Bar
    private var customTabBar: some View {
        HStack(spacing: 0) {
            ForEach(0..<4) { index in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = index
                    }
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tabSymbols[index])
                            .font(.system(size: 20, weight: .semibold))
                        Text(tabNames[index])
                            .font(.system(size: 11, weight: .semibold))
                    }
                    .foregroundColor(selectedTab == index ? Color(red: 0.784, green: 1.0, blue: 0.0) : Color(red: 0.627, green: 0.627, blue: 0.627))
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(Color(red: 0.039, green: 0.039, blue: 0.039))
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color(red: 0.165, green: 0.165, blue: 0.165)),
            alignment: .top
        )
    }
    
    // MARK: - Actions
    private func checkSubscriptionAndShowPaywall() {
        // Simple logic: if no active subscription, show paywall after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if subscriptionViewModel.subscriptionStatus == .free {
                showPaywall = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PersistenceService.shared)
            .preferredColorScheme(.dark)
    }
}

