import Foundation

struct News: Codable, Equatable , Identifiable {
    var id: String = ""
    var createdAt: String = ""
    var urlString: String = ""
    var caption: String = ""
    
    func toNewCreated(userID: UUID) -> NewsCreated {
        NewsCreated(urlString: urlString, caption: caption, userID: userID)
    }
}

struct NewsCreated: Codable {
    var urlString: String = ""
    var caption: String = ""
    var userID: UUID = UUID()
    
}
