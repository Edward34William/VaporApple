import Foundation

struct Conversation: Hashable, Equatable, Codable, Identifiable {
    var id: UUID
    var name: String
    var urlString: String
    var descriptionConversation: String
}
