import Kingfisher
import SwiftUI

struct AvatarUserView: View {
    
    @Binding var isOnline: Bool
    var urlString: String
    
    var body: some View {
        GeometryReader { geometryProxy in
            ZStack {
                KFImage(urlString.toURL())
                    .resizable()
                    .loadImmediately()
                    .placeholder {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundColor(Color.gray)
                    }
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                if isOnline {
                    HStack(alignment: .center, spacing: 0) {
                        Spacer()
                        VStack {
                            Spacer()
                            Circle()
                                .frame(width: geometryProxy.size.width/CGFloat.pi,
                                       height: geometryProxy.size.width/CGFloat.pi,
                                       alignment: .center)
                                .foregroundColor(Color.green)
                        }
                    }
                }
            }
        }
    }
}

struct AvatarUserView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarUserView(isOnline: .constant(true), urlString: "")
    }
}
