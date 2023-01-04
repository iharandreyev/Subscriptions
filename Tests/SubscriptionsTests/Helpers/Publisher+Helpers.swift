//
//  Publisher+Helpers.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

import Combine

extension Publisher {
    func sink() -> Cancellable {
        sink(receiveCompletion: { _ in }, receiveValue: { _ in })
    }
}
