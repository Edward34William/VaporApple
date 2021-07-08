import SwiftUI

struct WelcomeView: View {

    @State var showWelcomeScreen: Bool = true
    
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to Vapor Message")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 48)
            Spacer()
            
            VStack(spacing: 24) {
                WelcomeItemView(image: "text.badge.checkmark", title: "Self-Solve", subtitle: "Get helpful information to resolve your issue wherever you are.", color: .green)
                
                WelcomeItemView(image: "person.2.fill", title: "Get Support", subtitle: "Get help from a real person by phone, chat, and more.", color: .blue)
                
                WelcomeItemView(image: "calendar", title: "Schedule a Repair", subtitle: "Find a Genius Bar or Apple Service Provider near you.", color: .red)
            }
            .padding(.leading)
            
            Spacer()
            
            Button(action: { self.showWelcomeScreen = false }) {
                HStack {
                    Spacer()
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .frame(height: 50)
            .background(Color.blue)
            .cornerRadius(50)
        }
        .padding()
    }

    
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
