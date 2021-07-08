import ComposableArchitecture
import Kingfisher
import SwiftUI

struct NewConversationView: View {
    let store: Store<NewConversationState, NewConversationAction>

    @State private var isShowPhotoLibrary = false
    @State private var image: UIImage? = nil
    @State private var isOn: Bool = true

    var body: some View {
        WithViewStore(self.store) { viewStore in
            Form {
                Section(header: Spacer().frame(height: 20), footer: HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        if image == nil {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 200, height: 200, alignment: .center)
                                .foregroundColor(Color.gray)
                                .onTapGesture {
                                    isShowPhotoLibrary = true
                                }
                        } else {
                            image?.toImage()
                                .resizable()
                                .frame(width: 200, height: 200, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                                .onTapGesture {
                                    isShowPhotoLibrary = true
                                }
                        }
                    }
                    Spacer()
                }) {}

                Section(header: Text("Group Name")) {
                    TextField("Name", text: viewStore.binding(get: \.newConversation.name, send: NewConversationAction.changeTextFieldConversationName))
                    TextField("Description", text: viewStore.binding(get: \.newConversation.descriptionConversation, send: NewConversationAction.changeTextFieldDescription))
                }

                Section(header: Text("Setting")) {
                    Toggle("Public", isOn: viewStore.binding(get: \.newConversation.isPublic, send: NewConversationAction.toggleChange))
                    NavigationLink(
                        destination: VaporEmptyView(),
                        label: {
                            Text("Add User")
                        })
                }

                HStack(alignment: .center, spacing: 10, content: {
                    Spacer()
                    Button(action: {
                        if let data = image?.scalePreservingAspectRatio(targetSize: CGSize(width: 200, height: 200)).pngData() {
                            viewStore.send(.uploadImage(data))
                        }
                    }, label: {
                        HStack {
                            if viewStore.appState.isLoading {
                                ActivityIndicator().padding(.trailing, 20)
                            } else {
                                Text("Create")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("facebook"))
                            }
                        }

                    })
                    Spacer()
                })
            }
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker { image in
                    self.image = image
                }
            }
        }
    }
}

struct NewConversationView_Previews: PreviewProvider {
    static var previews: some View {
        NewConversationView(store: Store(initialState: NewConversationState(),
                                         reducer: newConverstionReducer,
                                         environment: NewConversationEnviroment()))
    }
}
