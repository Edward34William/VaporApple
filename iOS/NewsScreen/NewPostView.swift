//
//  NewPostView.swift
//  VaporApple (iOS)
//
//  Created by Nguyen Phong on 7/5/21.
//

import SwiftUI

struct NewPostView: View {
    @State var newPosttext = ""
    
    var body: some View {
        
        VStack {
            VStack {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                        .offset(y: 10)
                    
                    TextField("Write Something here?", text: $newPosttext)
                        .foregroundColor(.black)
                        .font(.custom("Avenir-Book", size: 20))
                        .offset(y: 10)
                }
            }.frame(height: 100)
            .background(Color.clear)
            
            
            HStack(alignment: .center) {
                
                ZStack {
                    Capsule().fill(Color.green.opacity(0.3))
                        .frame(width: 110, height: 30)
                    
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .offset(x: -44)
                    
                    Text("Gallary")
                        .foregroundColor(.green)
                        .font(.custom("Avenir-Medium", size: 18))
                        .offset(x: 5)
                }.offset(x: -10)
                
                Spacer()
                
                ZStack {
                    Capsule().fill(Color.red.opacity(0.3))
                        .frame(width: 110, height: 30)
                    
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .offset(x: -44)
                    
                    Text("People")
                        .foregroundColor(Color.blue)
                        .font(.custom("Avenir-Medium", size: 18))
                        .offset(x: 5)
                }
                Spacer()
                
                ZStack {
                    Capsule().fill(Color.green.opacity(0.3))
                        .frame(width: 110, height: 30)
                    
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .offset(x: -44)
                    
                    Text("Live")
                        .foregroundColor(Color.black)
                        .font(.custom("Avenir-Medium", size: 18))
                        .offset(x: 5)
                }.offset(x: 10)
                
            }.padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
        }
        


    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
