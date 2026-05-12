import SwiftUI

struct MealInputRow: View {
    @Binding var name: String
    @Binding var proteinText: String
    @Binding var carbsText: String
    @Binding var fatText: String
    var onAdd: () -> Void

    private var isValid: Bool {
        let p = Double(proteinText) ?? 0
        let c = Double(carbsText) ?? 0
        let f = Double(fatText) ?? 0
        return !name.isEmpty && (p + c + f) > 0
    }

    var body: some View {
        VStack(spacing: 12) {
            TextField("Nome da refeicao", text: $name)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color(red: 0.078, green: 0.078, blue: 0.078))
                .cornerRadius(8)

            HStack(spacing: 8) {
                macroField("P", text: $proteinText)
                macroField("C", text: $carbsText)
                macroField("G", text: $fatText)
            }

            PrimaryButton(title: "Adicionar refeicao", action: onAdd)
                .disabled(!isValid)
                .opacity(isValid ? 1.0 : 0.5)
        }
        .padding(16)
        .background(Color(red: 0.141, green: 0.141, blue: 0.141))
        .cornerRadius(12)
    }

    private func macroField(_ label: String, text: Binding<String>) -> some View {
        TextField(label, text: text)
            .keyboardType(.decimalPad)
            .font(.subheadline)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.vertical, 8)
            .background(Color(red: 0.078, green: 0.078, blue: 0.078))
            .cornerRadius(8)
    }
}
