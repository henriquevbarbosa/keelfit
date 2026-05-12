import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isLoading: Bool = false
    var isDisabled: Bool = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .tint(Color(red: 0.039, green: 0.039, blue: 0.039))
                }
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(isDisabled ? Color(red: 0.784, green: 1.0, blue: 0.0).opacity(0.4) : Color(red: 0.784, green: 1.0, blue: 0.0))
            .foregroundColor(Color(red: 0.039, green: 0.039, blue: 0.039))
            .cornerRadius(8)
        }
        .disabled(isDisabled || isLoading)
        .buttonStyle(.plain)
    }
}

#if !SKIP
#Preview("Default") {
    PrimaryButton(title: "Concluir treino", action: {})
        .padding()
        .background(Color(red: 0.039, green: 0.039, blue: 0.039))
}

#Preview("Loading") {
    PrimaryButton(title: "Salvando...", action: {}, isLoading: true)
        .padding()
        .background(Color(red: 0.039, green: 0.039, blue: 0.039))
}
#endif
