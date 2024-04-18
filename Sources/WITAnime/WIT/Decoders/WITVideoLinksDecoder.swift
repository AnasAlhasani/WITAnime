import Foundation
import SwiftSoup

extension HTMLDecoder where Value == [VideoLink] {
    static var videoLinksDecoder: Self {
        .init { document in
            try document
                .select("#episode-servers > li")
                .array()
                .safeMap {
                    VideoLink(
                        id: .init(UUID()), 
                        server:  try $0.select("span.notice").text(),
                        url: try {
                            let url = try URL(base64: $0.select("a").attr("data-url")).unwrap()
                            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                            if url.scheme == nil {
                                logger.log(level: .debug, "🔗 \(url) is missing a scheme")
                                components?.scheme = "https"
                            }
                            return try (components?.url).unwrap()
                        }($0)
                    )
                }
        }
    }
}
