import Foundation

// MARK: - HistoryRecord
public struct HistoryRecord: Identifiable {
    public let id: String
    public let date: Date
    public let displayDate: String
    public let weekday: String
    public let exerciseCount: Int
    public let totalSets: Int
    public let totalVolume: Double
    public let intensity: String

    public init(from session: WorkoutSession) {
        self.id = session.id
        self.date = session.date
        self.exerciseCount = session.exerciseCount
        self.totalSets = session.totalSets
        self.totalVolume = session.totalVolume
        self.intensity = session.intensity

        let f = DateFormatter()
        f.dateStyle = .short
        f.locale = Locale(identifier: "pt_BR")
        self.displayDate = f.string(from: session.date)

        let wf = DateFormatter()
        wf.dateFormat = "EEEE"
        wf.locale = Locale(identifier: "pt_BR")
        self.weekday = wf.string(from: session.date).capitalized
    }
}

// MARK: - HistoryViewModel
@Observable
public class HistoryViewModel {
    public var records: [HistoryRecord] = []
    public var showPaywall: Bool = false

    public init() {}

    public func loadSampleIfEmpty() {
        guard records.isEmpty else { return }
        records = [
            HistoryRecord(from: WorkoutSession(
                date: Calendar.current.date(byAdding: .day, value: 0, to: Date())!,
                exercises: [ExerciseLog(exerciseID: "bp", exerciseName: "Supino Reto", muscleGroup: "Peito", sets: [SetEntry(reps: 10, weight: 80)])],
                intensity: "Pesado"
            )),
            HistoryRecord(from: WorkoutSession(
                date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                exercises: [ExerciseLog(exerciseID: "sq", exerciseName: "Agachamento", muscleGroup: "Pernas", sets: [SetEntry(reps: 8, weight: 100)])],
                intensity: "Moderado"
            )),
            HistoryRecord(from: WorkoutSession(
                date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
                exercises: [ExerciseLog(exerciseID: "pr", exerciseName: "Puxada Alta", muscleGroup: "Costas", sets: [SetEntry(reps: 12, weight: 60)])],
                intensity: "Leve"
            ))
        ]
    }
}
