import Foundation
import AnyRequest
import Alamofire
import ComposableArchitecture
import Json

let signInReducer = Reducer<SignInState, SignInAction, SignInEnviroment> {state, action, enviroment in
    
    switch action {
    case .changeTextFieldUsername(let username):
        state.username = username
        return .none
    case .changeTextFieldPassword(let password):
        state.password = password
        return .none
    case .signInRequest:
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/users/signIn")
            MethodRequest(.post)
            Headers(headers: HTTPHeaders([HTTPHeader.authorization(username: state.username, password: state.password)]))
            Encoding(encoding: JSONEncoding.default)
        }
        return request.compactMap {$0.data}.compactMap(SignInAction.signInSuccess).eraseToEffect()
    case .signInSuccess(let data):
        debugLog(data.toJson())
//        state.appState.isLoading = false
        if let error = data.toModel(VaporError.self) {
            debugLog(error.toJson())
        } else {
            if let seesion = data.toModel(Seesion.self) {
                SharedState.shared.appState.seesion = seesion
            }
        }
    case .changeToSignUpView:
        break
//        state.appState.authScreen = .signUp
    case .changeToResetPasswordView:
        break
//        state.appState.authScreen = .resetPassword
    }
    return .none
}.debug()

struct Seesion: Codable, Equatable {
    var token: String = ""
    var user: User = User()
}

struct User: Codable, Equatable , Identifiable{
    var username: String = ""
    var email: String = ""
    var id: String = ""
    var updatedAt: String = ""
    var createdAt: String = ""
    var urlString: String = ""
}

struct UserSignUp: Codable {
    var email: String = ""
    var password: String = ""
    var username: String = ""
    var urlString: String = ""
}
