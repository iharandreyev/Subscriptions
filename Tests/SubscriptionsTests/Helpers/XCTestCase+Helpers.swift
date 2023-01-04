//
//  XCTestCase+Helpers.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

import XCTest

extension XCTestCase {
    func expectationForTask(
        _ name: String,
        task: (_ completion: @escaping () -> Void) -> Void
    ) -> XCTestExpectation {
        let expectation = expectation(description: "Waiting for `\(name)`")
        task {
            expectation.fulfill()
        }
        return expectation
    }
}
