import Foundation
import SwiftSoup

extension HTMLDecoder where Value == [Anime] {
    static var animeDecoder: Self {
        .init { document in
            try document
                .select(".anime-card-container")
                .array()
                .safeMap {
                    Anime(
                        id: "\(try URL(string: try $0.select("h3 > a").attr("href")).unwrap().lastPathComponent)",
                        name: try $0.select("h3 > a").text(),
                        imageURL: URL(string: try $0.select(".img-responsive").attr("src")),
                        type: try $0.select(".anime-card-type a").text(),
                        status: try $0.select(".anime-card-status a").text(),
                        story: try $0.select(".anime-card-title").attr("data-content")
                    )
                }
        }
    }
}
