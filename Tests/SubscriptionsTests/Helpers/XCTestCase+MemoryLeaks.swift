import XCTest

extension XCTestCase {
    func trackForMemoryLeaks<Instance: AnyObject>(
        _ instance: Instance,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "\(Instance.self) is probably leaking",
                file: file,
                line: line
            )
        }
    }
}
