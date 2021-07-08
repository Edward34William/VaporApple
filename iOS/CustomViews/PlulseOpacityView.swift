import SwiftUI

struct PlulseOpacityView: View {
    
    private struct CircleData: Hashable {
        let width: CGFloat
        let opacity: Double
    }

    @State private var isAnimating: Bool = false
    
    private var circleArray = [CircleData]()
    
    init() {
        var opacity = 0.6
        var circleWidth: CGFloat = 10
        for _ in 0 ..< 10 {
            circleWidth += 20
            circleArray.append(CircleData(width: circleWidth, opacity: opacity))
            opacity -= 0.1
        }
    }
    
    var body: some View {
        ZStack {
            Group {
                ForEach(circleArray, id: \.self) { cirlce in
                    Circle()
                        .fill(Color.blue)
                        .opacity(self.isAnimating ? cirlce.opacity : 0)
                        .frame(width: cirlce.width, height: cirlce.width, alignment: .center)
                        .scaleEffect(self.isAnimating ? 1 : 0)
                }
            }
            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true),
                       value: self.isAnimating)
            
            Button(action: {
                print("Button Pressed event")
            }) {
                Circle()
                    .fill(Color.blue)
                    .scaledToFit()
                    .background(Circle().fill(Color.white))
                    .frame(width: 0, height: 0, alignment: .center)
            }
            .onAppear(perform: {
                self.isAnimating.toggle()
            })
        }
    }
    
}

struct PlulseOpacityView_Previews: PreviewProvider {
    static var previews: some View {
        PlulseOpacityView()
    }
}
