//
//  ResetPasswordView.swift
//  VaporApple (iOS)
//
//  Created by Nguyen Phong on 6/29/21.
//

import ComposableArchitecture
import SwiftUI

struct ResetPasswordView: View {
    let store: Store<ResetPasswordState, ResetPasswordAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                VStack(alignment: .center, spacing: 30) {
                    VStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 20, content: {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(height: 50)
                            Text("Reset Password")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                        })
                        
                        CustomTextField(placeholder:
                            Text("Email Reset Password"),
                            fontName: "OpenSans-Regular",
                            fontSize: 16,
                            fontColor: Color.primary.opacity(0.7),
                            text: viewStore.binding(get: \.email, send: ResetPasswordAction.changeTextFieldEmail))
                            .autocapitalization(.none)
                            .frame(height: 50)
                        Divider()
                            .background(Color.primary)
                            .padding(.bottom, 30)
                        HStack {
                            Text("Reset Password")
                                .font(.custom("WorkSans-Bold", size: 16))
                                .foregroundColor(Color.white)
                                .padding(.leading, 20)
                            Spacer()
                            
                            if viewStore.appState.isLoading {
                                ActivityIndicator().padding(.trailing, 20)
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56, alignment: .leading)
                        .background(Color("facebook"))
                        .clipShape(Capsule())
                        .onTapGesture {
                            // update password
                        }
                    }
                    Spacer()
                }
                .padding()
                .navigationBarTitle(Text("Vapor"), displayMode: .inline)
                .navigationBarItems(leading: HStack {
                    
                    Button(action: {
                        viewStore.send(.changeToSignIn)
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color("facebook"))
                    })
                })

            }
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(store: Store(initialState: ResetPasswordState(), reducer: resetPasswordReducer, environment: ResetPasswordEnviroment()))
    }
}
