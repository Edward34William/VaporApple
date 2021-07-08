import SwiftUI
import Kingfisher
import ComposableArchitecture

struct NotificationMessageView: View {
    
    let store: Store<NotificationMessageState, NotificationMessageAction>
    
    var body: some View {
        WithViewStore(store) {viewStore in
            VStack {
                Spacer(minLength: 20)
                HStack() {
                    KFImage(viewStore.message?.user.urlString.toURL())
                        .loadImmediately(true)
                        .resizable()
                        .placeholder {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .foregroundColor(Color.gray)
                        }
                        .aspectRatio(contentMode: ContentMode.fill)
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(20)
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Text(viewStore.message?.user.username ?? "")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            Spacer()
                            Text("11:30")
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
                        }

                        Text(viewStore.message?.message ?? "")
                            .lineLimit(2)
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    }
                }
                .padding(15)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 110)
            .background(Color("facebook"))
            .onTapGesture {
                viewStore.send(.tapGesture)
            }
        }
    }
}

struct NotificationMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationMessageView(store: Store(initialState: NotificationMessageState(), reducer: notificationMessageReducer, environment: NotificationMessageEnvironment()))
    }
}
