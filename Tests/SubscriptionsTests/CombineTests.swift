import Combine
import Subscriptions
import XCTest

final class CombineTests: TestCase {
    func test_sinkIsCancelledOnCancelAll() {
        let store = SubscriptionsStore()
        
        let subject = PassthroughSubject<Int, Never>()
        let subscription = CancellableSpy(subject.sink())
        
        subscription.store(in: store)
        
        store.cancelAll()
        
        XCTAssert(
            subscription.cancelCalled == 1,
            "Expected sink to be cancelled once, got \(subscription.cancelCalled) cancel count instead"
        )
    }
    
    func test_sinkIsCancelledUponStoreDeinit() {
        var store: SubscriptionsStore!
        
        let subject = PassthroughSubject<Int, Never>()
        let subscription = CancellableSpy(subject.sink())

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
