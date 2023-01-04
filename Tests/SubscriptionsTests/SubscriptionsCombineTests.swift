import Combine
import Subscriptions
import XCTest

final class SubscriptionsCombineTests: TestCase {
    func test_sinkIsCancelledUponStoreDeinit() {
        var store: SubscriptionsStore!
        let subject = PassthroughSubject<Int, Never>()
        
        let subscription = CancellableSpy(subject.sink())
        
        subject.send(1)
        subject.send(2)

        autoreleasepool {
            store = SubscriptionsStore()
            subscription.store(in: store)
            store = nil
        }

        XCTAssert(
            subscription.cancelCalled == 1,
            "Expected sink to be cancelled once, got \(subscription.cancelCalled) cancel count instead"
        )
    }
}
