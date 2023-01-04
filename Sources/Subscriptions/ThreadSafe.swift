import Foundation

@propertyWrapper
final class ThreadSafe<Wrapped> {
    private let lock = Lock()
    private var value: Wrapped
    
    var wrappedValue: Wrapped {
        get {
            lock.lock()
            defer { lock.unlock() }
            return value
        }
        set {
            lock.lock()
            defer { lock.unlock() }
            value = newValue
        }
    }
    
    init(wrappedValue: Wrapped) {
        value = wrappedValue
    }
}
