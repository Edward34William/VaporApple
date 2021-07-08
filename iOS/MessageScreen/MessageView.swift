import Combine
import ComposableArchitecture
import Kingfisher
import SwiftUI

struct MessageView: View {
    let store: Store<MessageState, MessageAction>
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    
    init(store: Store<MessageState, MessageAction>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(alignment: .center, spacing: 0, content: {
                List {
                    ForEachStore(self.store.scope(state: \.messages, action: MessageAction.node)) { childStore in
                        WithViewStore(childStore) { childViewStore in
                            Group {
                                if childViewStore.msgType == .text {
                                    VStack {
                                        HStack(alignment: .top) {
                                            KFImage(childViewStore.user.urlString.toURL())
                                                .resizable()
                                                .loadImmediately()
                                                .placeholder({
                                                    Image(systemName: "person.circle.fill")
                                                        .resizable()
                                                        .frame(width: 30, height: 30, alignment: .center)
                                                        .foregroundColor(Color.gray)
                                                })
                                                .foregroundColor(Color.gray)
                                                .cornerRadius(30)
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .onTapGesture {
                                                    print(#line)
                                                }
                                            Text(childViewStore.user.username)
                                            Spacer()
                                        }
                                        .padding(.leading, -10)
                                        .offset(y: 10)
                                        .zIndex(1)
                                        HStack {
                                            Text(childViewStore.message)
                                                .font(.body)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 8)
                                                .foregroundColor(Color.white)
                                                .multilineTextAlignment(.leading)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 30)
                                                        .strokeBorder()
                                                        .foregroundColor(Color("facebook"))
                                                        .clipShape(Capsule()))
                                                .background(Color("facebook"))
                                                .cornerRadius(10)
                                                .lineLimit(nil)
                                            Spacer()
                                        }
                                        .padding(.leading, 10)
                                        .zIndex(0)
                                    }
                                } else {
                                    VStack {
                                        HStack(alignment: .top) {
                                            KFImage(childViewStore.user.urlString.toURL())
                                                .resizable()
                                                .loadImmediately()
                                                .placeholder({
                                                    Image(systemName: "person.circle.fill")
                                                        .resizable()
                                                        .frame(width: 30, height: 30, alignment: .center)
                                                        .foregroundColor(Color.gray)
                                                })
                                                .foregroundColor(Color.gray)
                                                .cornerRadius(30)
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .onTapGesture {
                                                    print(#line)
                                                }
                                            Text(childViewStore.user.username)
                                            Spacer()
                                        }
                                        .padding(.leading, -10)
                                        .offset(y: 10)
                                        .zIndex(1)
                                        HStack {
                                            KFImage(childViewStore.urlString.toURL())
                                                .resizable()
                                                .loadImmediately()
                                                .cornerRadius(10)
                                                .frame(width: 180, height: 120, alignment: .leading)
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .onAppear {
                                if childViewStore.state == viewStore.messages.last && viewStore.messages.count >= 10 {
                                    viewStore.send(.loadMoreMessage)
                                }
                            }
                            .onDisappear {
                                viewStore.send(.onDisappear)
                            }
                        }
                    }
                    if viewStore.haveUserTyping {
                        HStack {
                            ThreeDotTypingView()
                                .frame(width: 100, height: 30, alignment: .leading)
                            Spacer()
                        }
                        .frame(height: 30)
                    }
                }
                .listStyle(PlainListStyle())
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.white)
                        .frame(height: 50, alignment: .center)
                    HStack {
                        Button(action: {
                            isShowPhotoLibrary = true
                        }, label: {
                            Image(systemName: "folder.fill")
                                .resizable()
                                .foregroundColor(Color("facebook"))
                                .frame(width: 20, height: 20, alignment: .center)
                        })
                        .padding(.leading, -20)
                        .padding(.trailing, 15)
                        
                        TextField("Aa", text: viewStore.binding(get: \.composedMessage, send: MessageAction.changeTextNewMesage), onCommit: { viewStore.send(.sendNewMessage) })
                            .frame(minHeight: 40)
                            .disableAutocorrection(true)
                            .overlay(RoundedRectangle(cornerRadius: 45/2).stroke(Color.primary, lineWidth: 0.5).frame(height: 45).padding(-15))
                        Button(action: {
                            viewStore.send(MessageAction.sendNewMessage)
                        }, label: {
                            Image(systemName: "arrow.up.circle.fill")
                                .resizable()
                                .foregroundColor(Color("facebook"))
                                .frame(width: 30, height: 30, alignment: .center)
                        })
                        .padding(.leading, 20)
                    }
                    .padding(10)
                    .foregroundColor(Color("facebook"))
                    .frame(minHeight: 50).padding()
                }
            })
            .onAppear(perform: {
                viewStore.send(MessageAction.loadFirstMessage)
            })
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker { image in
                    // upload to server vapor
                    if !viewStore.appState.isLoading {
                        let uploadImage = image
                            .scalePreservingAspectRatio(targetSize: CGSize(width: 200, height: 200))
                            .pngData()!
                        viewStore.send(MessageAction.uploadImage(uploadImage))
                    }
                }
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(store: Store(initialState: MessageState(currentConversation: Conversation(id: UUID(), name: "Mike Packer", urlString: "", descriptionConversation: "")),
                                 reducer: messsageReduer,
                                 environment: MessageEnvironment()))
    }
}
