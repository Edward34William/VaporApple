import ComposableArchitecture
import Foundation

let rootReducer = Reducer<RootState, RootAction, RootEnvironment>.combine(

    authReducer.pullback(state: /RootState.authState, action: /RootAction.authAction, environment: { _ in 
        AuthEnvironment()
    }),
    
    mainReducer.pullback(state: /RootState.mainState, action: /RootAction.mainAction, environment: { _ in
        .init()
    }),

    Reducer { state, action, environment in
        
        switch action {
        case .authAction(.signInAction(.signInSuccess)):
            state = .mainState(.init())
            break
        default:
            break
        }
        
        return .none
    }
    
)
