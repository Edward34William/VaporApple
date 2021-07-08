import SwiftUI
import Kingfisher
import ComposableArchitecture

struct ConversationItemView: View {
    
    let store: Store<Conversation, ConversationItemAction>
    
    var body: some View {
        WithViewStore(self.store) {viewStore in
            ZStack {
                Color.white.ignoresSafeArea()
                HStack(alignment: .center, spacing: 10) {
                    KFImage(viewStore.urlString.toURL())
                        .loadImmediately(true)
                        .resizable()
                        .placeholder {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .foregroundColor(Color.gray)
                        }
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(20)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(viewStore.name)
                            .bold()
                            .font(.headline)
                            .foregroundColor(.black)
                        HStack {
                            Text(viewStore.descriptionConversation).font(.subheadline).foregroundColor(.gray)
                            Text("12:00").font(.caption).foregroundColor(.gray)
                        }
                    }
                    
                    Spacer()
                }

            }
            .onTapGesture {
                viewStore.send(.selected)
            }
        }
    }
}

struct ConversationItemView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationItemView(store: Store(initialState: Conversation(id: UUID(), name: "Mike Packard", urlString: "", descriptionConversation: "description"), reducer: conversationItemReducer, environment: ConversationItemEnviroment()))
    }
}
