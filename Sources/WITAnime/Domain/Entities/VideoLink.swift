import Foundation
import Tagged

public struct VideoLink {
    public let id: ID
    public let server: String
    public let url: URL
}

extension VideoLink: Identifiable {
    public typealias ID = Tagged<VideoLink, UUID>
}

extension VideoLink: Hashable { }
