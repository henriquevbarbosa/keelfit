import XCTest
@testable import Keel
import SwiftUI

#if !SKIP
final class HistoryViewSnapshotTests: XCTestCase {
    
    func testHistoryViewRendersWithoutCrash() {
        let view = HistoryView()
        let hostingController = UIHostingController(rootView: view)
        hostingController.loadViewIfNeeded()
        
        XCTAssertNotNil(hostingController.view)
        XCTAssertTrue(hostingController.view.subviews.count > 0)
    }
    
    func testRecordCardExpandedRenders() {
        let record = DayRecord(
            id: UUID(),
            date: Date(),
            workout: WorkoutSession(
                exercises: [
                    ExerciseLog(exerciseID: "supino", exerciseName: "Supino Reto", muscleGroup: "Peito", sets: [
                        SetEntry(reps: 10, weight: 60.0, unit: "kg"),
                        SetEntry(reps: 8, weight: 65.0, unit: "kg")
                    ])
                ],
                duration: 3600,
                notes: "",
                intensity: "Pesado"
            ),
            meals: [
                MealEntry(name: "Ovos", protein: 20, carbs: 5, fat: 12),
                MealEntry(name: "Arroz + Frango", protein: 30, carbs: 50, fat: 8)
            ]
        )
        let card = RecordCard(record: record, isExpanded: true, onTap: {})
        let hostingController = UIHostingController(rootView: card)
        hostingController.loadViewIfNeeded()
        
        XCTAssertNotNil(hostingController.view)
    }
    
    func testRecordCardCollapsedRenders() {
        let record = DayRecord(
            id: UUID(),
            date: Date(),
            workout: nil,
            meals: []
        )
        let card = RecordCard(record: record, isExpanded: false, onTap: {})
        let hostingController = UIHostingController(rootView: card)
        hostingController.loadViewIfNeeded()
        
        XCTAssertNotNil(hostingController.view)
    }
    
    func testPaywallSheetRenders() {
        let sheet = PaywallSheet(onDismiss: {})
        let hostingController = UIHostingController(rootView: sheet)
        hostingController.loadViewIfNeeded()
        
        XCTAssertNotNil(hostingController.view)
    }
    
    func testRecordCardWithWorkoutOnlyRenders() {
        let record = DayRecord(
            id: UUID(),
            date: Date(),
            workout: WorkoutSession(
                exercises: [
                    ExerciseLog(exerciseID: "agachamento", exerciseName: "Agachamento", muscleGroup: "Pernas", sets: [
                        SetEntry(reps: 12, weight: 100.0, unit: "kg")
                    ])
                ],
                duration: 2700,
                notes: "",
                intensity: "Moderado"
            ),
            meals: []
        )
        let card = RecordCard(record: record, isExpanded: true, onTap: {})
        let hostingController = UIHostingController(rootView: card)
        hostingController.loadViewIfNeeded()
        
        XCTAssertNotNil(hostingController.view)
    }
    
    func testRecordCardWithMealsOnlyRenders() {
        let record = DayRecord(
            id: UUID(),
            date: Date(),
            workout: nil,
            meals: [
                MealEntry(name: "Café da manhã", protein: 25, carbs: 40, fat: 10),
                MealEntry(name: "Almoço", protein: 35, carbs: 60, fat: 15),
                MealEntry(name: "Jantar", protein: 20, carbs: 30, fat: 8)
            ]
        )
        let card = RecordCard(record: record, isExpanded: true, onTap: {})
        let hostingController = UIHostingController(rootView: card)
        hostingController.loadViewIfNeeded()
        
        XCTAssertNotNil(hostingController.view)
    }
    
    func testSettingsViewRenders() {
        let view = SettingsView()
        let hostingController = UIHostingController(rootView: view)
        hostingController.loadViewIfNeeded()
        
        XCTAssertNotNil(hostingController.view)
    }
}
#endif
