import Foundation

public class MacroTarget: Codable {
    public var protein: Double
    public var carbs: Double
    public var fat: Double
    public var calories: Double
    public var date: Date

    public init(protein: Double = 180, carbs: Double = 250, fat: Double = 70, calories: Double = 2400, date: Date = Date()) {
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
        self.calories = calories
        self.date = date
    }

    public static func calculateTargets(weight: Double, goal: GoalType, activityLevel: ActivityLevel) -> MacroTarget {
        let bmr = 10 * weight + 6.25 * 175 - 5 * 30 + 5
        let multipliers: [ActivityLevel: Double] = [
            .sedentary: 1.2, .light: 1.375, .moderate: 1.55,
            .active: 1.725, .veryActive: 1.9
        ]
        let tdee = bmr * (multipliers[activityLevel] ?? 1.55)

        let calories: Double
        let proteinMultiplier: Double
        let fatPct: Double
        switch goal {
        case .cut:
            calories = tdee - 500
            proteinMultiplier = 2.2
            fatPct = 0.25
        case .maintenance:
            calories = tdee
            proteinMultiplier = 1.8
            fatPct = 0.30
        case .bulk:
            calories = tdee + 300
            proteinMultiplier = 2.0
            fatPct = 0.25
        }

        let protein = weight * proteinMultiplier
        let fat = (calories * fatPct) / 9
        let carbs = (calories - (protein * 4) - (fat * 9)) / 4

        return MacroTarget(protein: protein, carbs: carbs, fat: fat, calories: calories)
    }

    public func formulaBreakdown(goal: GoalType, activityLevel: ActivityLevel) -> String {
        "Meta: \(goal.rawValue) | Nivel: \(activityLevel.rawValue)\nCalorias: \(Int(self.calories)) kcal\nProteina: \(Int(self.protein))g | Carbs: \(Int(self.carbs))g | Gordura: \(Int(self.fat))g"
    }
}

public enum GoalType: String, Codable {
    case cut = "cut"
    case maintenance = "maintenance"
    case bulk = "bulk"
}

public enum ActivityLevel: String, Codable {
    case sedentary = "sedentary"
    case light = "light"
    case moderate = "moderate"
    case active = "active"
    case veryActive = "veryActive"
}
