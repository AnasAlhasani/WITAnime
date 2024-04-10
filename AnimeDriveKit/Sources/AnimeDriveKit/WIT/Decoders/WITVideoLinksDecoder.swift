import Foundation
import SwiftSoup

extension HTMLDecoder where Value == [VideoLink] {
    static var videoLinksDecoder: Self {
        .init { document in
            try document
                .select("#episode-servers > li")
                .array()
                .map {
                    VideoLink(
                        id: .init(UUID()), 
                        server:  try $0.select("span.notice").text(),
                        url: try URL(base64: try $0.select("a").attr("data-url")).unwrap()
                    )
                }
        }
    }
}
