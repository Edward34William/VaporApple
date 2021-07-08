import SwiftUI
import ComposableArchitecture

struct AuthView: View {
    
    let store: Store<AuthState, AuthAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                Color.white.ignoresSafeArea()
                if viewStore.state.appState.authScreen == .signIn {
                    SignInView(store: self.store.scope(state: \.signInState, action: AuthAction.signInAction))
                } else if viewStore.state.appState.authScreen == .signUp {
                    SignUpView(store: self.store.scope(state: \.signUpState, action: AuthAction.signUpAction))
                } else {
                    ResetPasswordView(store: self.store.scope(state: \.resetPasswordState, action: AuthAction.resetPasswordAction))
                }
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(store: Store(initialState: AuthState(), reducer: authReducer, environment: AuthEnviroment()))
    }
}
