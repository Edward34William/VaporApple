import Foundation

enum AuthAction: Equatable {
    case signInAction(SignInAction)
    case signUpAction(SignUpAction)
}
