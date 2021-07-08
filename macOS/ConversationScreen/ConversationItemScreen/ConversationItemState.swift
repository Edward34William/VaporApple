import Foundation

struct ConversationItemState: Equatable, Identifiable {
    var id: UUID {
        return conversation.id
    }
    var conversation = Conversation()
}
