import Foundation
import os

let logger = Logger(subsystem: "com.anime-drive", category: "AnimeDriveKit")

struct Logger {
    private let logger: os.Logger
    
    init(subsystem: String, category: String) {
        logger = os.Logger(subsystem: subsystem, category: category)
    }
    
    func log(
        level: OSLogType = .default,
        _ message: @autoclosure () -> String,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) {
        let message = message()
        let callSite = "\(URL(fileURLWithPath: file).deletingPathExtension().lastPathComponent).\(function):\(line)"
        logger.log(level: level, "\(callSite) - \(message)")
    }
}
