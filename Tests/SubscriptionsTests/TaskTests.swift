//
//  TaskTests.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

import Subscriptions
import XCTest

final class TaskTests: TestCase {
    func test_asyncTaskIsCancelledOnCancelAll() {
        let store = SubscriptionsStore()
        let task = createTask()
        task.store(in: store)
        
        store.cancelAll()
        
        assertCancelled(task)
    }
    
    func test_taskIsCancelledUponStoreDeinit() {
        var store: SubscriptionsStore!
        let task = createTask()
        
        autoreleasepool {
            store = SubscriptionsStore()
            task.store(in: store)
            store = nil
        }

        assertCancelled(task)
    }
    
    // MARK: - Helpers
    
    private func createTask() -> Task<Void, Error> {
        .sleep(seconds: 300)
    }
    
    private func assertCancelled(
        _ task: Task<Void, Error>,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssert(
            task.isCancelled,
            "Expected task to be cancelled, but it did not",
            file: file,
            line: line
        )
    }
    
    
}
