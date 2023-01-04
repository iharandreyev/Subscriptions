import Subscriptions

struct SubscriptionMock: Subscription {
    var cancelClosure: () -> Void = { /* do nothing */ }
    
    func cancel() {
        cancelClosure()
    }
}
