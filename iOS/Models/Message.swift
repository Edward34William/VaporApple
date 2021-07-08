import Foundation

struct Message: Codable, Equatable, Hashable, Identifiable {
    var id: UUID
    var message: String
    var messageType: String
    var urlString: String
    var user: MessageUser
    var conversation: MessageConversation
}

struct MessageOutput: Codable, Equatable {
    var message: String
    var messageType: String
    var urlString: String
    var conversationID: UUID
    var userID: UUID
    
    static func createTextMessage(message: String, userID: UUID, conversationID: UUID)-> MessageOutput {
        MessageOutput(message: message,
                      messageType: "text",
                      urlString: "",
                      conversationID: conversationID,
                      userID: userID)
    }
    
    static func createImageMessage(urlString: String, userID: UUID, conversationID: UUID) -> MessageOutput {
        MessageOutput(message: "",
                      messageType: "image",
                      urlString: urlString,
                      conversationID: conversationID,
                      userID: userID)
    }
    
}

struct MessageInput: Codable, Equatable, Hashable, Identifiable {
    var id: UUID
    var message: String
    var messageType: String
    var urlString: String
    var user: MessageUser
    var conversation: MessageConversation
}

struct MessageUser: Codable, Equatable, Hashable, Identifiable{
    var id: UUID
    var email: String
    var username: String
    var urlString: String
}

struct MessageConversation: Codable, Equatable, Hashable, Identifiable {
    var urlString: String
    var name: String
    var descriptionConversation: String
    var id: UUID
    
    func toConversation() -> Conversation {
        Conversation(id: id, name: name, urlString: urlString, descriptionConversation: descriptionConversation)
    }
}

enum MessageType: String {
    case text = "text"
    case image = "image"
}


extension Message {
    
    var msgType: MessageType {
        MessageType.init(rawValue: messageType) ?? .text
    }
}
