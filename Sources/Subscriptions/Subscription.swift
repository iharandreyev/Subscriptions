public protocol Subscription {
    func cancel()
}

extension Subscription {
    public func store(in store: SubscriptionsStore) {
        Task(priority: .high) {
            await store.insert(self)
        }
    }
}
