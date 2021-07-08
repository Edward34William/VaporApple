import Foundation

enum RootAction: Equatable {
    case signInAction(SignInAction)
    case signUpAction(SignUpAction)
    case mainAction(MainAction)
    case authAction(AuthAction)
    case logout
    case onAppear
}
