import Foundation
import ComposableArchitecture

struct MessageState: Equatable {
    
    var composedMessage: String = ""
    var currentConversation = Conversation()
    var messages: IdentifiedArrayOf<Message> = []
}
