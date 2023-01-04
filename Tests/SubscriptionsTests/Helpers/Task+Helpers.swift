//
//  Task+Helpers.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

import Foundation

extension Task where Success == Void, Failure == Error {
    static func sleep(seconds: TimeInterval, priority: TaskPriority = .background) -> Task {
        Task(priority: priority) {
            try await Task<Never, Never>.sleep(seconds: seconds)
        }
    }
}

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: TimeInterval) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
