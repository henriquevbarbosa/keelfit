import Foundation

public class UserProfile: Codable {
    public var weight: Double
    public var height: Double
    public var age: Int
    public var goal: String
    public var activityLevel: String

    public init(weight: Double = 70.0, height: Double = 175.0, age: Int = 30, goal: String = "maintenance", activityLevel: String = "moderate") {
        self.weight = weight
        self.height = height
        self.age = age
        self.goal = goal
        self.activityLevel = activityLevel
    }

    public var goalEnum: GoalType {
        GoalType(rawValue: goal) ?? .maintenance
    }

    public var activityLevelEnum: ActivityLevel {
        ActivityLevel(rawValue: activityLevel) ?? .moderate
    }
}
