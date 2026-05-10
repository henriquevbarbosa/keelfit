import SwiftUI

struct PaywallCard: View {
    let title: String
    let price: String
    let period: String
    let features: [String]
    let isPopular: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.lg) {
            if isPopular {
                Text("MAIS POPULAR")
                    .font(.caption)
                    .foregroundColor(.appBackground)
                    .padding(.horizontal, Spacing.sm)
                    .padding(.vertical, Spacing.xs)
                    .background(Color.accent)
                    .cornerRadius(Radius.sm)
            }
            
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(title)
                    .font(.title3)
                    .foregroundColor(.textPrimary)
                HStack(alignment: .lastTextBaseline, spacing: Spacing.xs) {
                    Text(price)
                        .font(.display)
                        .foregroundColor(.accent)
                    Text(period)
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }
            }
            
            VStack(alignment: .leading, spacing: Spacing.sm) {
                ForEach(features, id: \.self) { feature in
                    HStack(spacing: Spacing.sm) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.success)
                            .font(.callout)
                        Text(feature)
                            .font(.bodyRegular)
                            .foregroundColor(.textSecondary)
                    }
                }
            }
            
            PrimaryButton(title: "Assinar", action: action)
        }
        .padding(Spacing.lg)
        .background(Color.surfaceElevated)
        .overlay(
            Rectangle()
                .fill(Color.accent)
                .frame(height: 2)
                .cornerRadius(Radius.xl),
            alignment: .top
        )
        .cornerRadius(Radius.xl)
    }
}

#Preview {
    PaywallCard(
        title: "Keel Pro",
        price: "R$ 39,90",
        period: "/mês",
        features: [
            "Histórico ilimitado",
            "Gráficos de progresso",
            "Análise de macros"
        ],
        isPopular: true,
        action: {}
    )
    .padding()
    .background(Color.appBackground)
}
