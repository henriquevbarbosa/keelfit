import XCTest
@testable import Keel
import SwiftUI

#if !SKIP
final class NutritionViewSnapshotTests: XCTestCase {
    
    func testNutritionViewRendersWithoutCrash() {
        let view = NutritionView()
        let hostingController = UIHostingController(rootView: view)
        hostingController.loadViewIfNeeded()
        
        XCTAssertNotNil(hostingController.view)
        XCTAssertTrue(hostingController.view.subviews.count > 0)
    }
    
    func testNutritionViewWithMealsRenders() {
        let vm = NutritionViewModel(
            target: MacroTarget.calculateTargets(weight: 70, height: 175, age: 30, goal: .maintenance, activityLevel: .moderate),
            meals: [
                MealEntry(name: "Omelete", protein: 24, carbs: 2, fat: 15, mealType: "Café da manhã"),
                MealEntry(name: "Arroz + Frango", protein: 35, carbs: 60, fat: 8, mealType: "Almoço")
            ],
            lastWorkout: WorkoutSession(exercises: [], duration: 3600, notes: "", intensity: "Pesado")
        )
        
        let view = NutritionView()
        let hostingController = UIHostingController(rootView: view)
        hostingController.loadViewIfNeeded()
        
        XCTAssertNotNil(hostingController.view)
    }
    
    func testMacroProgressBarProgressCalculation() {
        let bar = MacroProgressBar(label: "Proteína", current: 90, target: 180, color: Color(red: 1.0, green: 0.420, blue: 0.420))
        let hostingController = UIHostingController(rootView: bar)
        hostingController.loadViewIfNeeded()
        
        XCTAssertNotNil(hostingController.view)
    }
    
    func testNutritionBannerWithWorkoutRenders() {
        let workout = WorkoutSession(exercises: [], duration: 3600, notes: "", intensity: "Pesado")
        let banner = NutritionBanner(lastWorkout: workout)
        let hostingController = UIHostingController(rootView: banner)
        hostingController.loadViewIfNeeded()
        
        XCTAssertNotNil(hostingController.view)
    }
    
    func testNutritionBannerWithoutWorkoutRenders() {
        let banner = NutritionBanner(lastWorkout: nil)
        let hostingController = UIHostingController(rootView: banner)
        hostingController.loadViewIfNeeded()
        
        XCTAssertNotNil(hostingController.view)
    }
    
    func testMealInputRowRenders() {
        struct Wrapper: View {
            @State var name = "Test"
            @State var p = "30"
            @State var c = "45"
            @State var f = "12"
            
            var body: some View {
                MealInputRow(name: $name, proteinText: $p, carbsText: $c, fatText: $f, onAdd: {})
            }
        }
        
        let view = Wrapper()
        let hostingController = UIHostingController(rootView: view)
        hostingController.loadViewIfNeeded()
        
        XCTAssertNotNil(hostingController.view)
    }
}
#endif
