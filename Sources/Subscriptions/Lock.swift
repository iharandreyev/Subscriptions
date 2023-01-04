//
//  Lock.swift
//  Subscriptions
//
//  Created by Ihar Andreyeu on 1/4/23.
//  Copyright © 2023 Ihar Andreyeu. All rights reserved.
//

import Foundation

/**
 An implementation of unfair lock that allocates `os_unfair_lock_s` in the [heap memory](https://whackylabs.com/swift/concurrency/2022/05/16/using-unfairlock-with-swift/) since Swift does not provide a `OS_UNFAIR_LOCK_INIT` equivalent.
 */
final class Lock {
    private typealias LockType = UnsafeMutablePointer<os_unfair_lock_s>
    
    private var unfairLock: os_unfair_lock_t
    
    init() {
        unfairLock = UnsafeMutablePointer<os_unfair_lock_s>.allocate(capacity: 1)
        unfairLock.initialize(to: os_unfair_lock())
    }
    
    deinit {
        unfairLock.deallocate()
    }
    
    func lock() {
        os_unfair_lock_lock(unfairLock)
    }
    
    func unlock() {
        os_unfair_lock_unlock(unfairLock)
    }
}
