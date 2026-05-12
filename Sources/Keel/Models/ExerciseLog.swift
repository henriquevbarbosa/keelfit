import Foundation

public class ExerciseLog: Codable, Identifiable {
    public var id: String
    public var exerciseID: String
    public var exerciseName: String
    public var muscleGroup: String
    public var sets: [SetEntry]

    public init(exerciseID: String, exerciseName: String, muscleGroup: String, sets: [SetEntry] = []) {
        self.id = UUID().uuidString
        self.exerciseID = exerciseID
        self.exerciseName = exerciseName
        self.muscleGroup = muscleGroup
        self.sets = sets
    }

    public var totalVolume: Double {
        sets.reduce(0.0) { $0 + $1.volume }
    }

    public var totalSets: Int {
        sets.count
    }
}
