import SwiftUI
import ComposableArchitecture
import AnyRequest
import Alamofire
import ConvertSwift

struct SignUpView: View {
    
    let store: Store<SignUpState, SignUpAction>
    
    @State private var image: UIImage? = nil
    @State private var isShowPhotoLibrary = false
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                //Wellcome
                VStack(spacing:2) {
                    Text("Welcome")
                        .font(.custom("WorkSans-Black", size: 38))
                        .foregroundColor(Color.primary)
                    Text("Vapor")
                        .font(.title)
                        .foregroundColor(Color.primary)
                }
                .padding(.top,35)
                Spacer().frame(height:30)
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
                Spacer().frame(height:35)
                VStack(spacing: 25){
                    // Facebook
//                    HStack{
//                        Text("Login with Facebook")
//                            .font(.custom("WorkSans-Bold", size: 16))
//                            .foregroundColor(Color.white)
//                            .padding(.leading,20)
//                        Spacer()
//                    }
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 56, alignment: .leading)
//                    .background(Color("facebook"))
//                    .clipShape(Capsule())
//                    .onTapGesture {
//                        print("LogIn with Facebook pressed")
//                    }
//
//                    //Or
//                    Text("Or")
//                        .font(.custom("WorkSans-Regular", size: 36))
//                        .foregroundColor(Color.primary)
                    
                    // Form
                    VStack{
                        VStack(alignment: .center, spacing: 30){
                            VStack(alignment: .center) {
                                CustomTextField(placeholder:
                                                    Text("Email Address"),
                                                fontName: "OpenSans-Regular",
                                                fontSize: 16,
                                                fontColor: Color.primary.opacity(0.7),
                                                text: viewStore.binding(get: \.email, send: SignUpAction.changeTextFieldEmail))
                                    .autocapitalization(.none)
                                Divider()
                                    .background(Color.primary)
                            }
                            
                            VStack(alignment: .center) {
                                CustomTextField(placeholder:
                                                    Text("Username"),
                                                fontName: "OpenSans-Regular",
                                                fontSize: 16,
                                                fontColor: Color.primary.opacity(0.7),
                                                text: viewStore.binding(get: \.username, send: SignUpAction.changeTextFieldUsername))
                                    .autocapitalization(.none)
                                Divider()
                                    .background(Color.primary)
                            }
                            
                            VStack(alignment: .center) {
                                CustomSecureField(placeholder:
                                                    Text("Password"),
                                                  fontName: "OpenSans-Regular",
                                                  fontSize: 16,
                                                  fontColor: Color.primary.opacity(0.7),
                                                  text: viewStore.binding(get: \.password, send: SignUpAction.changeTextFieldPassword))
                                    .autocapitalization(.none)
                                Divider()
                                    .background(Color.primary)
                            }
                        }
                        .disabled(viewStore.appState.isLoading)
                        Spacer().frame(height:45)
                        //SignUp
                        VStack(spacing: 20){
                            HStack{
                                Text("SignUp")
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
                                viewStore.send(SignUpAction.signUpRequest)
                            }
                            .disabled(viewStore.appState.isLoading)
                        }
                    }
                }
                
                Spacer()
                //SignIn
                HStack{
                    Text("I have aready account")
                        .font(.custom("WorkSans-Regular", size: 18))
                        .foregroundColor(Color.gray)
                    Button(action: {
                        viewStore.send(SignUpAction.changeToSignInView)
                    }) {
                        Text("Login now.")
                            .foregroundColor(Color("facebook"))
                    }
                    
                }
                .disabled(viewStore.appState.isLoading)
                .padding(.bottom,20)
            }
            .disabled(viewStore.appState.isLoading)
            .padding(.horizontal)
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker { image in
                    self.image = image
                }
            }
        }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(store: Store(initialState: SignUpState(), reducer: signUpReducer, environment: SignUpEnviroment()))
    }
}
