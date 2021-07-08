import ComposableArchitecture
import Alamofire
import AnyRequest

let newNewsReducer = Reducer<NewNewsState, NewNewsAction, NewNewsEnviroment> {state, action, enviroment in
    switch action {
    case .changeTextFieldCaption(let text):
        state.news.caption = text
    case .uploadImage(let data):
        if state.news.caption.isEmpty {
            break
        }
//        state.appState.isLoading = true
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/fileUpload?key=\(UUID().uuidString).png")
            MethodRequest(.post)
            HttpBody(data)
        }
        
        return request.map { $0.data!.toString()! }.map(NewNewsAction.receiveImageLink).eraseToEffect()
    case .receiveImageLink(let urlString):
        state.news.urlString = urlString
        return Effect(value: .createNewNews).eraseToEffect()
    case .createNewNews:
        let data = state.news.toNewCreated(userID: state.appState.seesion.user.id).toData()
        debugLog(data?.toJson())
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/stories")
            MethodRequest(.post)
            HttpBody(data)
            Encoding(encoding: JSONEncoding.default)
        }.onData { data in
            debugLog(data.toJson())
        }
        
        request.call()
//        return request.compactMap{$0.data}.map(NewNewsAction.receiveNewNews).eraseToEffect()
    case .receiveNewNews(let data):
        state.appState.isLoading = false
        debugLog(data.toJson())
        break
    }
    return .none
}


