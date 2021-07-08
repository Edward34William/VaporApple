import Foundation
import ComposableArchitecture

struct MessageState: Equatable {
    var appState = AppState()
    var mainScreen = MainScreen.conversation
    var currentConversation: Conversation?
    var messages: IdentifiedArrayOf<Message> = []
    var composedMessage: String = ""
    var page: Page<Message>!
    var usersOnline = [UUID: Bool]()
    var usersTyping = [UserTyping]()
}
extension MessageState {
    
    var haveUserTyping: Bool {
        for userTyping in usersTyping {
            if userTyping.isTyping == true && userTyping.conversationID == currentConversation?.id {
                return true
            }
        }
        return false
    }
    
}


