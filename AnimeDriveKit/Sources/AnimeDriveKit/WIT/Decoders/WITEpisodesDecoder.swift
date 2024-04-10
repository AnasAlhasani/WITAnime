import Foundation
import SwiftSoup

extension HTMLDecoder where Value == [Episode] {
    enum EpisodesDecoderType {
        case episodes
        case latest
        
        var query: String {
            switch self {
            case .episodes: return ".episodes-card-container"
            case .latest: return ".anime-card-container"
            }
        }
    }
    
    static func episodesDecoder(ofType type: EpisodesDecoderType) -> Self {
        .init { document in
            try document
                .select(type.query)
                .array()
                .map {
                    Episode(
                        id: "\(try URL(base64: try $0.select("h3 > a").first()?.jsAttr("onclick")).unwrap().lastPathComponent)",
                        name: try $0.select("h3 > a").first()?.text() ?? "",
                        imageURL: URL(string: try $0.select(".img-responsive").first()?.attr("src") ?? ""),
                        imageText: try $0.select(".img-responsive").first()?.attr("alt") ?? ""
                    )
                }
        }
    }
}
