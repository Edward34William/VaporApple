import ComposableArchitecture
import Kingfisher
import SwiftUI
struct SettingView: View {
    let store: Store<SettingState, SettingAction>
    
    @State private var image: UIImage? = nil
    
    @State private var isShowPhotoLibrary = false
    
    @State var isOnNotification = true
    @State var inOnFaceOrTouchID = true
    @State private var notificationIndex = 0
    @State private var onlineStatusIndex = 0
    @State private var languegeIndex = 0
    @State private var themeIndex = 0
    
    var notification: [String] = ["Always", "When Unlocked", "Never"]
    var onlineStatus: [String] = ["Online", "Off"]
    var languague: [String] = ["English", "Vietnam"]
    var theme: [String] = ["Light", "Dark"]
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                Form {
                    Section(header: Spacer().frame(height: 20), footer: HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            KFImage(viewStore.appState.seesion.user.urlString.toURL())
                                .loadImmediately(true)
                                .resizable()
                                .placeholder {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .foregroundColor(Color.gray)
                                }
                                .frame(width: 120, height: 120, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 4)
                                .onTapGesture {
                                    isShowPhotoLibrary = true
                                }
                                .sheet(isPresented: $isShowPhotoLibrary) {
                                    ImagePicker { image in
                                        self.image = image
                                        if let data = image.scalePreservingAspectRatio(targetSize: CGSize(width: 200, height: 200)).pngData() {
                                            viewStore.send(.uploadImage(data))
                                        }
                                    }
                                }
                            Text(verbatim: viewStore.state.appState.seesion.user.username)
                                .fontWeight(.bold)
                                .bold()
                                .padding(.top, 15)
                        }
                        Spacer()
                    }) {}
                    Section(header: Text("Infomation")) {
                        NavigationLink(
                            destination: AccountInfoView(store: Store(initialState: AccountInfoState(), reducer: accountInfoReducer, environment: AccountInfoEnvironment())),
                            label: {
                                Text("Account")
                            })
                        
                        NavigationLink(
                            destination: MessageRequestView(store: Store(initialState: MessageRequestState(), reducer: messageRequestReducer, environment: MessageRequestEnvironment())),
                            label: {
                                HStack {
                                    Text("Message Request")
                                    Spacer()
                                    ZStack {
                                        Circle()
                                            .fill(Color.red)
                                            .frame(width: 30, height: 30, alignment: .center)
                                        Text("35")
                                            .foregroundColor(Color.white)
                                    }
                                }
                            })
                        
                        NavigationLink(
                            destination: FriendRequestView(store: Store(initialState: FriendRequestState(), reducer: friendRequestReducer, environment: FriendRequestEnvironment())),
                            label: {
                                HStack {
                                    Text("Friend Request")
                                    Spacer()
                                    ZStack {
                                        Circle()
                                            .fill(Color.red)
                                            .frame(width: 30, height: 30, alignment: .center)
                                        Text("1")
                                            .foregroundColor(Color.white)
                                    }
                                }
                            })
                    }
                    
                    Section(header: Text("Notification")) {
                        Toggle("Allow Push Notifications", isOn: $isOnNotification)
                        Picker(selection: $notificationIndex, label: Text("Show Previews")) {
                            ForEach(0 ..< notification.count) {
                                Text(self.notification[$0])
                            }
                        }
                    }
                    
                    Section(header: Text("App Settings")) {
                        Picker(selection: $themeIndex, label: Text("Theme")) {
                            ForEach(0 ..< theme.count) {
                                Text(self.theme[$0])
                            }
                        }
                        
                        Picker(selection: $onlineStatusIndex, label: Text("Online Status")) {
                            ForEach(0 ..< onlineStatus.count) {
                                Text(self.onlineStatus[$0])
                            }
                        }
                        
                        Picker(selection: $languegeIndex, label: Text("Language")) {
                            ForEach(0 ..< languague.count) {
                                Text(self.languague[$0])
                            }
                        }
                        Toggle("Enable Face/Touch ID", isOn: $inOnFaceOrTouchID)
                    }
                    
                    Section(header: Text("App Infomation")) {
                        HStack {
                            Text("App Version")
                            Spacer()
                            Text("0.0.1 Beta")
                                .foregroundColor(Color.gray)
                        }
                        
                        HStack {
                            Text("Server Version")
                            Spacer()
                            Text("0.0.1 Beta")
                                .foregroundColor(Color.gray)
                        }
                        
                        NavigationLink(
                            destination: PrivacyView(store: Store(initialState: PrivacyState(), reducer: privacyReducer, environment: PrivacyEnvironment())),
                            label: {
                                Text("Privacy")
                                Spacer()
                            })

                        NavigationLink(
                            destination: ContactUsView(store: Store(initialState: ContactUsState(), reducer: contactUsReducer, environment: ContactUsEnvironment())),
                            label: {
                                HStack {
                                    Text("Contact Us")
                                    Spacer()
                                }
                            })
                        
                        NavigationLink(
                            destination: SendFeedbackView(store: Store(initialState: SendFeedbackState(), reducer: sendFeedbackReducer, environment: SendFeedbackEnvironment())),
                            label: {
                                HStack {
                                    Text("Send Feedback")
                                    Spacer()
                                }
                            })
                    }
                    
                    Section {
                        HStack(alignment: .center, spacing: 10, content: {
                            Spacer()
                            Button(action: {
                                viewStore.send(.logout)
                            }, label: {
                                Text("Logout")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("facebook"))
                            })
                            Spacer()
                        })
                    }
                }
                .navigationBarTitle(Text("Setting"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    viewStore.send(.done)
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color("facebook"))
                }))
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(store: Store(initialState: SettingState(), reducer: settingReducer, environment: SettingEnvironment()))
    }
}
