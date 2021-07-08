import SwiftUI
import ComposableArchitecture

struct ContactUsView: View {
    
    let store: Store<ContactUsState, ContactUsAction>
    
    var body: some View {
        VaporEmptyView()
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView(store: Store(initialState: ContactUsState(), reducer: contactUsReducer, environment: ContactUsEnvironment()))
    }
}
