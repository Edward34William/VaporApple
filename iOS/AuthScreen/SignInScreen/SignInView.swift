import SwiftUI
import ConvertSwift
import Json
import ComposableArchitecture
import AnyRequest
import Alamofire

struct SignInView: View {
    
    let store: Store<SignInState, SignInAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                //Wellcome
                VStack(spacing:2){
                    Text("Welcome")
                        .font(.custom("WorkSans-Black", size: 38))
                        .foregroundColor(Color.primary)
                    Text("Vapor")
                        .font(.title)
                        .foregroundColor(Color.primary)
                }
                .padding(.top,35)
                
                Spacer().frame(height:35)
                VStack(spacing: 25){
                    // Facebook
                    HStack{
                        Text("Login with Facebook")
                            .font(.custom("WorkSans-Bold", size: 16))
                            .foregroundColor(Color.white)
                            .padding(.leading,20)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 56, alignment: .leading)
                    .background(Color("facebook"))
                    .clipShape(Capsule())
                    .onTapGesture {
                        print("LogIn with Facebook pressed")
                    }
                    
                    //Or
                    Text("Or")
                        .font(.custom("WorkSans-Regular", size: 36))
                        .foregroundColor(Color.primary)
                    
                    // Form
                    VStack{
                        VStack(alignment: .center, spacing: 30){
                            VStack(alignment: .center) {
                                CustomTextField(placeholder:
                                                    Text("Username"),
                                                fontName: "OpenSans-Regular",
                                                fontSize: 16,
                                                fontColor: Color.primary.opacity(0.7),
                                                text: viewStore.binding(get: \.username, send: SignInAction.changeTextFieldUsername))
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
                                                  text: viewStore.binding(get: \.password, send: SignInAction.changeTextFieldPassword))
                                    .autocapitalization(.none)
                                Divider()
                                    .background(Color.primary)
                            }
                        }
                        .disabled(viewStore.appState.isLoading)
                        Spacer().frame(height:45)
                        //Login
                        VStack(spacing: 20){
                            HStack{
                                Text("Login")
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
                                if viewStore.appState.isLoading {
                                    return
                                }
                                viewStore.send(SignInAction.signInRequest)
                            }
                            
                            VStack{
                                Button(action: {
                                    viewStore.send(.changeToResetPasswordView)
                                }){
                                    Text("Forgotten your password?")
                                        .font(.custom("OpenSans-Regular", size: 14))
                                        .foregroundColor(Color.gray)
                                }
                            }
                            .disabled(viewStore.appState.isLoading)
                        }
                    }
                }
                
                Spacer()
                // Sign Up
                HStack{
                    Text("Haven’t registered yet?")
                        .font(.custom("WorkSans-Regular", size: 18))
                        .foregroundColor(Color.gray)
                    Button(action: {
                        viewStore.send(SignInAction.changeToSignUpView)
                    }) {
                        Text("Join now.")
                            .foregroundColor(Color("facebook"))
                    }
                    
                }
                .padding(.bottom,20)
            }
            .disabled(viewStore.appState.isLoading)
            .padding(.horizontal)
        }
    }

}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(store: Store(initialState: SignInState(), reducer: signInReducer, environment: SignInEnviroment()))
    }
}
