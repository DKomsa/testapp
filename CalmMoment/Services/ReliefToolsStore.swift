import Foundation

final class ReliefToolsStore {
    private let defaults: UserDefaults
    private let key = "saved_relief_tools"

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func load() -> SavedReliefTools {
        guard let data = defaults.data(forKey: key),
              let decoded = try? JSONDecoder().decode(SavedReliefTools.self, from: data) else {
            return .empty
        }
        return decoded
    }

    func save(_ tools: SavedReliefTools) {
        guard let encoded = try? JSONEncoder().encode(tools) else { return }
        defaults.set(encoded, forKey: key)
    }
}
