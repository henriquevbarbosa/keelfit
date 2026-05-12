import SwiftUI

struct ContentView: View {
    @AppStorage("onboardingComplete") private var onboardingComplete = false
    @AppStorage("showOnboarding") private var showOnboarding = false

    var body: some View {
        if !onboardingComplete && showOnboarding {
            OnboardingContainer(persistenceService: PersistenceService.shared)
        } else {
            MainTabView()
        }
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                WorkoutView()
                    .navigationTitle("Treino")
            }
            .tabItem { Label("Treino", systemImage: "figure.strengthtraining.traditional") }

            NavigationStack {
                NutritionView()
                    .navigationTitle("Nutricao")
            }
            .tabItem { Label("Nutricao", systemImage: "fork.knife") }

            NavigationStack {
                HistoryView()
                    .navigationTitle("Historico")
            }
            .tabItem { Label("Historico", systemImage: "calendar") }

            NavigationStack {
                SettingsView()
                    .navigationTitle("Configuracoes")
            }
            .tabItem { Label("Ajustes", systemImage: "gearshape.fill") }
        }
        .preferredColorScheme(.dark)
        .accentColor(Color.accent)
    }
}
