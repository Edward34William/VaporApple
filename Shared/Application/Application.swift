import Foundation

public final class Application {
    public var storage: Storage

    init() {
        self.storage = Storage(storage: [:])
    }
}

public protocol StorageKey {
    associatedtype Value
}

protocol AnyStorageValue {}

struct Value<T>: AnyStorageValue {
    var value: T
}

public struct Storage {
    var storage: [ObjectIdentifier: AnyStorageValue]

    init(storage: [ObjectIdentifier: AnyStorageValue] = [:]) {
        self.storage = storage
    }

    public mutating func clear() {
        self.storage = [:]
    }

    public subscript<Key>(_ key: Key.Type) -> Key.Value? where Key: StorageKey {
        get {
            self.get(Key.self)
        }
        set {
            self.set(Key.self, to: newValue)
        }
    }

    public func contains<Key>(_ key: Key.Type) -> Bool {
        self.storage.keys.contains(ObjectIdentifier(Key.self))
    }

    public func get<Key>(_ key: Key.Type) -> Key.Value? where Key: StorageKey {
        guard let value = self.storage[ObjectIdentifier(Key.self)] as? Value<Key.Value> else {
            return nil
        }
        return value.value
    }

    public mutating func set<Key>(_ key: Key.Type, to value: Key.Value?, onShutdown: ((Key.Value) throws -> ())? = nil) where Key: StorageKey {
        
    }
}
