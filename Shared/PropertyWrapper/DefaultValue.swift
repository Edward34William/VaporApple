import Foundation

@propertyWrapper
public struct DefaultValue<Value> {
    
    private var value: Value?
    
    private let defaultValue: Value
    
    public var wrappedValue: Value {
        get {
            if let unboxed = value {
                return unboxed
            }
            
            return defaultValue
        }
        set {
            value = newValue
        }
    }
    
    public init(default: Value) {
        defaultValue = `default`
    }
}
