import Foundation
import Alamofire
import AnyRequest
import ComposableArchitecture

let signInReducer = Reducer<SignInState, SignInAction, SignInEnviroment> {state, action, _ in
    
    switch action {
    case .changeTextFieldUsername(let username):
        state.username = username
        return .none
    case .changeTextFieldPassword(let password):
        state.password = password
        return .none
    case .signInRequest:
        state.appState.isLoading = true
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/users/signIn")
            MethodRequest(.post)
            Headers(headers: HTTPHeaders([HTTPHeader.authorization(username: state.username, password: state.password)]))
            Encoding(encoding: JSONEncoding.default)
        }
        return request.compactMap {$0.data}.compactMap(SignInAction.signInSuccess).eraseToEffect()
    case .signInSuccess(let data):
        debugLog(data.toJson())
        state.appState.isLoading = false
        if let error = data.toModel(VaporError.self) {
            debugLog(error.toJson())
        } else {
            if let seesion = data.toModel(Seesion.self) {
                state.appState.seesion = seesion
                state.appState.rootScreen = .app
            }
        }
    case .changeToSignUpView:
        state.appState.authScreen = .signUp
    case .changeToResetPasswordView:
        state.appState.authScreen = .resetPassword
    }
    return .none
}.debug()
