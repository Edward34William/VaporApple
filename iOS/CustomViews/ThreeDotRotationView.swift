//
//  ThreeDotRotationView.swift
//  VaporApple (iOS)
//
//  Created by Nguyen Phong on 7/12/21.
//

import SwiftUI

struct ThreeDotRotationView: View {
    @State var isAnimating: Bool = false

    let animationDuration: Double = 1
    
    let frame: CGSize = CGSize(width: 80, height: 80)
    
    var body: some View {
        ZStack {
            
            Color.white.ignoresSafeArea()
            ZStack {
                Circle().fill(Color.yellow)
                    .frame(height: frame.height / 3)
                    .offset(x :0, y: 0)
                Circle().fill(Color.red)
                    .frame(height: frame.height / 3)
                    .offset(x :0, y: isAnimating ? -frame.height*sqrt(2) / 3 : 0)
                
                Circle().fill(Color.green)
                    .frame(height: frame.height / 3)
                    .offset(x : isAnimating ? -frame.height / 3 : 0,
                            y: isAnimating ? frame.height / 3 : 0)
                
                Circle().fill(Color.blue)
                    .frame(height: frame.height / 3)
                    .offset(x : isAnimating ? frame.height / 3 : 0,
                            y: isAnimating ? frame.height / 3 : 0)
                
                
                
            }
            .animation(Animation.easeInOut(duration: animationDuration).repeatForever(autoreverses: true))
            .frame(width: frame.width, height: frame.height, alignment: .center)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .animation(Animation.easeInOut(duration: animationDuration).repeatForever(autoreverses: false))
            .onAppear() {
                isAnimating.toggle()
            }
           
        }
    }
}

struct ThreeDotRotationView_Previews: PreviewProvider {
    static var previews: some View {
        ThreeDotRotationView()
    }
}
