import ComposableArchitecture
import SwiftUI

struct FriendRequestView: View {
    
    var store: Store<FriendRequestState, FriendRequestAction>
    
    var body: some View {
        VaporEmptyView()
    }
}

struct FriendRequestView_Previews: PreviewProvider {
    static var previews: some View {
        FriendRequestView(store: Store(initialState: FriendRequestState(), reducer: friendRequestReducer, environment: FriendRequestEnvironment()))
    }
}
