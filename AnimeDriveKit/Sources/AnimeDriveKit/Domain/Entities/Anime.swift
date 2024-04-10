import Foundation
import Tagged

public struct Anime {
    public let id: ID
    public let name: String
    public let imageURL: URL?
    public let type: String
    public let status: String
    public let story: String
}

extension Anime: Identifiable {
    public typealias ID = Tagged<Anime, String>
}

extension Anime: Hashable { }
