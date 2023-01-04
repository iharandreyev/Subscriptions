//
//  Cancellable+Subscription.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/5/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

import Foundation

@resultBuilder
public struct ArrayBuilder<Element> {
    public static func buildBlock(_ elements: Element...) -> [Element] {
        return elements
    }
}
