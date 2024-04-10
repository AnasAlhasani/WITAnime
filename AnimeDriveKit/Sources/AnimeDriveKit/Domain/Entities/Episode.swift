import Foundation
import Tagged

public struct Episode {
    public let id: ID
    public let name: String
    public let imageURL: URL?
    public let imageText: String
}

extension Episode: Identifiable {
    public typealias ID = Tagged<Episode, String>
}

extension Episode: Hashable { }
