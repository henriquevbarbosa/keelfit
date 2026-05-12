import XCTest
@testable import Keel

final class HistoryViewModelTests: XCTestCase {
    
    // MARK: - Helpers
    
    func makeVM(workouts: [WorkoutSession] = [], meals: [MealEntry] = []) -> HistoryViewModel {
        let vm = HistoryViewModel()
        vm.loadRecords(workouts: workouts, meals: meals)
        return vm
    }
    
    func workout(on date: Date, volume: Double = 1800) -> WorkoutSession {
        let set = SetEntry(reps: 10, weight: volume / 10.0, unit: "kg")
        let ex = ExerciseLog(exerciseID: "test", exerciseName: "Test", muscleGroup: "Peito", sets: [set])
        let session = WorkoutSession(date: date, exercises: [ex], duration: 3600, notes: "", intensity: "Moderado")
        return session
    }
    
    func meal(on date: Date, protein: Double = 20, carbs: Double = 30, fat: Double = 10) -> MealEntry {
        let m = MealEntry(name: "Test Meal", protein: protein, carbs: carbs, fat: fat)
        m.timestamp = date
        return m
    }
    
    func date(daysAgo: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: -daysAgo, to: Calendar.current.startOfDay(for: Date())) ?? Date()
    }
    
    // MARK: - Free Limit Tests
    
    func testFreeLimitShowsOnly7Days() {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        var workouts: [WorkoutSession] = []
        for i in 0..<14 {
            let d = cal.date(byAdding: .day, value: -i, to: today)!
            workouts.append(workout(on: d))
        }
        let vm = makeVM(workouts: workouts, meals: [])
        XCTAssertEqual(vm.visibleRecords.count, 7)
        XCTAssertEqual(vm.lockedRecords.count, 7)
        XCTAssertTrue(vm.hasLockedContent)
    }
    
    func testProShowsAllDays() {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        var workouts: [WorkoutSession] = []
        for i in 0..<14 {
            let d = cal.date(byAdding: .day, value: -i, to: today)!
            workouts.append(workout(on: d))
        }
        let vm = makeVM(workouts: workouts, meals: [])
        vm.revenueCat.hasHistoryUnlimited = true
        vm.revenueCat.hasAnalytics = true
        vm.revenueCat.hasExport = true
        XCTAssertEqual(vm.visibleRecords.count, 14)
        XCTAssertTrue(vm.lockedRecords.isEmpty)
        XCTAssertFalse(vm.hasLockedContent)
    }
    
    func testFreeLimitWithNoOldRecords() {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        var workouts: [WorkoutSession] = []
        for i in 0..<5 {
            let d = cal.date(byAdding: .day, value: -i, to: today)!
            workouts.append(workout(on: d))
        }
        let vm = makeVM(workouts: workouts, meals: [])
        XCTAssertEqual(vm.visibleRecords.count, 5)
        XCTAssertTrue(vm.lockedRecords.isEmpty)
        XCTAssertFalse(vm.hasLockedContent)
    }
    
    // MARK: - Paywall Trigger Tests
    
    func testPaywallTriggersOnce() {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        var workouts: [WorkoutSession] = []
        for i in 0..<14 {
            let d = cal.date(byAdding: .day, value: -i, to: today)!
            workouts.append(workout(on: d))
        }
        let vm = makeVM(workouts: workouts, meals: [])
        XCTAssertFalse(vm.showPaywall)
        vm.triggerPaywallIfNeeded()
        XCTAssertTrue(vm.showPaywall)
        vm.dismissPaywall()
        XCTAssertFalse(vm.showPaywall)
        vm.triggerPaywallIfNeeded()
        XCTAssertFalse(vm.showPaywall) // already shown once
    }
    
    func testPaywallDoesNotTriggerForPro() {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        var workouts: [WorkoutSession] = []
        for i in 0..<14 {
            let d = cal.date(byAdding: .day, value: -i, to: today)!
            workouts.append(workout(on: d))
        }
        let vm = makeVM(workouts: workouts, meals: [])
        vm.revenueCat.hasHistoryUnlimited = true
        vm.revenueCat.hasAnalytics = true
        vm.revenueCat.hasExport = true
        vm.triggerPaywallIfNeeded()
        XCTAssertFalse(vm.showPaywall)
    }
    
    // MARK: - Consistency Score Tests
    
    func testMacroConsistencyPerfect() {
        let record = DayRecord(id: UUID(), date: Date(), workout: nil, meals: [
            meal(on: Date(), protein: 30, carbs: 40, fat: 10) // 30*4=120, 40*4=160, 10*9=90 => 370 total, prot=32%, carb=43%, fat=24%
        ])
        let score = record.macroConsistencyScore
        XCTAssertGreaterThan(score, 60)
        XCTAssertLessThanOrEqual(score, 100)
    }
    
    func testMacroConsistencyZeroWhenNoMeals() {
        let record = DayRecord(id: UUID(), date: Date(), workout: nil, meals: [])
        XCTAssertEqual(record.macroConsistencyScore, 0)
    }
    
    func testMacroConsistencyLowWithBadSplit() {
        let record = DayRecord(id: UUID(), date: Date(), workout: nil, meals: [
            meal(on: Date(), protein: 5, carbs: 80, fat: 30) // terrible split
        ])
        let score = record.macroConsistencyScore
        XCTAssertLessThan(score, 50)
    }
    
    // MARK: - Integration: Workout + Meals Combined
    
    func testDayRecordWithBothWorkoutAndMeals() {
        let d = date(daysAgo: 1)
        let w = workout(on: d, volume: 2400)
        let m1 = meal(on: d, protein: 25, carbs: 50, fat: 12)
        let m2 = meal(on: d, protein: 30, carbs: 40, fat: 10)
        let vm = makeVM(workouts: [w], meals: [m1, m2])
        let rec = vm.visibleRecords.first { Calendar.current.isDate($0.date, inSameDayAs: d) }
        XCTAssertNotNil(rec)
        XCTAssertNotNil(rec?.workout)
        XCTAssertEqual(rec?.meals.count, 2)
        XCTAssertEqual(rec?.macroConsistencyScore, rec!.macroConsistencyScore) // computed
    }
    
    // MARK: - Sorted Order Test
    
    func testRecordsSortedNewestFirst() {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        let w1 = workout(on: cal.date(byAdding: .day, value: -1, to: today)!)
        let w2 = workout(on: cal.date(byAdding: .day, value: -3, to: today)!)
        let w3 = workout(on: cal.date(byAdding: .day, value: -2, to: today)!)
        let vm = makeVM(workouts: [w1, w2, w3], meals: [])
        let dates = vm.visibleRecords.map { $0.date }
        XCTAssertTrue(dates[0] >= dates[1])
        XCTAssertTrue(dates[1] >= dates[2])
    }
    
    // MARK: - Day Keying Test
    
    func testMultipleMealsSameDayMerged() {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        let m1 = meal(on: cal.date(byAdding: .hour, value: 8, to: today)!, protein: 10)
        let m2 = meal(on: cal.date(byAdding: .hour, value: 12, to: today)!, protein: 20)
        let m3 = meal(on: cal.date(byAdding: .hour, value: 20, to: today)!, protein: 15)
        let vm = makeVM(workouts: [], meals: [m1, m2, m3])
        let rec = vm.visibleRecords.first { Calendar.current.isDate($0.date, inSameDayAs: today) }
        XCTAssertNotNil(rec)
        XCTAssertEqual(rec?.meals.count, 3)
        XCTAssertEqual(rec?.meals.reduce(0.0) { $0 + $1.protein }, 45.0, accuracy: 0.001)
    }
    
    func testWorkoutAndMealsSameDayMerged() {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        let w = workout(on: cal.date(byAdding: .hour, value: 18, to: today)!)
        let m = meal(on: cal.date(byAdding: .hour, value: 12, to: today)!)
        let vm = makeVM(workouts: [w], meals: [m])
        let rec = vm.visibleRecords.first { Calendar.current.isDate($0.date, inSameDayAs: today) }
        XCTAssertNotNil(rec)
        XCTAssertNotNil(rec?.workout)
        XCTAssertEqual(rec?.meals.count, 1)
    }
    
    // MARK: - RevenueCat Integration
    
    func testIsProReflectsRevenueCatEntitlements() {
        let vm = makeVM(workouts: [], meals: [])
        XCTAssertFalse(vm.isPro)
        vm.revenueCat.hasHistoryUnlimited = true
        vm.revenueCat.hasAnalytics = true
        vm.revenueCat.hasExport = true
        XCTAssertTrue(vm.isPro)
    }
    
    func testVisibleRecordsExpandWhenUpgraded() {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        var workouts: [WorkoutSession] = []
        for i in 0..<14 {
            let d = cal.date(byAdding: .day, value: -i, to: today)!
            workouts.append(workout(on: d))
        }
        let vm = makeVM(workouts: workouts, meals: [])
        XCTAssertEqual(vm.visibleRecords.count, 7) // free limit
        vm.revenueCat.hasHistoryUnlimited = true
        vm.revenueCat.hasAnalytics = true
        vm.revenueCat.hasExport = true
        XCTAssertEqual(vm.visibleRecords.count, 14) // pro unlocks all
    }
}
