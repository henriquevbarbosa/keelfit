import Foundation

public enum MuscleGroup: String, CaseIterable, Identifiable {
    case peito = "Peito"
    case costas = "Costas"
    case pernas = "Pernas"
    case ombros = "Ombros"

    public var id: String { rawValue }

    public var exercises: [ExerciseDefinition] {
        ExerciseCatalog.exercises(for: self)
    }
}

public struct ExerciseDefinition: Identifiable, Hashable {
    public let id = UUID()
    public let name: String
    public let defaultSets: Int
    public let defaultReps: Int
    public let defaultWeight: Double?
}

enum ExerciseCatalog {
    static let allExercises: [MuscleGroup: [ExerciseDefinition]] = [
        .peito: [
            ExerciseDefinition(name: "Supino Reto", defaultSets: 4, defaultReps: 10, defaultWeight: 60),
            ExerciseDefinition(name: "Supino Inclinado", defaultSets: 4, defaultReps: 10, defaultWeight: 50),
            ExerciseDefinition(name: "Crucifixo", defaultSets: 3, defaultReps: 12, defaultWeight: 12),
            ExerciseDefinition(name: "Fly Maquina", defaultSets: 3, defaultReps: 12, defaultWeight: 25),
            ExerciseDefinition(name: "Pullover", defaultSets: 3, defaultReps: 12, defaultWeight: 20),
            ExerciseDefinition(name: "Flexao", defaultSets: 3, defaultReps: 15, defaultWeight: nil),
            ExerciseDefinition(name: "Supino Declinado", defaultSets: 3, defaultReps: 10, defaultWeight: 50),
            ExerciseDefinition(name: "Apoio", defaultSets: 3, defaultReps: 12, defaultWeight: 0),
        ],
        .costas: [
            ExerciseDefinition(name: "Puxada Frente", defaultSets: 4, defaultReps: 10, defaultWeight: 50),
            ExerciseDefinition(name: "Remada Curvada", defaultSets: 4, defaultReps: 10, defaultWeight: 60),
            ExerciseDefinition(name: "Remada Unilateral", defaultSets: 4, defaultReps: 10, defaultWeight: 25),
            ExerciseDefinition(name: "Pulldown", defaultSets: 3, defaultReps: 12, defaultWeight: 45),
            ExerciseDefinition(name: "Levantamento Terra", defaultSets: 4, defaultReps: 8, defaultWeight: 100),
            ExerciseDefinition(name: "Remada Cavalinho", defaultSets: 3, defaultReps: 10, defaultWeight: 40),
            ExerciseDefinition(name: "Face Pull", defaultSets: 3, defaultReps: 15, defaultWeight: 15),
            ExerciseDefinition(name: "Barra Fixa", defaultSets: 3, defaultReps: 8, defaultWeight: nil),
        ],
        .pernas: [
            ExerciseDefinition(name: "Agachamento", defaultSets: 4, defaultReps: 10, defaultWeight: 80),
            ExerciseDefinition(name: "Leg Press", defaultSets: 4, defaultReps: 12, defaultWeight: 150),
            ExerciseDefinition(name: "Extensora", defaultSets: 3, defaultReps: 12, defaultWeight: 50),
            ExerciseDefinition(name: "Flexora", defaultSets: 3, defaultReps: 12, defaultWeight: 45),
            ExerciseDefinition(name: "Stiff", defaultSets: 4, defaultReps: 10, defaultWeight: 60),
            ExerciseDefinition(name: "Passada", defaultSets: 3, defaultReps: 12, defaultWeight: 20),
            ExerciseDefinition(name: "Panturrilha", defaultSets: 4, defaultReps: 15, defaultWeight: 40),
            ExerciseDefinition(name: "Agachamento Bulgaro", defaultSets: 3, defaultReps: 10, defaultWeight: 20),
        ],
        .ombros: [
            ExerciseDefinition(name: "Desenvolvimento", defaultSets: 4, defaultReps: 10, defaultWeight: 40),
            ExerciseDefinition(name: "Elevacao Lateral", defaultSets: 4, defaultReps: 12, defaultWeight: 12),
            ExerciseDefinition(name: "Elevacao Frontal", defaultSets: 3, defaultReps: 12, defaultWeight: 15),
            ExerciseDefinition(name: "Arnold Press", defaultSets: 3, defaultReps: 10, defaultWeight: 20),
            ExerciseDefinition(name: "Encolhimento", defaultSets: 3, defaultReps: 12, defaultWeight: 60),
            ExerciseDefinition(name: "Desenvolvimento Maquina", defaultSets: 3, defaultReps: 10, defaultWeight: 35),
            ExerciseDefinition(name: "Elevacao Posterior", defaultSets: 3, defaultReps: 15, defaultWeight: 10),
            ExerciseDefinition(name: "Y-Raise", defaultSets: 3, defaultReps: 15, defaultWeight: 5),
        ],
    ]

    static func exercises(for group: MuscleGroup) -> [ExerciseDefinition] {
        allExercises[group] ?? []
    }
}
