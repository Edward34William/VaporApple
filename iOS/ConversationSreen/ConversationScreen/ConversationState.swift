import Foundation
import ComposableArchitecture

struct ConversationState: Equatable {

    var appState = AppState()
    
    var mainScreen = MainScreen.conversation
    
    //MARK: - SharedProperties
    var currentConversation: Conversation?
    
    //MARK: - Properties
    var conversations: IdentifiedArrayOf<Conversation> = []
    

}
