import Foundation

enum ConversationAction: Equatable {
    case getConversation
    case receiveConversation(Data)
}
