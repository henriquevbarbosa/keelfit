import XCTest
@testable import Keel

final class KeelTests: XCTestCase {
    
    // MARK: - Model Tests
    
    func testSetEntryVolumeCalculation() {
        let entry = SetEntry(reps: 10, weight: 60.0, unit: "kg")
        XCTAssertEqual(entry.volume, 600.0, accuracy: 0.001)
    }
    
    func testMealEntryCaloriesCalculation() {
        let meal = MealEntry(name: "Chicken", protein: 30, carbs: 10, fat: 5)
        let expected = (30.0 * 4) + (10.0 * 4) + (5.0 * 9)
        XCTAssertEqual(meal.calories, expected, accuracy: 0.001)
    }
    
    func testMacroTargetCalculationForCut() {
        let target = MacroTarget.calculateTargets(weight: 70.0, goal: .cut, activityLevel: .moderate)
        XCTAssertTrue(target.calories > 0)
        XCTAssertTrue(target.protein > 0)
        XCTAssertTrue(target.carbs > 0)
        XCTAssertTrue(target.fat > 0)
    }
    
    func testUserProfileGoalEnum() {
        let profile = UserProfile(weight: 70, height: 175, age: 30, goal: "bulk", activityLevel: "active")
        XCTAssertEqual(profile.goalEnum, .bulk)
        XCTAssertEqual(profile.activityLevelEnum, .active)
    }
    
    func testWorkoutSessionTotalVolume() {
        let set1 = SetEntry(reps: 10, weight: 60.0)
        let set2 = SetEntry(reps: 8, weight: 65.0)
        let exercise = ExerciseLog(exerciseID: "1", exerciseName: "Squat", muscleGroup: "Legs", sets: [set1, set2])
        let session = WorkoutSession(exercises: [exercise])
        XCTAssertEqual(session.totalVolume, 600.0 + 520.0, accuracy: 0.001)
    }
    
    // MARK: - Service Tests
    
    func testPersistenceServiceRoundTrip() {
        let service = PersistenceService.shared
        let profile = UserProfile(weight: 75.0, height: 180, age: 25, goal: "maintenance", activityLevel: "moderate")
        service.save(profile, key: "test_profile")
        let loaded: UserProfile? = service.load(UserProfile.self, key: "test_profile")
        XCTAssertNotNil(loaded)
        XCTAssertEqual(loaded?.weight, 75.0, accuracy: 0.001)
        service.remove(key: "test_profile")
    }
    
    func testAnalyticsServiceTrackDoesNotCrash() {
        AnalyticsService.shared.track(.workoutLogged)
        // Pass if no crash
        XCTAssertTrue(true)
    }
}
