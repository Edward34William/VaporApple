import SwiftUI

struct ActivityIndicator: View {
    var body: some View {
        UIViewRepresented(makeUIView: { _ in
            let view = UIActivityIndicatorView()
//            view.color = .white
            view.startAnimating()
            return view
        })
    }
}
