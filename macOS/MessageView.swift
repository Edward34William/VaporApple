import SwiftUI
import Kingfisher
import ComposableArchitecture

struct MessageView: View {
    
    let store: Store<MessageState, MessageAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(spacing: 0) {
                ScrollView {
                    // Add the new scroll view reader as a child to the scrollview
                    ScrollViewReader { scrollView in
                        VStack(spacing: 12) {
                            ForEach(viewStore.messages, id: \.self) { message in
                                if message.msgType == .text {
                                    HStack {
                                        Text(message.message)
                                            .foregroundColor(Color(NSColor.labelColor))
                                            .multilineTextAlignment(.leading)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(Color(NSColor.windowBackgroundColor))
                                            .cornerRadius(4)
                                            Spacer()
                                    }
                                } else {
                                    HStack {
                                        KFImage(message.urlString.toURL())
                                            .resizable()
                                            .loadImmediately()
                                            .cornerRadius(10)
                                            .frame(width: 180, height: 120, alignment: .leading)
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .padding()
                        // Add a listener to the messages array to listen for changes
                        .onReceive(viewStore.messages.publisher) { _ in
                            // Add animation block to animate in new message
                            withAnimation {
                                scrollView.scrollTo(viewStore.messages.endIndex - 1)
                            }
                        }
                    }
                }
                
                TextField("Aa", text: viewStore.binding(get: \.composedMessage, send: MessageAction.changeTextNewMesage), onCommit: {
                    viewStore.send(.sendNewMessage)
                })
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.title3)
                    .background(Color.clear)
                    .multilineTextAlignment(.leading)
                    .padding(.all, 20)
            }
            .onAppear(perform: {
                viewStore.send(.loadFirstMessage)
            })
            .background(Color(NSColor.controlBackgroundColor))
            .navigationTitle("Chat Vapor")
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(store: Store(initialState: MessageState(), reducer: messageReducer, environment: MessageEnvironment()))
    }
}
