import SwiftUI
import ComposableArchitecture

extension NSTextField { // << workaround !!!
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}
extension SignInAction {
    init(_ action: SignInView.ViewAction) {
        switch action {
        case let .changeTextFieldPassword(text):
            self = .changeTextFieldPassword(text)
        case let .changeTextFieldUsername(text):
            self = .changeTextFieldUsername(text)
        case .signInRequest:
            self = .signInRequest
        }
    }
}

struct SignInView: View {
    
    let store: Store<SignInState, SignInAction>
    
    struct ViewState: Equatable {
        var username: String = ""
        var password: String = ""
        
        init(_ signInState: SignInState) {
            self.username = signInState.username
            self.password = signInState.password
        }
    }
    
    enum ViewAction {
        case changeTextFieldPassword(String)
        case changeTextFieldUsername(String)
        case signInRequest
    }
    
    
    var body: some View {
        WithViewStore(self.store.scope(state: {ViewState($0)}, action: SignInAction.init)) { viewStore in
            VStack {
                //Wellcome
                VStack(spacing:2){
                    Text("Welcome")
                        .font(.custom("WorkSans-Black", size: 38))
                        .foregroundColor(Color.white)
                    Text("Vapor")
                        .font(.title)
                        .foregroundColor(Color.white)
                }
                .padding(.top,35)
                
                Spacer()
                VStack(spacing: 25){
                    VStack{
                        VStack(alignment: .center, spacing: 5) {
                            
                            VStack(alignment: .center) {
                                Spacer()
                                TextField("Username", text: viewStore.binding(get: \.username, send: ViewAction.changeTextFieldUsername))
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .font(.title3)
                                    .background(Color.clear)
                                    .multilineTextAlignment(.center)
                                
                                //                                    .padding(.leading, 10)
                                Divider()
                                    .background(Color.gray)
                                    .padding(.top, 0)
                            }
                            .frame(width: 250, height: 40, alignment: .center)
                            
                            VStack(alignment: .center) {
                                Spacer()
                                SecureField("Password", text: viewStore.binding(get: \.password, send: ViewAction.changeTextFieldPassword))
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .font(.title3)
                                    .background(Color.clear)
                                    .multilineTextAlignment(.center)
                                //                                    .padding(.leading, 10)
                                Divider()
                                    .background(Color.gray)
                            }
                            .frame(width: 250, height: 40, alignment: .center)
                        }
                        //                        .disabled(viewStore.appState.isLoading)
                        Spacer().frame(height:45)
                        //Login
                        VStack(spacing: 20){
                            HStack{
                                Text("Login")
                                    .font(.custom("WorkSans-Bold", size: 16))
                                    .foregroundColor(Color.primary)
                                //                                    .padding(.leading,20)
                                //                                Spacer()
                                
                                //                                if viewStore.appState.isLoading {
                                //                                    ActivityIndicator().padding(.trailing, 20)
                                //                                }
                            }
                            .frame(width: 250, height: 50, alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 35)
                                    .strokeBorder().foregroundColor(Color.gray)
                                    .clipShape(Capsule()))
                            .onTapGesture {
                                //                                if viewStore.appState.isLoading {
                                //                                    return
                                //                                }
                                viewStore.send(ViewAction.signInRequest)
                            }
                            
                            VStack{
                                Text("Forgotten your password?")
                                    .font(.custom("OpenSans-Regular", size: 14))
                                    .foregroundColor(Color.gray)
                                    .background(Color.clear)
                                    .frame(height: 50)
                            }
                            //                            .disabled(viewStore.appState.isLoading)
                        }
                    }
                }
                
                Spacer()
                // Sign Up
                VStack{
                    Text("Haven’t registered yet?")
                        .font(.custom("WorkSans-Regular", size: 18))
                        .foregroundColor(Color.gray)
                    
                    Text("Join now.")
                        .foregroundColor(Color("facebook"))
                        .padding(.top, 10)
                }
                .padding(.bottom,20)
            }
            //            .disabled(viewStore.appState.isLoading)
            .padding(.horizontal)
        }
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(store: Store(initialState: SignInState(), reducer: signInReducer, environment: SignInEnviroment()))
    }
}
