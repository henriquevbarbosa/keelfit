import SwiftUI

@Observable
public class NutritionViewModel {
    public var target: MacroTarget
    public var meals: [MealEntry]
    public var lastWorkout: WorkoutSession?

    public var totalProtein: Double { meals.reduce(0.0) { $0 + $1.protein } }
    public var totalCarbs: Double { meals.reduce(0.0) { $0 + $1.carbs } }
    public var totalFat: Double { meals.reduce(0.0) { $0 + $1.fat } }
    public var totalCalories: Double { meals.reduce(0.0) { $0 + $1.calories } }

    public init(target: MacroTarget = MacroTarget(), meals: [MealEntry] = [], lastWorkout: WorkoutSession? = nil) {
        self.target = target
        self.meals = meals
        self.lastWorkout = lastWorkout
    }

    public func addMeal(name: String, protein: Double, carbs: Double, fat: Double) {
        let meal = MealEntry(name: name, protein: protein, carbs: carbs, fat: fat)
        meals.append(meal)
    }

    public func removeMeal(meal: MealEntry) {
        meals.removeAll { $0.id == meal.id }
    }

    public func formulaBreakdown(profile: UserProfile) -> String {
        target.formulaBreakdown(goal: profile.goalEnum, activityLevel: profile.activityLevelEnum)
    }

    public func progressPercent(current: Double, target: Double) -> Double {
        guard target > 0 else { return 0 }
        return min(current / target, 1.0)
    }
}
