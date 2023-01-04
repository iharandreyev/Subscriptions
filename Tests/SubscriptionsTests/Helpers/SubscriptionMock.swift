//
//  SubscriptionMock.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

import Subscriptions

struct SubscriptionMock: Subscription {
    var cancelClosure: () -> Void = { /* do nothing */ }
    
    func cancel() {
        cancelClosure()
    }
}
