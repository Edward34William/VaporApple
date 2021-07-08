import Foundation

enum NewNewsAction: Equatable {
    case changeTextFieldCaption(String)
    case uploadImage(Data)
    case receiveImageLink(String)
    case createNewNews
    case receiveNewNews(Data)
}
