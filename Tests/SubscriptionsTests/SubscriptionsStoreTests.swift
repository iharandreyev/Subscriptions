import Subscriptions
import XCTest

final class SubscriptionsStoreTests: TestCase {
    func test_storeDoesNotLeak() {
        let store = SubscriptionsStore()
        trackForMemoryLeaks(store)
    }
    
    func test_storeCancellsSubsOnCancelAll() {
        let subs = createSubs()
        let store = SubscriptionsStore(subs)
        
        store.cancelAll()
        
        expectCancelled(subs)
    }
    
    func test_storeCancellsTasksOnceUponDeinit() {
        var store: SubscriptionsStore!
        let sub = createSub()
        
        autoreleasepool {
            store = SubscriptionsStore(sub)
            store = nil
        }
        
        let isStoreDeallocated = store == nil
        
        XCTAssert(
            isStoreDeallocated,
            "Store should've been deallocated, but it didn't"
        )
        
        expectCancelled(sub)
    }
    
    func test_storeIsThreadSafe() {
        let subs = createSubs(count: 100)
        let store = SubscriptionsStore()
        
        let didAddSubs = subs.enumerated().map { offset, sub -> XCTestExpectation in
            expectationForTask("add subscription \(offset) into the store") { completion in
                DispatchQueue(label: "insert-subscription-\(offset)", qos: .userInteractive).async {
                    store.insert(sub)
                    completion()
                }
            }
        }
        
        let didCancelSubs = expectationForTask("cancel all") { completion in
            DispatchQueue(label: "cancel-subscriptions", qos: .userInteractive).async {
                store.cancelAll()
                completion()
            }
        }
        
        wait(for: didAddSubs + [didCancelSubs], timeout: 2)
        
        expectCancelled(subs)
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
    
    private func expectCancelled(
        _ subs: [SubscriptionSpy],
        file: StaticString = #file,
        line: UInt = #line
    ) {
        for (index, sub) in subs.enumerated() {
            expectCancelled(sub, at: index, file: file, line: line)
        }
    }
    
    private func expectCancelled(
        _ sub: SubscriptionSpy,
        at index: Int? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let cancelCalled = sub.cancelCalled
        
        XCTAssert(
            cancelCalled == 1,
            "Expected subscription\(index.map { " \($0)" } ?? "") to be cancelled once, got \(cancelCalled) cancels instead",
            file: file,
            line: line
        )
    }
}
