import Foundation

enum SignInAction: Equatable {
    case changeTextFieldUsername(String)
    case changeTextFieldPassword(String)
    case signInRequest
    case signInSuccess(Data)
    case changeToSignUpView
    case changeToResetPasswordView
}
