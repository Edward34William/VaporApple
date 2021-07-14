import Foundation
import ComposableArchitecture


let authReducer = Reducer<AuthState, AuthAction, AuthEnviroment>.combine(
    .init() { state, action, environment in
        switch action {
        case .signInAction:
            
            break
        case .signUpAction:
            
            break
        case .resetPasswordAction(_):
            break
        }
        return .none
    },
    
    signInReducer
        .pullback(state: \.signInState, action: /AuthAction.signInAction, environment: { _ in
            .init()
        }),
    signUpReducer
        .pullback(state: \.signUpState, action: /AuthAction.signUpAction, environment: { _ in
            .init()
        }),
    resetPasswordReducer
        .pullback(state: \.resetPasswordState, action: /AuthAction.resetPasswordAction, environment: { _ in
            .init()
        })
).debugActions(" 🟢 AuthScreen", actionFormat: ActionFormat.prettyPrint)
