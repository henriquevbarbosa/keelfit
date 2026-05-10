import Foundation
import SwiftData

@Model
class ExerciseLog {
    var exerciseID: String
    var exerciseName: String
    var muscleGroup: String
    var sets: [SetEntry]
    var timestamp: Date
    
    init(exerciseID: String, exerciseName: String, muscleGroup: String, sets: [SetEntry] = []) {
        self.exerciseID = exerciseID
        self.exerciseName = exerciseName
        self.muscleGroup = muscleGroup
        self.sets = sets
        self.timestamp = Date()
    }
    
    var totalVolume: Double {
        sets.reduce(0) { $0 + $1.volume }
    }
    
    var totalSets: Int {
        sets.count
    }
    
    var bestSet: SetEntry? {
        sets.max { $0.volume < $1.volume }
    }
}
