import Foundation
import Starscream

enum MessageAction: Equatable {
    case sendNewMessage
    case receiveNewMessage
    case loadFirstMessage
    case loadMoreMessage
    case changeTextNewMesage(String)
    case uploadImage(Data)
    case receiveImageLink(String)
    case node(UUID, MessageActionItem)
    case sendMessage(MessageOutput)
    case receiveMessage(Data)
    case receiveMessages(Data)
    case changetoSettingMesage
    case receiveMessageWebSocketEvent(WebSocketEvent)
    case updateUserTyping([UserTyping])
    case onDisappear
}

struct MessageActionItem: Equatable {
    
}
