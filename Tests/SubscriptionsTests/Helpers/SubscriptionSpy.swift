import Subscriptions

final class SubscriptionSpy: Subscription {
    private let subscription: Subscription
    private(set) var cancelCalled: Int = 0
    
    init(_ subscription: Subscription) {
        self.subscription = subscription
    }

    func cancel() {
        cancelCalled += 1
        subscription.cancel()
    }
}
