//
//  AnySubscription.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

public struct AnySubscription: Subscription {
    private let cancelClosure: () -> Void
    
    public init(cancel: @escaping () -> Void) {
        cancelClosure = cancel
    }
    
    public func cancel() {
        cancelClosure()
    }
}
