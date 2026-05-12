import Foundation

public enum WeightUnit: String, Codable, Sendable {
    case kg = "kg"
    case lb = "lb"
    
    public var displayName: String { rawValue.uppercased() }
    
    public func convertToKg(_ value: Double) -> Double {
        switch self {
        case .kg: return value
        case .lb: return value * 0.453592
        }
    }
    
    public func convertFromKg(_ valueInKg: Double) -> Double {
        switch self {
        case .kg: return valueInKg
        case .lb: return valueInKg / 0.453592
        }
    }
}
