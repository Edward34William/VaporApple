import Foundation

struct SharedState: Equatable {

    var appState = AppState()
}

struct AppState: Equatable {
    var isLoading = false
    var rootScreen: RootScreen = .auth
    var authScreen: AuthScreen = .signIn
    var seesion = Seesion()
}
