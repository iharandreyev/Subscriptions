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
        Task { [unowned self] in
            do {
                let data = try await performAsyncFetch()
                succeed(with: data)
            } catch {
                fail(with: error)
            }
        }
        .store(in: subs)
    }
    
    private func performAsyncFetch() async throws -> Data {
        try String(describing: Self.self).data(using: .utf8)
    }
    
    private func succeed(with data: Data) {
        print(data)
    }
    
    private func fail(with error: Error) {
        print(error)
    }
}


