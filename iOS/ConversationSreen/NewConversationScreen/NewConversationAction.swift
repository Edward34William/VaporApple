import Foundation

enum NewConversationAction: Equatable {
    case changeTextFieldConversationName(String)
    case changeTextFieldDescription(String)
    case toggleChange(isOn: Bool)
    case createnewConversationAction
    case uploadImage(Data)
    case receiveImageLink(String)
    case receiveNewRoom(Data)
}
