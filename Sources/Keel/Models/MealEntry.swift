import Foundation
import SwiftData

@Model
class MealEntry {
    var name: String
    var protein: Double
    var carbs: Double
    var fat: Double
    var timestamp: Date
    var mealType: String // "Café da manhã", "Almoço", "Jantar", "Lanche"
    
    init(name: String = "", protein: Double = 0, carbs: Double = 0, fat: Double = 0, mealType: String = "Lanche") {
        self.name = name
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
        self.timestamp = Date()
        self.mealType = mealType
    }
    
    var calories: Double {
        (protein * 4) + (carbs * 4) + (fat * 9)
    }
}
