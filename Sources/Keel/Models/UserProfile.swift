import Foundation
import SwiftData

@Model
class UserProfile {
    var weight: Double
    var height: Double
    var age: Int
    var goal: String
    var activityLevel: String
    var createdAt: Date
    var updatedAt: Date
    
    init(weight: Double = 70.0, height: Double = 175.0, age: Int = 30, goal: String = "maintenance", activityLevel: String = "moderate") {
        self.weight = weight
        self.height = height
        self.age = age
        self.goal = goal
        self.activityLevel = activityLevel
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    var goalEnum: GoalType {
        GoalType(rawValue: goal) ?? .maintenance
    }
    
    var activityLevelEnum: ActivityLevel {
        ActivityLevel(rawValue: activityLevel) ?? .moderate
    }
}
