import Subscriptions
import XCTest

final class SubscriptionsStoreTests: TestCase {
    func test_storeDoesNotLeak() {
        let store = SubscriptionsStore()
        trackForMemoryLeaks(store)
    }
    
    func test_storeCancellsSubscriptionsOnCancelAll() {
        let subs = createSubs()
        let store = SubscriptionsStore(subs)
        
        store.cancelAll()
        
        let invalidStateSubs = subs.filter { $0.cancelCalled != 1 }

        XCTAssert(
            invalidStateSubs.isEmpty,
            "Expected all subscriptions to be cancelled properly, but \(invalidStateSubs.count) were not"
        )
    }
    
    func test_storeCancellsTasksOnceUponDeinit() {
        var store: SubscriptionsStore!
        let subscription = createSub()
        
        autoreleasepool {
            store = SubscriptionsStore(subscription)
            store = nil
        }
        
        let isStoreDeallocated = store == nil
        
        XCTAssert(
            isStoreDeallocated,
            "Store should've been deallocated, but it didn't"
        )
        
        let cancelCalled = subscription.cancelCalled
        
        XCTAssert(
            cancelCalled == 1,
            "Expected subscription to be cancelled once, got \(cancelCalled) cancels instead"
        )
    }
    
    func test_storeIsThreadSafe() {
        let subs = createSubs(count: 100)
        let store = SubscriptionsStore()
        
        let didAddSubs = subs.enumerated().map { offset, sub -> XCTestExpectation in
            let queue = DispatchQueue(label: "insert-subscription-\(offset)", qos: .userInteractive)
            let expectation = expectation(description: "Waiting for subscription \(offset) to be added into the store")
            queue.async {
                store.insert(sub)
                expectation.fulfill()
            }
            return expectation
        }
        
        let didCancelSubs = expectation(description: "Waiting for subscriptions to be cancelled")
        DispatchQueue(label: "cancel-subscriptions", qos: .userInteractive).async {
            store.cancelAll()
            didCancelSubs.fulfill()
        }
        
        wait(for: didAddSubs + [didCancelSubs], timeout: 2)
        
        let invalidStateSubs = subs.filter { $0.cancelCalled != 1 }

        XCTAssert(
            invalidStateSubs.isEmpty,
            "Expected all subscriptions to be cancelled properly, but \(invalidStateSubs.count) were not"
        )
    }
    
    // MARK: - Helpers
    
    private func createSub(_ index: Int = 0) -> SubscriptionSpy {
        SubscriptionSpy(
            SubscriptionMock { debugPrint("\(#function): did cancel subscription \(index)") }
        )
    }
    
    private func createSubs(count: Int = 5) -> [SubscriptionSpy] {
        (0 ..< count).map(createSub)
    }

}
