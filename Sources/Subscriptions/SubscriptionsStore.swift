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
    
    public func insert(_ subscriptions: Subscription...) {
        insert(subscriptions)
    }
    
    public func insert(_ subscriptions: [Subscription]) {
        lock.lock()
        defer { lock.unlock() }
        
        self.subscriptions.append(contentsOf: subscriptions)
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

extension SubscriptionsStore {
    public convenience init(@SubscriptionsBuilder _ subscriptions: () -> [Subscription]) {
        self.init(subscriptions())
    }
    
    public func insert(@SubscriptionsBuilder _ subscriptions: () -> [Subscription]) {
        insert(subscriptions())
    }

    @resultBuilder
    public struct SubscriptionsBuilder {
        public static func buildBlock(_ subscriptions: Subscription...) -> [Subscription] {
            return subscriptions
        }
    }
}
