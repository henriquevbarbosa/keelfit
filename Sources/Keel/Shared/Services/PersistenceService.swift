import Foundation

// MARK: - Persistence Service
// Wrapper for local persistence using UserDefaults (lightweight, no SwiftData).

public class PersistenceService {
    public static let shared = PersistenceService()

    public init() {}

    public func save<T: Encodable>(_ object: T, key: String) {
        if let data = try? JSONEncoder().encode(object) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    public func load<T: Decodable>(_ type: T.Type, key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }

    public func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }

    // MARK: - Onboarding helpers

    public func hasExistingProfile() async -> Bool {
        let profile: UserProfile? = load(UserProfile.self, key: "userProfile")
        return profile != nil
    }

    public func saveProfile(_ profile: UserProfile) async throws {
        save(profile, key: "userProfile")
    }
}
