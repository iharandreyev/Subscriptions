import Subscriptions
import XCTest

final class SubscriptionsTests: TestCase {
    func test_subscriptionIsCancelledUponStoreDeinit() {
        var store: SubscriptionsStore!
        let subscription = SubscriptionSpy { }
        
        autoreleasepool {
            store = SubscriptionsStore()
            subscription.store(in: store)
            store = nil
        }
        
        XCTAssert(
            subscription.cancelCalled == 1,
            "Expected subscription to be cancelled once, got \(subscription.cancelCalled) cancel count instead"
        )
    }
    
    func test_taskIsCancelledUponStoreDeinit() {
        var store: SubscriptionsStore!
        let subscription = Task.sleep(seconds: 300)
        
        autoreleasepool {
            store = SubscriptionsStore()
            subscription.store(in: store)
            store = nil
        }

        XCTAssert(
            subscription.isCancelled,
            "Expected task to be cancelled, but it did not"
        )
    }
}
