import ComposableArchitecture
import Kingfisher
import SwiftUI

struct ConversationItemView: View {
    let store: Store<Conversation, ConversationItemAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack {
                KFImage(viewStore.urlString?.toURL())
                    .resizable()
                    .loadImmediately()
                    .cornerRadius(40)
                    .frame(width: 40, height: 40, alignment: .leading)
                    .onTapGesture {
                        viewStore.send(.selected)
                    }
                VStack(alignment: .leading, spacing: 2) {
                    HStack(alignment: .center) {
                        Text(viewStore.name ?? "")
                            .font(.headline)
                        Spacer()
                        Text("9:41 AM")
                            .font(.callout)
                    }

                    Text("message")
                        .font(.callout)
                        .lineLimit(1)
                }
            }
            .padding(.leading, 1)
        }
    }
}

struct ConversationItemView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationItemView(store: Store(initialState: Conversation(), reducer: conversationItemReducer, environment: ConversationItemEnvironment()))
    }
}
