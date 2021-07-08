import Foundation


struct User: Codable, Hashable, Equatable, Identifiable {
    var id: UUID = UUID()
    var username: String = ""
    var email: String = ""
    var updatedAt: String = ""
    var createdAt: String = ""
    var urlString: String = ""
    
    var isOnline: Bool? = false
}

struct UserSignUp: Codable {
    var email: String = ""
    var password: String = ""
    var username: String = ""
    var urlString: String = ""
}

struct UserUpdateInfo: Codable, Equatable {
    var username: String = ""
    var email: String = ""
    var urlString: String = ""
}
