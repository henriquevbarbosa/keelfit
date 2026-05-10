import SwiftUI

struct WorkoutSetRow: View {
    let setNumber: Int
    @Binding var repsText: String
    @Binding var weightText: String
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: Spacing.sm) {
            Text("\(setNumber)")
                .font(.caption)
                .foregroundColor(.textTertiary)
                .frame(width: 24, alignment: .center)
            
            TextField("0", text: $repsText)
                .font(.bodyMedium)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .frame(width: 50)
                .padding(Spacing.xs)
                .background(Color.surface)
                .cornerRadius(Radius.sm)
            
            Text("×")
                .font(.caption)
                .foregroundColor(.textSecondary)
            
            TextField("0.0", text: $weightText)
                .font(.bodyMedium)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.center)
                .frame(width: 60)
                .padding(Spacing.xs)
                .background(Color.surface)
                .cornerRadius(Radius.sm)
            
            Text("kg")
                .font(.caption)
                .foregroundColor(.textTertiary)
            
            Spacer()
            
            Button(action: onDelete) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.error)
                    .font(.title3)
            }
            .buttonStyle(.plain)
        }
        .frame(minHeight: 44)
    }
}

#Preview {
    @Previewable @State var repsText = "10"
    @Previewable @State var weightText = "60.0"
    
    WorkoutSetRow(setNumber: 1, repsText: $repsText, weightText: $weightText, onDelete: {})
        .padding()
        .background(Color.appBackground)
}
