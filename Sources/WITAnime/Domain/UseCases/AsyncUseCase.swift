import Foundation

public struct AsyncUseCase<Input, Output> {
    private let task: (Input) async throws -> Output
    
    public init(_ task: @Sendable @escaping (Input) async throws -> Output) {
        self.task = task
    }
    
    public func callAsFunction(input: Input) async throws -> Output {
        try await task(input)
    }
}

extension AsyncUseCase where Input == Void {
    public func callAsFunction() async throws -> Output {
        try await callAsFunction(input: ())
    }
}
