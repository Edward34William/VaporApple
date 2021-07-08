import Foundation

extension Optional {

  func or(_ default: Wrapped) -> Wrapped {
    return self ?? `default`
  }
  
  func or(else: @autoclosure () -> Wrapped) -> Wrapped {
    return self ?? `else`()
  }

  func or(else: () -> Wrapped) -> Wrapped {
    return self ?? `else`()
  }
  
  func or(throw exception: Error) throws -> Wrapped {
    guard let unwrapped = self else { throw exception }
    return unwrapped
  }
  
  var isNil: Bool {
    return self == nil
  }
  
  var isSome: Bool {
    return self != nil
  }
  
  var unWrapped: Wrapped {
    return self!
  }
  
  @discardableResult
  func ifIsSome(_ closure: (Wrapped) -> Void) -> Optional {
    isSome ? closure(unWrapped) : ()
    return self
    
  }
  
  @discardableResult
  func ifIsNil(_ closure: () -> Void) -> Optional {
    isNil ? closure() : ()
    return self
  }
}

extension Optional where Wrapped == Error {

  func or(_ else: (Error) -> Void) {
    guard let error = self else { return }
    `else`(error)
  }
}
