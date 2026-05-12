import XCTest
@testable import Keel

final class RevenueCatServiceTests: XCTestCase {
    
    // MARK: - Singleton
    
    func testSharedInstanceExists() {
        let service = RevenueCatService.shared
        XCTAssertNotNil(service)
    }
    
    // MARK: - Initial State
    
    func testInitialStateIsFree() {
        let service = RevenueCatService.shared
        XCTAssertFalse(service.isPro)
        XCTAssertFalse(service.hasHistoryUnlimited)
        XCTAssertFalse(service.hasAnalytics)
        XCTAssertFalse(service.hasExport)
    }
    
    // MARK: - Offerings Stub
    
    func testStubOfferingsAvailable() {
        let service = RevenueCatService.shared
        // In Skip/Android stub mode, offerings are pre-populated
        XCTAssertFalse(service.offerings.isEmpty)
        XCTAssertEqual(service.offerings.count, 2)
    }
    
    func testStubOfferingsHaveCorrectPrices() {
        let service = RevenueCatService.shared
        let monthly = service.offerings.first { $0.identifier == "keel_pro_monthly" }
        let yearly = service.offerings.first { $0.identifier == "keel_pro_yearly" }
        
        XCTAssertNotNil(monthly)
        XCTAssertNotNil(yearly)
        XCTAssertEqual(monthly?.price, "$7.99")
        XCTAssertEqual(yearly?.price, "$59.99")
    }
    
    func testStubOfferingsHaveFeatures() {
        let service = RevenueCatService.shared
        let monthly = service.offerings.first { $0.identifier == "keel_pro_monthly" }
        
        XCTAssertNotNil(monthly)
        XCTAssertTrue(monthly!.features.contains("Unlimited history"))
        XCTAssertTrue(monthly!.features.contains("Analytics"))
        XCTAssertTrue(monthly!.features.contains("Export data"))
    }
    
    // MARK: - Entitlements
    
    func testProStatusRequiresAllEntitlements() {
        let service = RevenueCatService()
        service.hasHistoryUnlimited = true
        XCTAssertFalse(service.isPro) // missing analytics + export
        
        service.hasAnalytics = true
        XCTAssertFalse(service.isPro) // missing export
        
        service.hasExport = true
        XCTAssertTrue(service.isPro)
    }
    
    // MARK: - Purchase Flow (stub)
    
    func testPurchaseStubSucceeds() async {
        let service = RevenueCatService()
        let product = SubscriptionProduct(
            identifier: "test_monthly",
            title: "Test",
            price: "$1.99",
            period: "/month",
            features: ["Feature"],
            isPopular: false
        )
        
        let success = await service.purchase(product: product)
        XCTAssertTrue(success)
        XCTAssertTrue(service.isPro)
        XCTAssertTrue(service.hasHistoryUnlimited)
        XCTAssertTrue(service.hasAnalytics)
        XCTAssertTrue(service.hasExport)
    }
    
    func testPurchaseStubCallbackFires() async {
        let service = RevenueCatService()
        let product = SubscriptionProduct(
            identifier: "test_monthly",
            title: "Test",
            price: "$1.99",
            period: "/month",
            features: ["Feature"],
            isPopular: false
        )
        
        var callbackFired = false
        var successValue = false
        service.onPurchaseCompleted = { success, _ in
            callbackFired = true
            successValue = success
        }
        
        _ = await service.purchase(product: product)
        XCTAssertTrue(callbackFired)
        XCTAssertTrue(successValue)
    }
    
    // MARK: - Restore Flow (stub)
    
    func testRestoreStubSucceeds() async {
        let service = RevenueCatService()
        let success = await service.restorePurchases()
        XCTAssertTrue(success)
        XCTAssertTrue(service.isPro)
    }
    
    func testRestoreStubCallbackFires() async {
        let service = RevenueCatService()
        var callbackFired = false
        var successValue = false
        service.onRestored = { success, _ in
            callbackFired = true
            successValue = success
        }
        
        _ = await service.restorePurchases()
        XCTAssertTrue(callbackFired)
        XCTAssertTrue(successValue)
    }
    
    // MARK: - Error State
    
    func testErrorMessageStartsNil() {
        let service = RevenueCatService()
        XCTAssertNil(service.errorMessage)
    }
    
    // MARK: - SubscriptionProduct
    
    func testSubscriptionProductFeaturesForYearly() {
        let features = SubscriptionProduct.featuresFor(productId: "keel_pro_yearly")
        XCTAssertTrue(features.contains("2 months free"))
    }
    
    func testSubscriptionProductFeaturesForMonthly() {
        let features = SubscriptionProduct.featuresFor(productId: "keel_pro_monthly")
        XCTAssertTrue(features.contains("Unlimited history"))
    }
    
    func testSubscriptionProductIsPopularForYearly() {
        let product = SubscriptionProduct(
            identifier: "keel_pro_yearly",
            title: "Annual",
            price: "$59.99",
            period: "/year",
            features: ["All"],
            isPopular: true
        )
        XCTAssertTrue(product.isPopular)
    }
    
    // MARK: - Loading State
    
    func testLoadingStateDefaultsToFalse() {
        let service = RevenueCatService()
        XCTAssertFalse(service.isLoading)
    }
}
