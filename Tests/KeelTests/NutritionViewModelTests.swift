import XCTest
@testable import Keel

final class NutritionViewModelTests: XCTestCase {
    
    // MARK: - Calculation Tests
    
    func testTotalProteinCalculation() {
        let vm = NutritionViewModel(meals: [
            MealEntry(name: "Omelete", protein: 24, carbs: 2, fat: 15),
            MealEntry(name: "Frango", protein: 35, carbs: 0, fat: 5)
        ])
        XCTAssertEqual(vm.totalProtein, 59.0, accuracy: 0.001)
    }
    
    func testTotalCarbsCalculation() {
        let vm = NutritionViewModel(meals: [
            MealEntry(name: "Arroz", protein: 4, carbs: 45, fat: 1),
            MealEntry(name: "Batata", protein: 2, carbs: 30, fat: 0)
        ])
        XCTAssertEqual(vm.totalCarbs, 75.0, accuracy: 0.001)
    }
    
    func testTotalFatCalculation() {
        let vm = NutritionViewModel(meals: [
            MealEntry(name: "Abacate", protein: 2, carbs: 9, fat: 15),
            MealEntry(name: "Castanha", protein: 4, carbs: 6, fat: 14)
        ])
        XCTAssertEqual(vm.totalFat, 29.0, accuracy: 0.001)
    }
    
    func testTotalCaloriesCalculation() {
        let vm = NutritionViewModel(meals: [
            MealEntry(name: "Chicken", protein: 30, carbs: 10, fat: 5),
            MealEntry(name: "Rice", protein: 4, carbs: 45, fat: 1)
        ])
        let expected = (34.0 * 4) + (55.0 * 4) + (6.0 * 9)
        XCTAssertEqual(vm.totalCalories, expected, accuracy: 0.001)
    }
    
    func testEmptyMealsZeroTotals() {
        let vm = NutritionViewModel()
        XCTAssertEqual(vm.totalProtein, 0.0, accuracy: 0.001)
        XCTAssertEqual(vm.totalCarbs, 0.0, accuracy: 0.001)
        XCTAssertEqual(vm.totalFat, 0.0, accuracy: 0.001)
        XCTAssertEqual(vm.totalCalories, 0.0, accuracy: 0.001)
    }
    
    // MARK: - Meal Management Tests
    
    func testAddMeal() {
        let vm = NutritionViewModel()
        XCTAssertEqual(vm.meals.count, 0)
        
        vm.addMeal(name: "Peixe", protein: 25, carbs: 0, fat: 8)
        XCTAssertEqual(vm.meals.count, 1)
        XCTAssertEqual(vm.meals[0].name, "Peixe")
        XCTAssertEqual(vm.meals[0].protein, 25.0, accuracy: 0.001)
    }
    
    func testAddMultipleMeals() {
        let vm = NutritionViewModel()
        vm.addMeal(name: "Café", protein: 10, carbs: 20, fat: 5)
        vm.addMeal(name: "Almoço", protein: 30, carbs: 50, fat: 10)
        vm.addMeal(name: "Jantar", protein: 25, carbs: 40, fat: 8)
        
        XCTAssertEqual(vm.meals.count, 3)
        XCTAssertEqual(vm.totalProtein, 65.0, accuracy: 0.001)
    }
    
    func testRemoveMeal() {
        let vm = NutritionViewModel(meals: [
            MealEntry(name: "Café", protein: 10, carbs: 20, fat: 5),
            MealEntry(name: "Almoço", protein: 30, carbs: 50, fat: 10),
            MealEntry(name: "Jantar", protein: 25, carbs: 40, fat: 8)
        ])
        
        vm.removeMeal(at: IndexSet(integer: 1))
        XCTAssertEqual(vm.meals.count, 2)
        XCTAssertEqual(vm.meals[1].name, "Jantar")
        XCTAssertEqual(vm.totalProtein, 35.0, accuracy: 0.001)
    }
    
    func testRemoveAllMeals() {
        let vm = NutritionViewModel(meals: [
            MealEntry(name: "Snack", protein: 10, carbs: 15, fat: 3)
        ])
        
        vm.removeMeal(at: IndexSet(integer: 0))
        XCTAssertEqual(vm.meals.count, 0)
        XCTAssertEqual(vm.totalProtein, 0.0, accuracy: 0.001)
    }
    
    // MARK: - Progress Tests
    
    func testProgressPercentUnderTarget() {
        let vm = NutritionViewModel()
        let pct = vm.progressPercent(current: 90.0, target: 180.0)
        XCTAssertEqual(pct, 0.5, accuracy: 0.001)
    }
    
    func testProgressPercentAtTarget() {
        let vm = NutritionViewModel()
        let pct = vm.progressPercent(current: 180.0, target: 180.0)
        XCTAssertEqual(pct, 1.0, accuracy: 0.001)
    }
    
    func testProgressPercentOverTarget() {
        let vm = NutritionViewModel()
        let pct = vm.progressPercent(current: 250.0, target: 180.0)
        XCTAssertEqual(pct, 1.0, accuracy: 0.001) // Capped at 1.0
    }
    
    func testProgressPercentZeroTarget() {
        let vm = NutritionViewModel()
        let pct = vm.progressPercent(current: 100.0, target: 0.0)
        XCTAssertEqual(pct, 0.0, accuracy: 0.001)
    }
    
    // MARK: - Formula Breakdown Tests
    
    func testFormulaBreakdownContainsBMR() {
        let target = MacroTarget.calculateTargets(weight: 70.0, height: 175.0, age: 30, goal: .maintenance, activityLevel: .moderate)
        let vm = NutritionViewModel(target: target)
        let profile = UserProfile(weight: 70, height: 175, age: 30, goal: "maintenance", activityLevel: "moderate")
        
        let breakdown = vm.formulaBreakdown(profile: profile)
        XCTAssertTrue(breakdown.contains("BMR"), "Formula should mention BMR")
        XCTAssertTrue(breakdown.contains("TDEE"), "Formula should mention TDEE")
    }
    
    func testFormulaBreakdownContainsMacros() {
        let target = MacroTarget.calculateTargets(weight: 70.0, height: 175.0, age: 30, goal: .cut, activityLevel: .active)
        let vm = NutritionViewModel(target: target)
        let profile = UserProfile(weight: 70, height: 175, age: 30, goal: "cut", activityLevel: "active")
        
        let breakdown = vm.formulaBreakdown(profile: profile)
        XCTAssertTrue(breakdown.contains("P ="), "Formula should show protein")
        XCTAssertTrue(breakdown.contains("C ="), "Formula should show carbs")
        XCTAssertTrue(breakdown.contains("G ="), "Formula should show fat")
    }
    
    // MARK: - Integration Tests
    
    func testDailyMacroTrackingScenario() {
        let target = MacroTarget.calculateTargets(weight: 70.0, height: 175.0, age: 30, goal: .maintenance, activityLevel: .moderate)
        let vm = NutritionViewModel(target: target)
        
        // Breakfast
        vm.addMeal(name: "Ovos + Torrada", protein: 20, carbs: 30, fat: 12)
        
        // Lunch
        vm.addMeal(name: "Arroz + Feijão + Frango", protein: 40, carbs: 70, fat: 15)
        
        // Snack
        vm.addMeal(name: "Whey + Banana", protein: 25, carbs: 30, fat: 2)
        
        // Dinner
        vm.addMeal(name: "Salmão + Salada", protein: 30, carbs: 10, fat: 20)
        
        XCTAssertEqual(vm.totalProtein, 115.0, accuracy: 0.001)
        XCTAssertTrue(vm.totalProtein <= target.protein || vm.totalProtein > 0)
        XCTAssertTrue(vm.totalCalories > 0)
        XCTAssertEqual(vm.meals.count, 4)
        
        // Remove snack
        vm.removeMeal(at: IndexSet(integer: 2))
        XCTAssertEqual(vm.meals.count, 3)
        XCTAssertEqual(vm.totalProtein, 90.0, accuracy: 0.001)
    }
}
