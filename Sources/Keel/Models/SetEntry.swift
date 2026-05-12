import Foundation

public class SetEntry: Codable, Identifiable {
    public var id: String
    public var reps: Int
    public var weight: Double
    public var timestamp: Date

    public init(reps: Int = 0, weight: Double = 0.0) {
        self.id = UUID().uuidString
        self.reps = reps
        self.weight = weight
        self.timestamp = Date()
    }

    public var volume: Double {
        Double(reps) * weight
    }
}
