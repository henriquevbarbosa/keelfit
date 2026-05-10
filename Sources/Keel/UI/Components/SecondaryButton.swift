import SwiftUI

struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.callout)
                .frame(maxWidth: .infinity)
                .padding(.vertical, Spacing.md)
                .padding(.horizontal, Spacing.lg)
                .background(Color.surface)
                .foregroundColor(.textPrimary)
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.md)
                        .stroke(Color.divider, lineWidth: 1)
                )
                .cornerRadius(Radius.md)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SecondaryButton(title: "Cancelar", action: {})
        .padding()
        .background(Color.appBackground)
}
