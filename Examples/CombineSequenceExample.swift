//
//  CombineSequenceExample.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

import Combine
import Foundation

public class CombineSequenceExample {
    private let subs = SubscriptionsStore()
    
    public init() { }
    
    public func runExample() {
        performAsyncFetch()
            .sink(
                receiveCompletion: { completion in
                    guard case let .failure(error) = completion else { return }
                    print(error)
                },
                receiveValue: { data in
                    print(data)
                })
                .store(in: subs)
    }
    
    private func performAsyncFetch() -> AnyPublisher<Data, Error> {
        Future { promise in
            promise(.init(catching: {
                try String(describing: Self.self).data(using: .utf8)
            }))
        }
        .eraseToAnyPublisher()
    }
}
