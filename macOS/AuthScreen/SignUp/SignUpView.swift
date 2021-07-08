import SwiftUI
import ComposableArchitecture

struct SignUpView: View {
    
    let store: Store<SignUpState, SignUpAction>
    
    var body: some View {
        WithViewStore(self.store) {viewStore in
            
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(store: Store(initialState: SignUpState(), reducer: signUpReducer, environment: SignUpEnvironment()))
    }
}
