import Combine

extension Cancellable {
    public func eraseToAnySubscription() -> AnySubscription {
        AnySubscription { [self] in
            cancel()
        }
    }
    
    public func store(in store: SubscriptionsStore) {
        eraseToAnySubscription().store(in: store)
    }
}
