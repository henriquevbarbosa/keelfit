import SwiftUI

@Observable
public class WorkoutViewModel {
    public var selectedGroup: MuscleGroup = .peito
    public var activeExercises: [ActiveExercise] = []
    public var startTime: Date = Date()

    public var totalVolume: Double {
        activeExercises.reduce(0.0) { $0 + $1.totalVolume }
    }
    public var totalSets: Int {
        activeExercises.reduce(0) { $0 + $1.totalSets }
    }
    public var intensity: WorkoutIntensity {
        let vol = totalVolume
        if vol < 2000 { return .light }
        if vol < 5000 { return .moderate }
        return .heavy
    }

    public init() {
        loadExercises(for: .peito)
    }

    public func loadExercises(for group: MuscleGroup) {
        activeExercises = group.exercises.map {
            ActiveExercise(definition: $0, muscleGroup: group)
        }
    }

    public func addSet(to exerciseID: String) {
        guard let index = activeExercises.firstIndex(where: { $0.id == exerciseID }) else { return }
        let last = activeExercises[index].sets.last
        activeExercises[index].sets.append(ActiveSet(
            repsText: last?.repsText ?? "",
            weightText: last?.weightText ?? ""
        ))
    }

    public func finishWorkout() -> WorkoutSession {
        let exercises = activeExercises.map { ex in
            let sets = ex.sets.compactMap { s -> SetEntry? in
                guard let w = Double(s.weightText), w > 0 else { return nil }
                return SetEntry(reps: s.reps, weight: w)
            }
            return ExerciseLog(exerciseID: ex.definition.id.uuidString, exerciseName: ex.definition.name, muscleGroup: ex.muscleGroup.rawValue, sets: sets)
        }
        return WorkoutSession(date: startTime, exercises: exercises, intensity: intensity.rawValue)
    }
}

// MARK: - Active Models
public struct ActiveSet: Identifiable {
    public let id = UUID().uuidString
    public var repsText: String = ""
    public var weightText: String = ""
    public var reps: Int { Int(repsText) ?? 0 }
    public var weight: Double { Double(weightText) ?? 0.0 }
    public var volume: Double { Double(reps) * weight }
}

public struct ActiveExercise: Identifiable {
    public let id = UUID().uuidString
    public let definition: ExerciseDefinition
    public let muscleGroup: MuscleGroup
    public var sets: [ActiveSet]

    public init(definition: ExerciseDefinition, muscleGroup: MuscleGroup) {
        self.definition = definition
        self.muscleGroup = muscleGroup
        self.sets = (0..<definition.defaultSets).map { _ in
            ActiveSet(repsText: String(definition.defaultReps), weightText: definition.defaultWeight.map { "\($0)" } ?? "")
        }
    }

    public var totalVolume: Double { sets.reduce(0.0) { $0 + $1.volume } }
    public var totalSets: Int { sets.count }
}
