import SwiftUI

struct HistoryView: View {
    @State private var viewModel = HistoryViewModel()
    @State private var showPaywall = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Historico")
                        .font(.title.weight(.bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(16)

                if viewModel.records.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "calendar.badge.clock")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        Text("Nenhum treino registrado")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 80)
                }

                LazyVStack(spacing: 12) {
                    ForEach(viewModel.records) { record in
                        HistoryRowView(record: record)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .background(Color(red: 0.039, green: 0.039, blue: 0.039))
        .onAppear { viewModel.loadSampleIfEmpty() }
        .sheet(isPresented: $showPaywall) {
            PaywallSheet { showPaywall = false }
        }
        .preferredColorScheme(.dark)
    }
}

struct HistoryRowView: View {
    let record: HistoryRecord

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(record.displayDate)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text(record.intensity)
                    .font(.caption.weight(.medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(intensityColor)
                    .cornerRadius(4)
            }
            HStack(spacing: 16) {
                Label("\(record.exerciseCount) exercicios", systemImage: "figure.strengthtraining.traditional")
                    .font(.caption)
                    .foregroundColor(.gray)
                Label("\(Int(record.totalVolume)) kg", systemImage: "scalemass")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
        }
        .padding(12)
        .background(Color(red: 0.078, green: 0.078, blue: 0.078))
        .cornerRadius(10)
    }

    var intensityColor: Color {
        switch record.intensity {
        case "Leve": return Color(red: 0.267, green: 0.541, blue: 1.0)
        case "Moderado": return Color(red: 1.0, green: 0.702, blue: 0.0)
        default: return Color(red: 1.0, green: 0.322, blue: 0.322)
        }
    }
}
