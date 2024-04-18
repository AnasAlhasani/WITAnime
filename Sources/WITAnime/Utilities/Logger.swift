import Foundation
import os

let logger = Logger(
    subsystem: "com.witanime",
    category: "WITAnime"
)

struct Logger {
    private let logger: os.Logger
    
    init(subsystem: String, category: String) {
        logger = os.Logger(subsystem: subsystem, category: category)
    }
}

extension Logger {
    func log(
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
