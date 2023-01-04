//
//  CancellableSpy.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

import Combine

final class CancellableSpy: Cancellable {
    private let cancellable: Cancellable
    private(set) var cancelCalled: Int = 0
    
    init(_ cancellable: Cancellable) {
        self.cancellable = cancellable
    }

    func cancel() {
        cancelCalled += 1
        cancellable.cancel()
    }
}
