import ComposableArchitecture
import Kingfisher
import SwiftUI

struct ProfileUserView: View {
    let store: Store<ProfileUserState, ProfileUserAction>
    
    @State var isOn: Bool = true
    @State private var notificationIndex = 0
    @State private var onlineStatusIndex = 0
    @State private var themeIndex = 0
    
    var notification: [String] = ["Always", "When Unlocked", "Never"]
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            Form {
                Section(header: Spacer().frame(height: 20), footer: HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        KFImage(viewStore.user?.urlString.toURL())
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
                        Text(verbatim: viewStore.user?.username ?? "Anonymous")
                            .fontWeight(.bold)
                            .bold()
                            .padding(.top, 15)
                    }
                    Spacer()
                }) {}
                Section(header: Text("Infomation")) {
                    NavigationLink(
                        destination: Text("Vapor"),
                        label: {
                            Text("About")
                        })
                    
                    HStack {
                        Text("Email")
                        Spacer()
                        Text(viewStore.user?.email ?? "")
                    }
                    
                    HStack {
                        Text("Username")
                        Spacer()
                        Text(viewStore.user?.username ?? "Anonymous")
                    }
                    
                    HStack {
                        Text("Position")
                        Spacer()
                        Text("iOS Engineer")
                    }
                    
                    HStack {
                        Text("Group")
                        Spacer()
                        Text("Mobile")
                    }
                    
                    HStack {
                        Text("Phone number")
                        Spacer()
                        Text("+84123456789")
                    }
                }
                
                Section(header: Text("Notification")) {
                    Toggle("Enabled", isOn: $isOn)
                    Picker(selection: $notificationIndex, label: Text("Show Previews")) {
                        ForEach(0 ..< notification.count) {
                            Text(self.notification[$0])
                        }
                    }
                }
                HStack(alignment: .center, spacing: 10, content: {
                    Spacer()
                    Button(action: {}, label: {
                        Text("Friend")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color("facebook"))
                    })
                    Spacer()
                })
            }
            .navigationBarTitle(Text("User Infomation"), displayMode: .inline)
        }
    }
}

struct ProfileUserView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUserView(store: Store(initialState: ProfileUserState(user: nil), reducer: profileUserReducer, environment: ProfileUserEnviroment()))
    }
}
