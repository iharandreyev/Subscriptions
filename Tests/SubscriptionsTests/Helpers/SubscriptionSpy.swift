import Subscriptions

final class SubscriptionSpy: Subscription {
    private let cancelClosure: () -> Void
    private(set) var cancelCalled: Int = 0
    
    init(_ cancel: @escaping () -> Void) {
        cancelClosure = cancel
    }

    func cancel() {
        cancelCalled += 1
        cancelClosure()
    }
}
