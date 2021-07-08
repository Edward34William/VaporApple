import Foundation

enum SignUpAction: Equatable {
    case changeTextFieldEmail(String)
    case changeTextFieldPassword(String)
    case changeTextFieldUsername(String)
    case signUpRequest
    case signUpSuccess(Data)
    case changeToSignInView
}
