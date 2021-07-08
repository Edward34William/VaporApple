import SwiftUI
import ComposableArchitecture

struct ConversationGroupMemberView: View {
    
    let store: Store<ConversationGroupMemberState, ConversationGroupMemberAction>
    
    var body: some View {
        WithViewStore(store) {viewStore in
            VaporEmptyView()
        }
    }
}

struct ConversationGroupMemberView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationGroupMemberView(store: Store(initialState: ConversationGroupMemberState(),
                                                 reducer: conversationGroupMemberReducer,
                                                 environment: ConversationGroupMemberEnvironment()))
    }
}
