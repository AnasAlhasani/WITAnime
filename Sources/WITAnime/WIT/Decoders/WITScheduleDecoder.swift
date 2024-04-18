import Foundation
import SwiftSoup

extension HTMLDecoder where Value == [Anime] {
    static func scheduleDecoder(animeDecoder: HTMLDecoder<[Anime]> = .animeDecoder) -> Self {
        // TODO: Implement Schedule Decoder 💩
        .init(decode: animeDecoder.decode)
    }
}
