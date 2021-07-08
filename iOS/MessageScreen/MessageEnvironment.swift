import Foundation
import ComposableArchitecture

class MessageEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue> = .main
    var socketMessage: RootWebSocket?
}
