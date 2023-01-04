//
//  AsyncTaskExample.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

import Foundation

public class AsyncTaskExample {
    private let subs = SubscriptionsStore()
    
    public init() { }
    
    public func runExample() {
        Task {
            do {
                let data = try await performAsyncFetch()
                print(data)
            } catch {
                print(error)
            }
        }
        .store(in: subs)
    }
    
    private func performAsyncFetch() async throws -> Data {
        try String(describing: Self.self).data(using: .utf8)
    }
}


