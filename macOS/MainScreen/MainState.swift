import ComposableArchitecture
import Foundation

struct MainState: Equatable {
    var conversationState = ConversationState()
    var currentConversation = Conversation()
    var conversations: IdentifiedArrayOf<Conversation> = []
    
    var selection: Identified<Conversation.ID, MessageState>?
    
    var mesageStateCached = MessageState()
    var messageState: MessageState {
        get {
            MessageState(
                composedMessage: mesageStateCached.composedMessage,
                currentConversation: currentConversation,
                messages: mesageStateCached.messages
            )
        }
        
        set {
            mesageStateCached = newValue
        }
    }
}
