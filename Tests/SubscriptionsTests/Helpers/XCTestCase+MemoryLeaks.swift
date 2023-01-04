//
//  XCTestCase+MemoryLeaks.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks<Instance: AnyObject>(
        _ instance: Instance,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "\(Instance.self) is probably leaking",
                file: file,
                line: line
            )
        }
    }
}
