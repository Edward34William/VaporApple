import SwiftUI
import ComposableArchitecture

struct SignInViewV2: View {

    let store: Store<SignInState, SignInAction>
    @State var index: Int = 0
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                Color("Color").ignoresSafeArea()
                ZStack(alignment: .bottom) {
                    VStack {
                        HStack {
                            VStack(spacing: 10) {
                                Text("Login")
                                    .foregroundColor(self.index == 0 ? .white : .gray)
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Capsule()
                                    .fill(self.index == 0 ? Color.blue : Color.clear)
                                    .frame(width: 100, height: 5)
                            }
                            Spacer()
                        }
                        .padding(.top, 30)
                        VStack {
                            HStack {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color("Color1"))
                                
                                TextField("Username", text: viewStore.binding(get: \.username, send: SignInAction.changeTextFieldUsername))
                                
                            }
                            
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 40)
                        
                        VStack {
                            HStack {
                                Image(systemName: "eye.slash")
                                    .foregroundColor(Color("Color1"))
                                SecureField("Password", text: viewStore.binding(get: \.password, send: SignInAction.changeTextFieldPassword))
                            }
                            
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 30)
                        
                        HStack {
                            Spacer(minLength: 0)
                            Button(action:{
                                
                            }){
                                Text("Forget Password?")
                                    .foregroundColor(Color.white.opacity(0.6))
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 30)
                    }
                    .padding()
                    .padding(.bottom, 65)
                    .background(Color("Color2"))
                    .clipShape(RightCurveShape())
                    .contentShape(RightCurveShape())
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
                    .onTapGesture {
                        self.index = 0
                    }
                    .cornerRadius(35)
                    .padding(.horizontal,20)
                    Button(action: {
                        
                    }) {
                        Text("LOGIN")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .padding(.horizontal, 50)
                            .background(Color("Color1"))
                            .clipShape(Capsule())
                            .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                    }
                    .offset(y:25)
                    .opacity(self.index == 0 ? 1 : 0)
                }
            }
        }
        
    }
}

struct SignInViewV2_Previews: PreviewProvider {
    static var previews: some View {
        SignInViewV2(store: Store(initialState: SignInState(), reducer: signInReducer, environment: SignInEnviroment()))
    }
}
