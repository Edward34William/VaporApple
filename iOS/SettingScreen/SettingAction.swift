import Foundation


enum SettingAction: Equatable {
    case logout
    case done
    case uploadImage(Data)
    case receiveImageLink(String)
    case updateResult(Data)
}
