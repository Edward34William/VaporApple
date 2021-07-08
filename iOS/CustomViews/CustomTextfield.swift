import SwiftUI

struct CustomTextField: View {

    var placeholder: Text
    var fontName: String
    var fontSize: CGFloat
    var fontColor: Color
    var foregroundColor: Color?
    
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder.modifier(CustomTextFieldModifier(fontName: fontName, fontSize: fontSize, fontColor: fontColor)) }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit).foregroundColor((foregroundColor != nil) ?  foregroundColor : Color.primary)
        }
    }
}

struct CustomTextFieldModifier: ViewModifier {
    //MARK:- PROPERTIES
    let fontName: String
    let fontSize: CGFloat
    let fontColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: fontSize))
            .foregroundColor(fontColor)
    }
}
