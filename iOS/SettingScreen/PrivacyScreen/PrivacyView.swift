import SwiftUI
import ComposableArchitecture

struct PrivacyView: View {
    
    let store: Store<PrivacyState, PrivacyAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VaporEmptyView()
        }
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView(store: Store(initialState: PrivacyState(), reducer: privacyReducer, environment: PrivacyEnvironment()))
    }
}
