import Foundation
import SwiftUI
import ComposableArchitecture

struct RootView: View {
    
    let store: Store<RootState, RootAction>
    
    var body: some View {
        SwitchStore(self.store) {
            CaseLet(state: /RootState.authState, action: RootAction.authAction) { store in
                AuthView(store: store)
            }
            
            CaseLet(state: /RootState.mainState, action: RootAction.mainAction) { store in
                MainView(store: store)
            }
        }
        .frame(minWidth: 1000, idealWidth: 1000, maxWidth: .infinity, minHeight: 700, idealHeight: 700, maxHeight: .infinity, alignment: .center)
    }
}

struct Root_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: Store(initialState: RootState(), reducer: rootReducer, environment: RootEnvironment()))
    }
}
