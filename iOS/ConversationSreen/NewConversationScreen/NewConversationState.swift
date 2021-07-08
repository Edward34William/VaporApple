import Foundation


struct NewConversationState: Equatable {

    var appState = AppState()

    var newConversation = NewConversation()
    
}


struct NewConversation: Equatable, Codable {
    var name: String = ""
    var urlString: String = ""
    var descriptionConversation: String = ""
    var isPublic: Bool = false
//    var usersID: [UUID] = []
}
