import Foundation

enum MessageAction: Equatable {
    case sendNewMessage
    case receiveNewMessage
    case loadFirstMessage
    case loadMoreMessage
    case changeTextNewMesage(String)
    case uploadImage(Data)
    case receiveImageLink(String)
    case sendMessage(MessageOutput)
    case receiveMessage(Data)
    case receiveMessages(Data)
    case changetoSettingMesage
}
