import Foundation
import ComposableArchitecture
import Alamofire
import AnyRequest


let signUpReducer = Reducer<SignUpState, SignUpAction, SignUpEnviroment> { state, action, _ in
    
    switch action {
    
    case .signUpRequest:
        state.appState.isLoading = true
        let userInput = UserSignUp(email: state.email, password: state.password, username: state.username)
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/users/signUp")
            MethodRequest(.post)
            HttpBody(userInput.toData())
            Encoding(encoding: JSONEncoding.default)
        }
        return request.compactMap{$0.data}.map(SignUpAction.signUpSuccess).eraseToEffect()
    case .signUpSuccess(let data):
        state.appState.isLoading = false
        if let vaporError = data.toJson().toModel(VaporError.self) {
            debugLog(vaporError.toJson())
        } else {
            if let seesion = data.toModel(Seesion.self) {
                state.appState.seesion = seesion
                state.appState.rootScreen = .app
            }
        }
    case .changeToSignInView:
        state.appState.authScreen = .signIn
        break
    case .changeTextFieldEmail(let email):
        state.email = email
    case .changeTextFieldPassword(let password):
        state.password = password
    case .changeTextFieldUsername(let username):
        state.username = username
    }
    
    return .none
}
