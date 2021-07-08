import ComposableArchitecture
import SwiftUI

struct ProfileView: View {
    let store: Store<ProfileState, ProfileAction>

    var body: some View {
        WithViewStore(self.store) { _ in
            Text("Hello, World!")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(store: Store(initialState: ProfileState(), reducer: profileReducer, environment: ProfileEnvironment()))
    }
}
