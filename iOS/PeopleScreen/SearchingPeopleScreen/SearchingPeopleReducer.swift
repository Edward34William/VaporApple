import Foundation
import AnyRequest
import Alamofire
import Combine
import ComposableArchitecture

let searchingPeopleReducer = Reducer<SearchingPeopleState, SearchingPeopleAction, SearchingPeopleEnvironment> {state, action, environment in
    struct CancelId: Hashable {}
    switch action {
    case .requestSearchUsers(let text):
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/users/search?term=\(text)")
            MethodRequest(.get)
            Encoding(encoding: URLEncoding.default)
        }
        
        return request
            .compactMap({$0.data}).map(SearchingPeopleAction.resposeSearchUsers)
            .eraseToEffect()
    case .resposeSearchUsers(let data):
        debugLog(data.toJson())
        if var users = data.toModel([User].self) {
            for user in users {
                state.users.append(user)
            }
        }
    case .node(index: let index, action: let action):
        break
    case .changeSearchText(let text):
        state.searchText = text
        if text.isEmpty {
            state.users = []
            return .none
        }
        return Effect(value: text)
            .map(SearchingPeopleAction.requestSearchUsers)
            .eraseToEffect()
    case .viewAppear:
        break
    case .viewDisappear:
        break
    }
    
    return .none
}
