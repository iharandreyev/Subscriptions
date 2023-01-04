//
//  SubscriptionSpy.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

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
