//
//  Subscription.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

public protocol Subscription {
    func cancel()
}

extension Subscription {
    public func store(in store: SubscriptionsStore) {
        store.insert(self)
    }
}
