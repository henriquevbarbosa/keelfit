import Foundation

#if !SKIP
import RevenueCat
#endif

@Observable
public class RevenueCatService {
    public static let shared = RevenueCatService()

    public var offerings: [SubscriptionProduct] = []
    public var isLoading: Bool = false
    public var errorMessage: String? = nil

    public var hasHistoryUnlimited: Bool = false
    public var hasAnalytics: Bool = false
    public var hasExport: Bool = false
    public var isPro: Bool { hasHistoryUnlimited && hasAnalytics && hasExport }

    public var onPurchaseCompleted: ((Bool, String?) -> Void)? = nil
    public var onRestored: ((Bool, String?) -> Void)? = nil

    public init() {}

    public func configure(apiKey: String) {
        #if !SKIP
        Purchases.configure(withAPIKey: apiKey)
        #endif
        Task { await fetchOfferings() }
    }

    public func fetchOfferings() async {
        isLoading = true
        errorMessage = nil

        #if !SKIP
        do {
            let offerings = try await Purchases.shared.offerings()
            var products: [SubscriptionProduct] = []
            if let current = offerings.current {
                for package in current.availablePackages {
                    products.append(SubscriptionProduct(from: package))
                }
            }
            self.offerings = products.sorted { $0.isPopular && !$1.isPopular }
            isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            isLoading = false
        }
        #else
        self.offerings = [
            SubscriptionProduct(
                identifier: "keel_pro_monthly",
                title: "Keel Pro",
                price: "$7.99",
                period: "/month",
                features: ["Unlimited history", "Analytics", "Export data"],
                isPopular: true
            ),
            SubscriptionProduct(
                identifier: "keel_pro_yearly",
                title: "Keel Pro Annual",
                price: "$59.99",
                period: "/year",
                features: ["All monthly features", "2 months free", "Priority support"],
                isPopular: false
            )
        ]
        isLoading = false
        #endif
    }

    public func purchase(product: SubscriptionProduct) async -> Bool {
        isLoading = true
        errorMessage = nil
        #if !SKIP
        guard let package = await findPackage(for: product.identifier) else {
            errorMessage = "Product not found"
            isLoading = false
            return false
        }
        do {
            let (_, customerInfo, _) = try await Purchases.shared.purchase(package: package)
            updateEntitlements(from: customerInfo)
            isLoading = false
            onPurchaseCompleted?(true, nil)
            return true
        } catch {
            self.errorMessage = error.localizedDescription
            isLoading = false
            onPurchaseCompleted?(false, error.localizedDescription)
            return false
        }
        #else
        hasHistoryUnlimited = true
        hasAnalytics = true
        hasExport = true
        isLoading = false
        onPurchaseCompleted?(true, nil)
        return true
        #endif
    }

    public func restore() async {
        isLoading = true
        errorMessage = nil
        #if !SKIP
        do {
            let customerInfo = try await Purchases.shared.restorePurchases()
            updateEntitlements(from: customerInfo)
            isLoading = false
            onRestored?(true, nil)
        } catch {
            self.errorMessage = error.localizedDescription
            isLoading = false
            onRestored?(false, error.localizedDescription)
        }
        #else
        isLoading = false
        onRestored?(true, nil)
        #endif
    }

    #if !SKIP
    private func findPackage(for identifier: String) async -> RevenueCat.Package? {
        guard let offerings = try? await Purchases.shared.offerings(),
              let current = offerings.current else { return nil }
        return current.availablePackages.first { $0.identifier == identifier }
    }

    private func updateEntitlements(from info: RevenueCat.CustomerInfo) {
        hasHistoryUnlimited = info.entitlements["history-unlimited"]?.isActive == true
        hasAnalytics = info.entitlements["analytics"]?.isActive == true
        hasExport = info.entitlements["export"]?.isActive == true
    }
    #endif
}

// MARK: - SubscriptionProduct
public struct SubscriptionProduct: Identifiable {
    public var id: String { identifier }
    public let identifier: String
    public let title: String
    public let price: String
    public let period: String
    public let features: [String]
    public let isPopular: Bool

    public init(identifier: String, title: String, price: String, period: String, features: [String], isPopular: Bool) {
        self.identifier = identifier
        self.title = title
        self.price = price
        self.period = period
        self.features = features
        self.isPopular = isPopular
    }

    #if !SKIP
    public init(from package: RevenueCat.Package) {
        self.identifier = package.identifier
        self.title = package.storeProduct.localizedTitle
        self.price = package.storeProduct.localizedPriceString
        self.period = package.storeProduct.subscriptionPeriod?.debugDescription ?? ""
        self.features = package.storeProduct.localizedDescription.components(separatedBy: "\\n")
        self.isPopular = package.packageType == .annual
    }
    #endif
}
