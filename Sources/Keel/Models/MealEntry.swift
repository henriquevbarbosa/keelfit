import Foundation

public class MealEntry: Codable, Identifiable {
    public var id: String
    public var name: String
    public var protein: Double
    public var carbs: Double
    public var fat: Double
    public var timestamp: Date
    public var mealType: String

    public init(name: String = "", protein: Double = 0, carbs: Double = 0, fat: Double = 0, mealType: String = "Lanche") {
        self.id = UUID().uuidString
        self.name = name
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
        self.timestamp = Date()
        self.mealType = mealType
    }

    public var calories: Double {
        (protein * 4) + (carbs * 4) + (fat * 9)
    }
}
