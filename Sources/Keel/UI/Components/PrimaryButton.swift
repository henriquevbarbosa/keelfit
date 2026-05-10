import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isLoading: Bool = false
    var isDisabled: Bool = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.sm) {
                if isLoading {
                    ProgressView()
                        .tint(.appBackground)
                }
                Text(title)
                    .font(.callout)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.md)
            .padding(.horizontal, Spacing.lg)
            .background(isDisabled ? Color.accent.opacity(0.4) : Color.accent)
            .foregroundColor(.appBackground)
            .cornerRadius(Radius.md)
            .scaleEffect(isDisabled ? 1.0 : 1.0)
        }
        .disabled(isDisabled || isLoading)
        .buttonStyle(.plain)
    }
}

#Preview("Default") {
    PrimaryButton(title: "Concluir treino", action: {})
        .padding()
        .background(Color.appBackground)
}

#Preview("Loading") {
    PrimaryButton(title: "Salvando...", action: {}, isLoading: true)
        .padding()
        .background(Color.appBackground)
}
