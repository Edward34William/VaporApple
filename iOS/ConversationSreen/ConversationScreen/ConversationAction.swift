import Foundation

enum ConversationAction: Equatable {
    case changeMainScreen(MainScreen)
    case logout
    case getConversation
    case receiveConversation(Data)
    case node(UUID, ConversationItemAction)
}
