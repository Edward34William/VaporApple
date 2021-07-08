import Foundation
import Starscream

enum MainAction: Equatable {
    case notificationMesageAction(NotificationMessageAction)
    case conversation(ConversationAction)
    case conversationSettingAction(ConversationSettingAction)
    case newConversationAction(NewConversationAction)
    case messageAction(MessageAction)
    case people(PeopleAction)
    case news(NewsAction)
    case message(MessageAction)
    case setting(SettingAction)
    case selectedScreen(MainScreen)
    case newNewsAction(NewNewsAction)
    
    case showNotificationMessage
    
    case startAllAppSocket
    case stopAllAppSocket
    
    // socket useronline
    case startSocketUserOnline
    case stopSocketUserOnline
    case receiveUserOnlineWebSocketEvent(WebSocketEvent)
    // socket usertyping
    case startSocketUserTyping
    case stopSocketUserTyping
    case receiveUserTypingWebSocketEvent(WebSocketEvent)
    // socket user on
    case startSocketUserOn
    case stopSocketUserOn
    case receiveUserOnWebSocketEvent(WebSocketEvent)
    
    // socket conversation
    case startSocketConversation
    case stopSocketConversation
    case receiveConversationWebSocketEvent(WebSocketEvent)
    
    case settingConversation
    case logout
}
