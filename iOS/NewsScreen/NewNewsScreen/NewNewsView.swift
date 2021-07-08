import SwiftUI
import ComposableArchitecture

struct NewNewsView: View {
    
    let store: Store<NewNewsState, NewNewsAction>
    
    @State private var isShowPhotoLibrary = false
    @State private var image: UIImage? = nil
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(alignment: .center, spacing: 30) {
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

                    CustomTextField(placeholder:
                                        Text("Caption"),
                                    fontName: "OpenSans-Regular",
                                    fontSize: 16,
                                    fontColor: Color.primary.opacity(0.7),
                                    text: viewStore.binding(get: \.news.caption, send: NewNewsAction.changeTextFieldCaption))
                        .autocapitalization(.none)
                        .padding(.top, 60)
                    Divider()
                        .background(Color.primary)
                        .padding(.bottom, 50)
                    VStack(spacing: 20){
                        HStack{
                            Text("Create News")
                                .font(.custom("WorkSans-Bold", size: 16))
                                .foregroundColor(Color.primary)
                                .padding(.leading,20)
                            Spacer()
                            if viewStore.appState.isLoading {
                                ActivityIndicator().padding(.trailing, 20)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 35)
                                .strokeBorder().foregroundColor(Color.gray)
                                .clipShape(Capsule()))
                        .onTapGesture {
                            if let data = image?.scalePreservingAspectRatio(targetSize: CGSize(width: 200, height: 200)).pngData() {
                                viewStore.send(.uploadImage(data))
                            }
                        }
                        .disabled(viewStore.appState.isLoading)
                    }
                }
                Spacer()
            }
            .padding()
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker { image in
                    self.image = image
                }
            }
        }
    }
    
}

struct NewNewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewNewsView(store: Store(initialState: NewNewsState(), reducer: newNewsReducer, environment: NewNewsEnviroment()))
    }
}
