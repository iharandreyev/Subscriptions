import Subscriptions
import XCTest

final class TaskTests: TestCase {
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
