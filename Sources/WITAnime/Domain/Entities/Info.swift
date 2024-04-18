import Foundation

public struct Info {
    public let title: String
    public let story: String
    public let genres: [String]
    public let type: String
    public let startDate: String
    public let season: String
    public let status: String
    public let episodesCount: String
    public let source: String
    public let episodeDuration: String
}

extension Info: Hashable { }
