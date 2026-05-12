import SwiftUI

struct SettingsView: View {
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Configuracoes")
                        .font(.title.weight(.bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 16)

                VStack(spacing: 12) {
                    if RevenueCatService.shared.isPro {
                        proCard
                    } else {
                        freeCard
                    }
                }
                .padding(.horizontal, 16)

                VStack(spacing: 12) {
                    Button("Restaurar compras") {
                        Task {
                            await RevenueCatService.shared.restore()
                            alertMessage = "Compras restauradas com sucesso!"
                            showAlert = true
                        }
                    }
                    .font(.body)
                    .foregroundColor(Color.accent)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color(red: 0.078, green: 0.078, blue: 0.078))
                    .cornerRadius(10)
                }
                .padding(.horizontal, 16)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Sobre")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.white)
                    Text("Keel v1.0 MVP built with SwiftUI + Skip.dev")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
            .padding(.vertical, 20)
        }
        .background(Color(red: 0.039, green: 0.039, blue: 0.039))
        .alert("Restaurar Compras", isPresented: $showAlert) {
            Button("OK") {}
        } message: {
            Text(alertMessage)
        }
        .preferredColorScheme(.dark)
    }

    var proCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "crown.fill")
                    .foregroundColor(Color.accent)
                Text("Keel Pro Ativo")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }
            HStack(spacing: 8) {
                Image(systemName: "infinity").foregroundColor(Color.accent)
                Text("Historico ilimitado").foregroundColor(.white).font(.subheadline)
                Spacer()
            }
            HStack(spacing: 8) {
                Image(systemName: "chart.bar.fill").foregroundColor(Color.accent)
                Text("Analises avancadas").foregroundColor(.white).font(.subheadline)
                Spacer()
            }
            HStack(spacing: 8) {
                Image(systemName: "square.and.arrow.up.fill").foregroundColor(Color.accent)
                Text("Exportar dados").foregroundColor(.white).font(.subheadline)
                Spacer()
            }
        }
        .padding(16)
        .background(Color(red: 0.102, green: 0.102, blue: 0.102))
        .cornerRadius(12)
    }

    var freeCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "person.fill")
                    .foregroundColor(.gray)
                Text("Versao gratuita")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }
            Text("7 dias de historico gratuito. Upgrade para ilimitado.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(16)
        .background(Color(red: 0.078, green: 0.078, blue: 0.078))
        .cornerRadius(12)
    }
}
