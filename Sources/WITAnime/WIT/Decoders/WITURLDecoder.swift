import Foundation
import SwiftSoup

extension HTMLDecoder where Value == URL {
    enum URLDecoderType {
        case schedule
        case seasonal
        
        var query: String {
            switch self {
            case .schedule:
                return "#menu-item-55 a"
            case .seasonal:
                return "#menu-item-107 a"
            }
        }
    }
    
    static func urlDecoder(ofType type: URLDecoderType) -> Self {
        .init { document in
            let elements = try document.select(type.query)
            let string = try elements.first().unwrap().attr("href")
            return try URL(string: string).unwrap()
        }
    }
}
