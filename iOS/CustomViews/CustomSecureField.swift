import SwiftUI

struct CustomSecureField: View {

    var placeholder: Text
    var fontName: String
    var fontSize: CGFloat
    var fontColor: Color
    
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder.modifier(CustomTextFieldModifier(fontName: fontName, fontSize: fontSize, fontColor: fontColor)) }
            SecureField("", text: $text, onCommit: commit)
                .foregroundColor(.black)
        }
    }
}
