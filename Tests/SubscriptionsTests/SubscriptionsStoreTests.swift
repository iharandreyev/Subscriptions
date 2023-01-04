import Subscriptions
import XCTest

final class SubscriptionsStoreTests: TestCase {
    func test_storeDoesNotLeak() {
        let store = SubscriptionsStore()
        trackForMemoryLeaks(store)
    }
    
    func test_storeCancellsTasksOnceUponDeinit() {
        var store: SubscriptionsStore!
        let subscription = SubscriptionSpy(
            SubscriptionMock { print("\(#function): did cancel subscription") }
        )
        
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
}
