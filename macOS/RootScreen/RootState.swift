import Foundation


enum RootState: Equatable {
    
    case authState(AuthState)
    case mainState(MainState)

    public init() {
        self = .authState(.init())
    }
    
}

class SharedState: Equatable {
    static func == (lhs: SharedState, rhs: SharedState) -> Bool {
        return lhs.appState.seesion.user.id == rhs.appState.seesion.user.id
    }
    
    var appState = AppState()
    
    static let shared = SharedState()
}

class AppState: Equatable {
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        return lhs.seesion.user.id == rhs.seesion.user.id
    }
    
    var isLoading = false
    var email: String = ""
    var username: String = ""
    var password: String = ""
    var seesion = Seesion()
}
