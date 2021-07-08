import ComposableArchitecture
import SwiftUI
import Kingfisher

struct ConversationSettingView: View {
    let store: Store<ConverstionSettingState, ConversationSettingAction>
    
    @State var isOn: Bool = true
    var previewOptions: [String] = ["Always", "When Unlocked", "Never"]
    var previewUsers: [String] = ["Mike", "Andrey", "john"]
    @State private var previewIndex = 0
    
    init(store: Store<ConverstionSettingState, ConversationSettingAction>) {
        self.store = store
        UITableView.appearance().backgroundColor = .systemGray6
    }
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Form {
                    Section(header: VStack {
                        Spacer().frame(height: 30)
                        HStack {
                            Spacer()
                            KFImage(viewStore.conversation?.urlString.toURL())
                                .loadImmediately(true)
                                .resizable()
                                .placeholder {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 100, height: 100, alignment: .center)
                                        .foregroundColor(Color.gray)
                                }
                                .frame(width: 100, height: 100, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 4)

                            Spacer()
                        }
                    }
                    .foregroundColor(Color(.clear))
                    .background(Color(.clear))) {}
                    Section(header: Text("Infomation")) {
                        NavigationLink(destination: VaporEmptyView()) {
                            HStack {
                                Text("Conversation Name")
                                Spacer()
                                Text("IOS")
                            }
                        }
                        NavigationLink(destination: VaporEmptyView()) {
                            HStack {
                                Text("Admin")
                                Spacer()
                                Text("Packard")
                            }
                        }
                        
                        NavigationLink(destination: ConversationGroupMemberView(store: Store(initialState: ConversationGroupMemberState(),
                                                                                             reducer: conversationGroupMemberReducer,
                                                                                             environment: ConversationGroupMemberEnvironment()))) {
                            Text("Group Member")
                            Spacer()
                        }
                    }
                    
                    Section(header: Text("Notification")) {
                        Toggle("Enabled", isOn: $isOn)
                        Picker(selection: $previewIndex, label: Text("Show Previews")) {
                            ForEach(0 ..< previewOptions.count) {
                                Text(self.previewOptions[$0])
                            }
                        }
                    }
                    
                    Section(header: Text("Shared")) {
                        NavigationLink(destination: VaporEmptyView()) {
                            Text("File")
                            Spacer()
                        }
                        NavigationLink(destination: VaporEmptyView()) {
                            Text("Image")
                            Spacer()
                        }
                        NavigationLink(destination: VaporEmptyView()) {
                            Text("Video")
                            Spacer()
                        }
                    }
                    
                    Section {
                        HStack(alignment: .center, spacing: 10, content: {
                            Spacer()
                            Button(action: {

                            }, label: {
                                Text("Leave Group")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("facebook"))
                            })
                            Spacer()
                        })
                    }
                }
            }
            .navigationTitle("Setting")
        }
    }
}

struct ConversationSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationSettingView(store: Store(initialState: ConverstionSettingState(), reducer: conversationSettingReducer, environment: ConversationSettingEnvironment()))
    }
}
