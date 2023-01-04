import Combine

extension Publisher {
    func sink() -> Cancellable {
        sink(receiveCompletion: { _ in }, receiveValue: { _ in })
    }
}
