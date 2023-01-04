public struct AnySubscription: Subscription {
    private let cancelClosure: () -> Void
    
    public init(cancel: @escaping () -> Void) {
        cancelClosure = cancel
    }
    
    public func cancel() {
        cancelClosure()
    }
}
