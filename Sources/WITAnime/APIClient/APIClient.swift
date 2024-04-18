import Foundation

public struct APIClient {
    public let data: @Sendable (_ fromURL: String) async throws -> Data
}

public extension APIClient {
    enum Error: LocalizedError {
        case invalidURL
        case invalidResponse
        case underlying(error: Swift.Error)
        
        public var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid url."
            case .invalidResponse:
                return "Invalid response."
            case let .underlying(error):
                return error.localizedDescription
            }
        }
    }
}

public extension APIClient {
    static func apiClient() -> Self {
        .init { url in
            do {
                let url = try URL(string: url).unwrap(throwing: Error.invalidURL)
                let (data, response) = try await URLSession.shared.data(from: url)
                let httpResponse = try (response as? HTTPURLResponse).unwrap(throwing: Error.invalidResponse)
                logger.log(level: .info, "✅ \(url) - response code: \(httpResponse.statusCode)")
                return data
            } catch {
                logger.log(level: .fault, "❌ Failed to fetch data from \(url) | Error: \(error.localizedDescription)")
                throw Error.underlying(error: error)
            }
        }
    }
}
