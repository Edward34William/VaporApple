import AppKit
import ComposableArchitecture
import Kingfisher
import SwiftUI

struct MainView: View {
    let store: Store<MainState, MainAction>
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.conversations) { conversation in
                        NavigationLink(destination: MessageView(store: self.store.scope(state: \.messageState, action: MainAction.messageAction)), tag: conversation.id, selection: viewStore.binding(
                            get: \.selection?.id,
                            send: MainAction.setNavigation(selection:)
                        )) {
                            HStack {
                                KFImage(conversation.urlString?.toURL())
                                    .resizable()
                                    .loadImmediately()
                                    .cornerRadius(40)
                                    .frame(width: 40, height: 40, alignment: .leading)
                                VStack(alignment: .leading, spacing: 2) {
                                    HStack(alignment: .center) {
                                        Text(conversation.name ?? "")
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
                .listStyle(SidebarListStyle())
                .navigationTitle("Vapor Apple")

                Text("Empty")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .onAppear {
                viewStore.send(.getConversation)
            }
            .navigationTitle("Messages")
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: {
                        toggleSidebar()
                    }) {
                        Image(systemName: "sidebar.left")
                    }
                }

                ToolbarItem(placement: .navigation) {
                    Button(action: {}) {
                        Image(systemName: "square.and.pencil")
                    }
                }

                ToolbarItem(placement: .status) {
                    Button(action: {}) {
                        Image(systemName: "info.circle")
                    }
                }
            }
        }
    }
}

private func toggleSidebar() {
    #if os(iOS)
    #else
    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    #endif
}
