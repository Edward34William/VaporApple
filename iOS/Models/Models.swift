import Foundation

struct UserOnline: Equatable,Codable {
    var userID: UUID
    var isOnline: Bool
}

struct UserTyping: Equatable, Codable {
    var userID: UUID
    var conversationID: UUID
    var isTyping: Bool
}

struct SocketSendData<D> {
    var tyeMessage: String
    var message: D
}

extension SocketSendData: Codable where D: Codable {}

extension SocketSendData: Equatable where D: Equatable {}
