import Foundation

enum MainAction: Equatable {
    case conversationAction(ConversationAction)
    case conversationItemAction(ConversationItemAction)
    case messageAction(MessageAction)
    case getConversation
    case receiveConversation(Data)
    case setNavigation(selection: UUID?)
    case selected(id: UUID, action: ConversationItemAction)
}
