import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Keel")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(Color(red: 0.784, green: 1.0, blue: 0.0))
            Text("Treino + Nutrição")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
            PrimaryButton(title: "Começar", action: {})
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.039, green: 0.039, blue: 0.039))
    }
}

#if !SKIP
#Preview {
    OnboardingView()
}
#endif
