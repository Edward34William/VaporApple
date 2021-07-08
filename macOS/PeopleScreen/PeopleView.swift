import SwiftUI
import ComposableArchitecture

struct PeopleView: View {
    
    let store: Store<PeopleState, PeopleAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            EmptyView()
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView(store: Store(initialState: PeopleState(), reducer: peopleReducer, environment: PeopleEnvironment()))
    }
}
