import SwiftUI
import ComposableArchitecture

struct MessageRequestView: View {
    
    let store: Store<MessageRequestState, MessageRequestAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VaporEmptyView()
        }
    }
}

struct MessageRequestView_Previews: PreviewProvider {
    static var previews: some View {
        MessageRequestView(store: Store(initialState: MessageRequestState(), reducer: messageRequestReducer, environment: MessageRequestEnvironment()))
    }
}
