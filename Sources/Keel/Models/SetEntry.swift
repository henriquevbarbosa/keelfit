import Foundation
import SwiftData

@Model
class SetEntry {
    var reps: Int
    var weight: Double
    var unit: String // "kg" or "lb"
    var timestamp: Date
    var isCompleted: Bool
    
    init(reps: Int = 0, weight: Double = 0.0, unit: String = "kg", isCompleted: Bool = true) {
        self.reps = reps
        self.weight = weight
        self.unit = unit
        self.timestamp = Date()
        self.isCompleted = isCompleted
    }
    
    var volume: Double {
        Double(reps) * weight
    }
}
