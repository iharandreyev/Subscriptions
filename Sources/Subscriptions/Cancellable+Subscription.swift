//
//  Cancellable+Subscription.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

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
