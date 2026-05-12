import SwiftUI

struct PaywallSheet: View {
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isPurchasing = false

    var onDismiss: () -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 48))
                            .foregroundColor(Color.accent)
                        Text("Historico ilimitado")
                            .font(.title2.weight(.bold))
                            .foregroundColor(.white)
                        Text("Desbloqueie todos os seus dados de treino e nutricao")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 24)

                    if RevenueCatService.shared.isLoading || isPurchasing {
                        ProgressView()
                            .tint(Color.accent)
                            .padding(.top, 40)
                    } else if RevenueCatService.shared.offerings.isEmpty {
                        Text("Nenhum produto disponivel")
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.top, 40)
                    } else {
                        ForEach(RevenueCatService.shared.offerings) { product in
                            PaywallCard(
                                title: product.title,
                                price: product.price,
                                period: product.period,
                                features: product.features,
                                isPopular: product.isPopular,
                                action: {
                                    isPurchasing = true
                                    Task {
                                        _ = await RevenueCatService.shared.purchase(product: product)
                                        isPurchasing = false
                                    }
                                }
                            )
                        }
                    }

                    Button("Restaurar compras") {
                        Task { await RevenueCatService.shared.restore() }
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                }
                .padding()
            }
            .background(Color(red: 0.039, green: 0.039, blue: 0.039))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fechar") { onDismiss() }
                        .foregroundColor(Color.accent)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}
