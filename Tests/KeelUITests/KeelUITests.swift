import XCTest
import SwiftUI
@testable import Keel

final class KeelUITests: XCTestCase {
    
    func testOnboardingViewExists() {
        let view = OnboardingView()
        XCTAssertNotNil(view)
    }
    
    func testPrimaryButtonExists() {
        let button = PrimaryButton(title: "Test", action: {})
        XCTAssertNotNil(button)
    }
    
    func testSecondaryButtonExists() {
        let button = SecondaryButton(title: "Test", action: {})
        XCTAssertNotNil(button)
    }
    
    func testMacroProgressBarExists() {
        let bar = MacroProgressBar(label: "Protein", current: 120, target: 180, color: .red)
        XCTAssertNotNil(bar)
    }
    
    func testWorkoutSetRowExists() {
        struct TestView: View {
            @State var reps = "10"
            @State var weight = "60.0"
            var body: some View {
                WorkoutSetRow(setNumber: 1, repsText: $reps, weightText: $weight, onDelete: {})
            }
        }
        let view = TestView()
        XCTAssertNotNil(view)
    }
    
    func testWorkoutIntensityBadgeExists() {
        let badge = WorkoutIntensityBadge(intensity: .moderate)
        XCTAssertNotNil(badge)
    }
    
    func testPaywallCardExists() {
        let card = PaywallCard(
            title: "Pro",
            price: "R$ 39,90",
            period: "/mês",
            features: ["A", "B"],
            isPopular: true,
            action: {}
        )
        XCTAssertNotNil(card)
    }
    
    func testScreenViewsExist() {
        XCTAssertNotNil(HomeView())
        XCTAssertNotNil(WorkoutView())
        XCTAssertNotNil(NutritionView())
        XCTAssertNotNil(SettingsView())
    }
}
