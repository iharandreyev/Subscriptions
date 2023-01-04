public final class SubscriptionsStore {
    @ThreadSafe
    private var subscriptions: [Subscription]
    
    public init(_ subscriptions: [Subscription] = []) {
        self.subscriptions = subscriptions
    }
    
    public init(_ subscriptions: Subscription...) {
        self.subscriptions = subscriptions
    }
    
    deinit {
        cancelAll()
    }
    
    public func insert(_ subscription: Subscription) {
        subscriptions.append(subscription)
    }
    
    public func cancelAll() {
        let subscriptions = subscriptions
        
        subscriptions.forEach {
            $0.cancel()
        }
    }
}
