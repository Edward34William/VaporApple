import SwiftUI
import Foundation

struct ImageWeb: View {
    
    @State private var uiImage: UIImage? = nil
    let placeholderImage = UIImage()
    
    let urlString: String
    
    var body: some View {
        Image(uiImage: self.uiImage ?? placeholderImage)
            .resizable()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .onAppear(perform: downloadWebImage)
    }
    
    func downloadWebImage() {
        
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                self.uiImage = image
            }else {
                print("error: \(String(describing: error))")
            }
        }.resume()
    }
    
}

struct ImageWeb_Previews: PreviewProvider {
    static var previews: some View {
        ImageWeb(urlString: "http://127.0.0.1:8080/E202155A-17EC-4398-836F-3DDBB8083A56.png")
    }
}
