import Foundation
import ComposableArchitecture

struct ConversationState: Equatable {
    
    var currentConversation = Conversation()
    
    var conversations: IdentifiedArrayOf<Conversation> = []
    
}

struct Conversation: Hashable, Equatable, Decodable, Identifiable {
    var id: UUID = UUID()
    var name: String?
    var urlString: String?
    var selected: Bool? = false
}
