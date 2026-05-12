import SwiftUI

struct HomeView: View {
    var body: some View {
        Text("Home")
            .font(.system(size: 28, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.039, green: 0.039, blue: 0.039))
    }
}

#if !SKIP
#Preview {
    HomeView()
}
#endif
