import ComposableArchitecture
import Kingfisher
import SwiftUI

struct MainView: View {
    let store: Store<MainState, MainAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                Color.white.ignoresSafeArea()
                if viewStore.state.mainScreen == .settingConversation {
                    NavigationView {
                        VaporEmptyView()
                            .navigationBarTitle(Text("settings message"), displayMode: .inline)
                            .navigationBarItems(leading:
                                HStack {
                                    Button(action: {}, label: {
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .foregroundColor(Color("facebook"))
                                    })
                                },
                                trailing: HStack {
                                    Button(action: {}, label: {
                                        Image(systemName: "gearshape")
                                            .resizable()
                                            .foregroundColor(Color("facebook"))
                                    })
                                })
                    }
                } else if viewStore.state.mainScreen == .setting {
                    SettingView(store: self.store.scope(state: \.settingState, action: MainAction.setting))
                } else if viewStore.state.mainScreen == .newNews {
                    NavigationView {
                        NewNewsView(store: self.store.scope(state: \.newNewsState, action: MainAction.newNewsAction))
                            .navigationBarTitle(Text("New Story"), displayMode: .inline)
                            .navigationBarItems(leading: HStack {
                                Button(action: {
                                    viewStore.send(.selectedScreen(.conversation))
                                }, label: {
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color("facebook"))
                                })
                            })
                    }
                } else if viewStore.state.mainScreen == .message {
                    NavigationView {
                        MessageView(store: self.store.scope(state: \.messageState, action: MainAction.messageAction))
                            .navigationBarTitle(Text(viewStore.conversationStateCached.currentConversation?.name ?? ""), displayMode: .inline)
                            .navigationBarItems(leading:
                                HStack {
                                    Button(action: {
                                        viewStore.send(.selectedScreen(.conversation))
                                    }, label: {
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .foregroundColor(Color("facebook"))
                                    })
                                },
                                trailing: HStack {
                                    NavigationLink(
                                        destination: ConversationSettingView(store: store.scope(state: \.conversationSettingState, action: MainAction.conversationSettingAction)),

                                        label: {
                                            Image(systemName: "gearshape")
                                                .resizable()
                                                .foregroundColor(Color("facebook"))
                                        })
                                    //                                                Button(action: {
                                    ////                                                    viewStore.send(.selectedScreen(.settingConversation))
                                    //
                                    //                                                }, label: {
                                    //
                                    //
                                    //                                                })
                                })
                        //                        .toolbar {
                        //                            ToolbarItem(placement: .automatic) {
                        //                                KFImage(viewStore.conversationStateCached.currentConversation.urlString?.toURL())
                        //                                    .resizable()
                        //                                    .clipShape(Circle())
                        //                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        //                                    .frame(width: 40, height: 40, alignment: .center)
                        //                            }
                        //                        }
                    }
                } else if viewStore.state.mainScreen == .newConversation {
                    NavigationView {
                        NewConversationView(store: self.store.scope(state: \.newConversationState, action: MainAction.newConversationAction))
                            .navigationBarTitle(Text("New Group Conversation"), displayMode: .inline)
                            .navigationBarItems(leading: HStack {
                                Button(action: {
                                    viewStore.send(.selectedScreen(.conversation))
                                }, label: {
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color("facebook"))
                                })
                            })
                    }
                } else {
                    TabView {
                        ConversationView(store: self.store.scope(state: \.conversationState, action: MainAction.conversation))
                            .onAppear {}

                            .tabItem {
                                Image(systemName: "message")
                                Text("Chat")
                            }

                        NavigationView {
                            PeopleView(store: self.store.scope(state: \.peopleState, action: MainAction.people))
                        }
                        .tabItem {
                            Image(systemName: "person.2")
                            Text("People")
                        }

//                        NewsView(store: self.store.scope(state: \.newsState, action: MainAction.news))
//                            .onAppear {}
//                            .tabItem {
//                                Image(systemName: "note.text")
//                                Text("Stories")
//                            }
                    }
                    .accentColor(Color("facebook"))
                }
            }
            .popup(isPresented: viewStore.binding(get: \.showNotificationMessage, send: MainAction.showNotificationMessage), type: .toast, position: .top) {
                NotificationMessageView(store: store.scope(state: \.notificationMessageState, action: MainAction.notificationMesageAction))
            }
            .onAppear {
                viewStore.send(.startSocketUserOnline)
                viewStore.send(.startSocketUserOn)
                viewStore.send(.startSocketConversation)
                viewStore.send(.startSocketUserTyping)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(store: Store(initialState: MainState(), reducer: mainReducer, environment: MainEnvironment()))
    }
}
