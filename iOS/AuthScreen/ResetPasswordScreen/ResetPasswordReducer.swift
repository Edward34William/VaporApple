import ComposableArchitecture

let resetPasswordReducer = Reducer<ResetPasswordState, ResetPasswordAction, ResetPasswordEnviroment> {state, action, enviroment in
    switch action {
    case .changeTextFieldEmail(let text):
        state.email = text
    case .changeToSignIn:
        state.appState.authScreen = .signIn
    }
    return .none
}
