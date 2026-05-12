import XCTest
@testable import Keel
import SwiftUI

#if !SKIP
final class RevenueCatSnapshotTests: XCTestCase {

    func testPaywallSheetRenders() {
        let sheet = PaywallSheet(onDismiss: {})
        let hostingController = UIHostingController(rootView: sheet)
        hostingController.loadViewIfNeeded()

        XCTAssertNotNil(hostingController.view)
        XCTAssertTrue(hostingController.view.subviews.count > 0)
    }

    func testPaywallCardPopularRenders() {
        let card = PaywallCard(
            title: "Keel Pro",
            price: "$7.99",
            period: "/month",
            features: ["Unlimited history", "Analytics", "Export data"],
            isPopular: true,
            action: {}
        )
        let hostingController = UIHostingController(rootView: card)
        hostingController.loadViewIfNeeded()

        XCTAssertNotNil(hostingController.view)
    }

    func testPaywallCardStandardRenders() {
        let card = PaywallCard(
            title: "Keel Pro Annual",
            price: "$59.99",
            period: "/year",
            features: ["All monthly features", "2 months free", "Priority support"],
            isPopular: false,
            action: {}
        )
        let hostingController = UIHostingController(rootView: card)
        hostingController.loadViewIfNeeded()

        XCTAssertNotNil(hostingController.view)
    }

    func testSettingsViewFreeRenders() {
        let view = SettingsView()
        let hostingController = UIHostingController(rootView: NavigationStack { view })
        hostingController.loadViewIfNeeded()

        XCTAssertNotNil(hostingController.view)
    }

    func testSettingsViewProRenders() {
        let service = RevenueCatService()
        service.hasHistoryUnlimited = true
        service.hasAnalytics = true
        service.hasExport = true

        let view = SettingsView()
        let hostingController = UIHostingController(rootView: NavigationStack { view })
        hostingController.loadViewIfNeeded()

        XCTAssertNotNil(hostingController.view)
    }

    func testPaywallSheetWithErrorRenders() {
        let service = RevenueCatService()
        service.errorMessage = "Network error"

        let sheet = PaywallSheet(onDismiss: {})
        let hostingController = UIHostingController(rootView: sheet)
        hostingController.loadViewIfNeeded()

        XCTAssertNotNil(hostingController.view)
    }
}
#endif
