import Foundation
import SwiftSoup

struct HTMLDecoder<Value> {
    let decode: (Document) async throws -> Value
}

extension Element {
    func jsAttr(_ key: String) throws -> String {
        let extract = { (function: String) in
            let pattern = "(.*?)\\('(.*?)'\\)"
            let string = function as NSString
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let results = regex.matches(in: function, options: [], range: NSRange(location: 0, length: string.length))
            
            if let match = results.first {
                let range = match.range(at: 2)
                return string.substring(with: range)
            } else {
                return function
            }
        }
        
        return try extract(attr(key))
    }
}

extension Data {
    private var document: Document {
        get throws {
            let html = String(data: self, encoding: .utf8)
            return try SwiftSoup.parse(html.unwrap())
        }
    }
    
    func decode<Value>(using decoder: HTMLDecoder<Value>) async throws -> Value {
        try await decoder.decode(document)
    }
}
