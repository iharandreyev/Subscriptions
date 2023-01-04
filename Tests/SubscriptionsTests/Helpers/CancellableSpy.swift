import Combine

final class CancellableSpy: Cancellable {
    private let cancellable: Cancellable
    private(set) var cancelCalled: Int = 0
    
    init(_ cancellable: Cancellable) {
        self.cancellable = cancellable
    }

    func cancel() {
        cancelCalled += 1
        cancellable.cancel()
    }
}
