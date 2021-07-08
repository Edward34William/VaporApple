import SwiftUI
import ComposableArchitecture
import Kingfisher

struct ConversationView: View {
    
    let store: Store<ConversationState, ConversationAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in

        }
        
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(store: Store(initialState: ConversationState(), reducer: conversationReducer, environment: ConversationEnvironment()))
    }
}
