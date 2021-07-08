import Foundation
import Combine
import Logging

public func debugLog(_ object: Any? = nil, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    let className = (fileName as NSString).lastPathComponent
    print(" ⚠️ <\(className)> \(functionName) [#\(lineNumber)] \n\(object ?? "Nil")\n")
}

let logger = Logger(label: "⚠️ Vapor")

public func parsingObject<T: Decodable>(_ data: Any?, type: T.Type) -> T? {
    guard let data = data else { return nil }
    
    do {
        let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        
        let object = try JSONDecoder().decode(type, from: data)
        
        return object
    } catch {
        return nil
    }
}


