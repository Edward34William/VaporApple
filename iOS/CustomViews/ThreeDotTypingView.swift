import SwiftUI

struct ThreeDotTypingView: View {
    
    @State private var showAnimation = false
    
    private let size: CGFloat = 8
    
    private let yOffSet: CGFloat = -20
    
    private let stiffness: Double = 100
    
    private let damping: Double = 5
    
    private let color = Color.gray
    
    var body: some View {
        ZStack {
            HStack {
                Circle()
                    .fill(color)
                    .frame(width: size, height: size)
                    .offset(x: 0, y: showAnimation ? 0 : yOffSet)
                    .animation(Animation
                                .interpolatingSpring(stiffness: stiffness, damping: damping)
                                .repeatForever(autoreverses: false).delay(0.04))
                Circle()
                    .fill(color)
                    .frame(width: size, height: size)
                    .offset(x: 0, y: showAnimation ? 0 : yOffSet)
                    .animation(Animation
                                .interpolatingSpring(stiffness: stiffness, damping: damping)
                                .repeatForever(autoreverses: false).delay(0.08))
                Circle()
                    .fill(color)
                    .frame(width: size, height: size)
                    .offset(x: 0, y: showAnimation ? 0 : yOffSet)
                    .animation(Animation
                                .interpolatingSpring(stiffness: stiffness, damping: damping)
                                .repeatForever(autoreverses: false).delay(0.12))
            }.onAppear() {
                self.showAnimation.toggle()
            }
        }
    }
}

struct ThreeDotTypingView_Previews: PreviewProvider {
    static var previews: some View {
        ThreeDotTypingView()
    }
}
