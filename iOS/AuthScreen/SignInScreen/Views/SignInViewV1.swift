import SwiftUI
import ComposableArchitecture

struct SignInViewV1: View {
    
}

struct SignInViewV1_Previews: PreviewProvider {
    static var previews: some View {
        SignInViewV1(store: Store(initialState: SignInState(), reducer: signInReducer, environment: SignInEnviroment()))
    }
}
