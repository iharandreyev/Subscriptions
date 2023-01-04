import XCTest

extension XCTestCase {
    func expectationForTask(
        _ name: String,
        task: (_ completion: @escaping () -> Void) -> Void
    ) -> XCTestExpectation {
        let expectation = expectation(description: "Waiting for `\(name)`")
        task {
            expectation.fulfill()
        }
        return expectation
    }
}
