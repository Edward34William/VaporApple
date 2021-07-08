import Foundation

struct AuthState: Equatable {
    
    var appState = AppState()

    //MARK: - Properties
    var email: String = "admin"
    var username: String = "Admin"
    var password: String = "password"
    var resetPasswordWithEmail: String = ""
    
    var signInState: SignInState {
        get {
            SignInState(
                // - AppState
                appState: appState,
                // - Properties
                username: username,
                password: password
            )
        }
        
        set {
            // - AppState
            appState = newValue.appState
            // - Properties
            username = newValue.username
            password = newValue.password
        }
    }
    
    var signUpState: SignUpState {
        get {
            SignUpState(
                // - AppState
                appState: appState,
                // - Properties
                email: email,
                password: password,
                username: username
            )
        }
        
        set {
            // - AppState
            appState = newValue.appState
            // - Properties
            email = newValue.email
            username = newValue.username
            password = newValue.password
            
        }
        
    }
    
    var resetPasswordState: ResetPasswordState {
        get {
            ResetPasswordState(
                // - AppState
                appState: appState,
                // - Properties
                email: resetPasswordWithEmail
            )
        }
        
        set {
            // - AppState
            appState = newValue.appState
            // - Properties
            resetPasswordWithEmail = newValue.email
        }
    }
    
    
}

enum AuthScreen: Equatable {
    case signIn
    case signUp
    case resetPassword
}
