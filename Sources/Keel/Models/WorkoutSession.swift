import Foundation

public class WorkoutSession: Codable, Identifiable {
    public var id: String
    public var date: Date
    public var exercises: [ExerciseLog]
    public var duration: TimeInterval
    public var notes: String
    public var intensity: String

    public init(date: Date = Date(), exercises: [ExerciseLog] = [], duration: TimeInterval = 0, notes: String = "", intensity: String = "Moderado") {
        self.id = UUID().uuidString
        self.date = date
        self.exercises = exercises
        self.duration = duration
        self.notes = notes
        self.intensity = intensity
    }

    public var totalVolume: Double {
        exercises.reduce(0.0) { $0 + $1.totalVolume }
    }

    public var exerciseCount: Int {
        exercises.count
    }

    public var totalSets: Int {
        exercises.reduce(0) { $0 + $1.totalSets }
    }

    public var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: date)
    }
}
