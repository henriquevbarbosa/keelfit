import Foundation

// MARK: - Analytics Service
// Only sends anonymous events; macros/workout data never leaves device.

#if os(iOS)
import UIKit
#endif

class AnalyticsService {
    static let shared = AnalyticsService()
    
    private var isEnabled = true
    
    func configure() {
        // TODO: initialize PostHog or Mixpanel here
        isEnabled = true
    }
    
    func track(_ event: AnalyticsEvent, properties: [String: Any] = [:]) {
        guard isEnabled else { return }
        // Placeholder: replace with actual SDK call
        print("[Analytics] \(event.rawValue) — \(properties)")
    }
    
    func identify(userId: String, traits: [String: Any] = [:]) {
        guard isEnabled else { return }
        print("[Analytics] identify \(userId)")
    }
    
    func reset() {
        guard isEnabled else { return }
        print("[Analytics] reset")
    }
}

enum AnalyticsEvent: String {
    case workoutLogged = "workout_logged"
    case mealLogged = "meal_logged"
    case paywallSeen = "paywall_seen"
    case paywallConverted = "paywall_converted"
    case d7Open = "d7_open"
    case onboardingCompleted = "onboarding_completed"
    case setAdded = "set_added"
    case macroTargetUpdated = "macro_target_updated"
}
