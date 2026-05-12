import SwiftUI

struct WorkoutSetRow: View {
    let setNumber: Int
    @Binding var repsText: String
    @Binding var weightText: String
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Text("\(setNumber)")
                .font(.caption)
                .foregroundColor(.gray)
                .frame(width: 24, alignment: .center)

            TextField("0", text: $repsText)
                .font(.body.weight(.medium))
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .frame(width: 50)
                .padding(4)
                .background(Color(red: 0.078, green: 0.078, blue: 0.078))
                .cornerRadius(4)

            Text("x")
                .font(.caption)
                .foregroundColor(.gray)

            TextField("0.0", text: $weightText)
                .font(.body.weight(.medium))
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.center)
                .frame(width: 60)
                .padding(4)
                .background(Color(red: 0.078, green: 0.078, blue: 0.078))
                .cornerRadius(4)

            Text("kg")
                .font(.caption)
                .foregroundColor(.gray)

            Spacer()

            Button(action: onDelete) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(Color(red: 1.0, green: 0.322, blue: 0.322))
            }
            .buttonStyle(.plain)
        }
        .frame(minHeight: 44)
    }
}
