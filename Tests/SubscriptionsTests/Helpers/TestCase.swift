//
//  TestCase.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

import XCTest

// @inlinable doesn't work for methods defined in extensions, hence this subclass
class TestCase: XCTestCase {
    @inlinable
    func wait(for expectation: XCTestExpectation, timeout seconds: TimeInterval) {
        wait(for: [expectation], timeout: seconds)
    }
    
    @inlinable
    func autoreleasepool<Result>(timeout seconds: TimeInterval = 1, work: () -> Result) -> Result {
        let didFlush = XCTestExpectation(description: "Waiting for pool to flush")
        let result = Foundation.autoreleasepool {
            let result = work()
            didFlush.fulfill()
            return result
        }
        wait(for: didFlush, timeout: seconds)
        return result
    }
}
