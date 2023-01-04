import Combine

final class CancellableSpy: Cancellable {
    private let cancelClosure: () -> Void
    private(set) var cancelCalled: Int = 0
    
    init(_ another: Cancellable) {
        cancelClosure = another.cancel
    }

    func cancel() {
        cancelCalled += 1
        cancelClosure()
    }
}
