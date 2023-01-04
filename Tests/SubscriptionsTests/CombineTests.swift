//
//  CombineTests.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

import Combine
import Subscriptions
import XCTest

final class CombineTests: TestCase {
    func test_sinkIsCancelledOnCancelAll() {
        let store = SubscriptionsStore()
        let sub = createSub()
        sub.store(in: store)
        
        store.cancelAll()
        
        assertCancelled(sub)
    }
    
    func test_sinkIsCancelledUponStoreDeinit() {
        var store: SubscriptionsStore!
        let sub = createSub()

        autoreleasepool {
            store = SubscriptionsStore()
            sub.store(in: store)
            store = nil
        }

        assertCancelled(sub)
    }
    
    // MARK: - Helpers
    
    private func createSub() -> CancellableSpy {
        let subject = PassthroughSubject<Int, Never>()
        return CancellableSpy(subject.sink())
    }
    
    private func assertCancelled(
        _ sub: CancellableSpy,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let cancelCalled = sub.cancelCalled
        
        XCTAssert(
            cancelCalled == 1,
            "Expected sink to be cancelled once, got \(cancelCalled) cancels instead",
            file: file,
            line: line
        )
    }
}
