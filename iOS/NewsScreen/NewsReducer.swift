import Foundation
import AnyRequest
import Alamofire
import ComposableArchitecture


let newsReducer = Reducer<NewsState, NewsAction, NewsEnviroment> {state, action, _ in
    switch action {
    case .getFirstNews:
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/stories")
        }
        return request.compactMap {$0.data}.compactMap (NewsAction.receiveNews).eraseToEffect()
    case .receiveNews(let data):
        debugLog(data.toJson())
        if let news = data.toModel([News].self) {
            state.news = news
        }
    case .openNewNewsScreen:
        state.mainScreen = .newNews
    }
    return .none
    
}.debug()
