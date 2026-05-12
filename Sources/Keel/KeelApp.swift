import Foundation
import OSLog
import SwiftUI

/// A logger for the Keel module.
let logger: Logger = Logger(subsystem: "com.henrique.keel", category: "Keel")

/// The shared top-level view for the app, loaded from the platform-specific App delegates below.
///
/// The default implementation merely loads the `ContentView` for the app and logs a message.
public struct KeelRootView: View {
    public init() {
    }

    public var body: some View {
        OnboardingContainer()
            .task {
                logger.info("iOS logs: Xcode console; Android logs: adb logcat or Android Studio")
            }
    }
}

/// Global application delegate functions.
///
/// These functions can update a shared observable object to communicate app state changes to interested views.
public final class KeelAppDelegate: Sendable {
    public static let shared = KeelAppDelegate()

    private init() {
    }

    public func onInit() {
        logger.debug("onInit")
    }

    public func onLaunch() {
        logger.debug("onLaunch")
    }

    public func onResume() {
        logger.debug("onResume")
    }

    public func onPause() {
        logger.debug("onPause")
    }

    public func onStop() {
        logger.debug("onStop")
    }

    public func onDestroy() {
        logger.debug("onDestroy")
    }

    public func onLowMemory() {
        logger.debug("onLowMemory")
    }
}
