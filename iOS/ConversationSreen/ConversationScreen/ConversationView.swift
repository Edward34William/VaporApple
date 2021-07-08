import ComposableArchitecture
import ConvertSwift
import Kingfisher
import SwiftUI

struct ConversationView: View {
    let store: Store<ConversationState, ConversationAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                VStack(alignment: .center, spacing: 0) {
                    List {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(0 ..< 10) {_ in
                                    AvatarUserView(isOnline: .constant(true), urlString: viewStore.appState.seesion.user.urlString)
                                        .frame(width: 50, height: 50, alignment: .center)
                                }
                            }
                        }
                        .padding([.trailing, .leading], -20)
                        .padding([.top, .bottom], 10)

                        ForEachStore(self.store.scope(state: \.conversations, action: ConversationAction.node)) { childStore in
                            ConversationItemView(store: childStore)
                        }
                    }
                    .onAppear(perform: {
                        viewStore.send(.getConversation)
                    })
                    .listStyle(GroupedListStyle())
                }
                .navigationBarTitle(Text("Chat"), displayMode: .inline)
                .navigationBarItems(leading: HStack {
                    Button(action: {
                        viewStore.send(.changeMainScreen(.setting))
                    }, label: {
                        HStack(alignment: .top) {
                            KFImage(viewStore.appState.seesion.user.urlString.toURL())
                                .resizable()
                                .loadImmediately()
                                .placeholder {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .foregroundColor(Color.gray)
                                }
                                .foregroundColor(Color.gray)
                                .cornerRadius(30)
                                .frame(width: 30, height: 30, alignment: .leading)
                        }
                    })
                }, trailing: HStack {
                    Button(action: {
                        viewStore.send(.changeMainScreen(.newConversation))
                    }, label: {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(Color("facebook"))
                    })
                })
            }
        }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(store: Store(initialState: ConversationState(), reducer: conversationReducer, environment: ConversationEnvironment()))
    }
}
