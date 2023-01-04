public actor SubscriptionsStore {
    private var subscriptions: [Subscription]
    
    public init(_ subscriptions: [Subscription] = []) {
        self.subscriptions = subscriptions
    }
    
    public init(_ subscriptions: Subscription...) {
        self.subscriptions = subscriptions
    }
    
    deinit {
        subscriptions.forEach {
            $0.cancel()
        }
        subscriptions.removeAll()
    }
    
    public func insert(_ subscription: Subscription) {
        subscriptions.append(subscription)
    }
}
