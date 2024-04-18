import Foundation

public struct Schedule {
    public let day: String
    public let list: [Anime]
}

extension Schedule: Hashable {}
