//
//  SubscriptionsStore.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

public final class SubscriptionsStore {
    private let lock = Lock()
    
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
        lock.lock()
        defer { lock.unlock() }
        
        subscriptions.append(subscription)
    }
    
    public func cancelAll() {
        lock.lock()
        defer { lock.unlock() }
        
        subscriptions.forEach {
            $0.cancel()
        }
        subscriptions.removeAll(keepingCapacity: false)
    }
}
