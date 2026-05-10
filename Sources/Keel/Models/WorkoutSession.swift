import Foundation
import SwiftData

@Model
class WorkoutSession {
    var date: Date
    var exercises: [ExerciseLog]
    var duration: TimeInterval
    var notes: String
    var intensity: String // "Leve", "Moderado", "Pesado"
    
    init(date: Date = Date(), exercises: [ExerciseLog] = [], duration: TimeInterval = 0, notes: String = "", intensity: String = "Moderado") {
        self.date = date
        self.exercises = exercises
        self.duration = duration
        self.notes = notes
        self.intensity = intensity
    }
    
    var totalVolume: Double {
        exercises.reduce(0) { $0 + $1.totalVolume }
    }
    
    var exerciseCount: Int {
        exercises.count
    }
    
    var totalSets: Int {
        exercises.reduce(0) { $0 + $1.totalSets }
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: date)
    }
}
