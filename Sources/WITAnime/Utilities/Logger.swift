import Foundation
import os

public let logger = Logger(
    subsystem: "com.witanime",
    category: "WITAnime"
)

public struct Logger {
    private let logger: os.Logger
    
    public init(subsystem: String, category: String) {
        logger = os.Logger(subsystem: subsystem, category: category)
    }
}

extension Logger {
    public func log(
        level: OSLogType = .default,
        _ message: @autoclosure () -> String,
        file: String = URL(fileURLWithPath: #fileID).deletingPathExtension().lastPathComponent,
        function: String = #function,
        line: UInt = #line
    ) {
        let message = message()
        let callSite = "\(file).\(function):\(line)"
        logger.log(level: level, "\(callSite) - \(message)")
    }
}
