import SwiftUI

struct WelcomeItemView: View {

    var image: String
    var title: String
    var subtitle: String
    var color: Color
    
    var body: some View {
        HStack(spacing: 24) {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32.0)
                .foregroundColor(color)
                .onAppear {
                    
                }
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(subtitle)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}

struct WelcomeItemView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeItemView(image: "calendar", title: "Schedule a Repair", subtitle: "Find a Genius Bar or Apple Service Provider near you.", color: .red)
    }
}
