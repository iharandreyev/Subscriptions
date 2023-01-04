public protocol Subscription {
    func cancel()
}

extension Subscription {
    public func store(in store: SubscriptionsStore) {
        store.insert(self)
    }
}
