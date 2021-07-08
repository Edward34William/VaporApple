import SwiftUI
import ComposableArchitecture

struct AuthView: View {
    
    let store: Store<AuthState, AuthAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            SignInView(store: self.store.scope(state: \.signInState, action: AuthAction.signInAction))
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(store: Store(initialState: AuthState(), reducer: authReducer, environment: AuthEnvironment()))
    }
}
