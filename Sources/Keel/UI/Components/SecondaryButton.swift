import SwiftUI

struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(Color(red: 0.078, green: 0.078, blue: 0.078))
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(red: 0.165, green: 0.165, blue: 0.165), lineWidth: 1)
                )
                .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }
}

#if !SKIP
#Preview {
    SecondaryButton(title: "Cancelar", action: {})
        .padding()
        .background(Color(red: 0.039, green: 0.039, blue: 0.039))
}
#endif
