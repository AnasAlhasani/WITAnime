import Foundation

extension Optional {
    func unwrap(
        throwing: @autoclosure () -> Error? = nil,
        file: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) throws -> Wrapped {
        switch self {
        case let .some(value): 
            return value
            
        case .none:
            let error = throwing() ?? UnwrapError()
            logger.log(error.localizedDescription, file: file, function: function, line: line)
            throw error
        }
    }
    
    private struct UnwrapError: Error, LocalizedError {
        var errorDescription: String? {
            "Failed to unwrap '\(Wrapped.self)' value"
        }
    }
}
