import Foundation

public struct APIClient {
    public let data: (URL) async throws -> Data
}

extension APIClient {
    public static var live: Self {
        .init {
            let (data, _) = try await URLSession.shared.data(from: $0)
            return data
        }
    }
}
