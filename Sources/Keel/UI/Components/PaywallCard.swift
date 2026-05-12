import SwiftUI

struct PaywallCard: View {
    let title: String
    let price: String
    let period: String
    let features: [String]
    let isPopular: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if isPopular {
                Text("MAIS POPULAR")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color(red: 0.039, green: 0.039, blue: 0.039))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(red: 0.784, green: 1.0, blue: 0.0))
                    .cornerRadius(4)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                HStack(alignment: .lastTextBaseline, spacing: 4) {
                    Text(price)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color(red: 0.784, green: 1.0, blue: 0.0))
                    Text(period)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color(red: 0.627, green: 0.627, blue: 0.627))
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(features, id: \.self) { feature in
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color(red: 0.0, green: 0.902, blue: 0.463))
                            .font(.system(size: 14, weight: .semibold))
                        Text(feature)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(red: 0.627, green: 0.627, blue: 0.627))
                    }
                }
            }
            
            PrimaryButton(title: "Assinar", action: action)
        }
        .padding(16)
        .background(Color(red: 0.102, green: 0.102, blue: 0.102))
        .overlay(
            Rectangle()
                .fill(Color(red: 0.784, green: 1.0, blue: 0.0))
                .frame(height: 2)
                .cornerRadius(16),
            alignment: .top
        )
        .cornerRadius(16)
    }
}

#if !SKIP
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
    .background(Color(red: 0.039, green: 0.039, blue: 0.039))
}
#endif
