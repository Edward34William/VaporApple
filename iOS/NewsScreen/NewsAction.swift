import Foundation


enum NewsAction: Equatable {
    
    case openNewNewsScreen
    case getFirstNews
    case receiveNews(Data)
}
