import Foundation

extension String {
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension Optional {
    func unwrap(
        throwing error: @autoclosure () -> Error = UnwrapError(),
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) throws -> Wrapped {
        switch self {
        case let .some(value): 
            return value
            
        case .none:
            let error = error()
            logger.log(level: .error, error.localizedDescription, file: file, function: function, line: line)
            throw error
        }
    }
    
    private struct UnwrapError: Error, LocalizedError {
        var errorDescription: String? {
            "❗️ Failed to unwrap '\(Wrapped.self)' value"
        }
    }
}

extension Collection {
    var isNotEmpty: Bool {
        !isEmpty
    }
    
    func safeMap<T>(_ transform: (Element) throws -> T?) -> [T] {
        var result: [T] = []
        for (index, element) in enumerated() {
            do {
                if let value = try transform(element) {
                    result.append(value)
                }
            } catch {
                logger.log("⚠️ Found bad element at index (\(index)): '\(element)'")
                continue
            }
        }
        return result
    }
}

extension URL {
    init?(base64 string: String?) {
        guard
            let string = string,
            let data = Data(base64Encoded: string, options: .ignoreUnknownCharacters),
            let url = String(data: data, encoding: .utf8)
        else {
            logger.log(level: .error, "🔗 Failed to initialize URL from base64 string: \(string ?? "nil")")
            return nil
        }
    
        self.init(string: url)
    }
}
