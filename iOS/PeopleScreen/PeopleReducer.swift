import Foundation
import Alamofire
import AnyRequest
import ComposableArchitecture


let peopleReducer = Reducer<PeopleState, PeopleAction, PeopleEnviroment>.combine(
    .init({ state, action, enviroment in
        
        switch action {
        case .requestGetUsers:
            let request = Request {
                Url(urlString: "http://127.0.0.1:8080/api/users")
                MethodRequest(.get)
                Encoding(encoding: URLEncoding.default)
            }
            return request.compactMap {$0.data}.compactMap(PeopleAction.resposeGetUsers).eraseToEffect()
        case .resposeGetUsers(let data):
            debugLog(data.toJson())

            if var users = data.toModel([User].self) {
                let usersOnline = state.usersOnline
                debugLog(usersOnline)
                
                var usersUpdate = [User]()
                for var user in users {
                    if let isOnline = usersOnline[user.id] {
                        user.isOnline = true
                    } else {
                        user.isOnline = false
                    }
                    usersUpdate.append(user)
                }
                state.users = IdentifiedArrayOf(uniqueElements: usersUpdate)
            }
        case .node(index: let index, action: let action):
            state.selectedUser = state.users[id: index]
            state.profileUserState.user = state.users[id: index]
            break
        case .profileUserAction(_):
            break
        case .updateUsersOnline(let usersOnline):
//            debugLog(usersOnline)
            state.usersOnline = usersOnline
            var users = state.users
            var usersUpdate = [User]()
            for var user in users {
                if let isOnline = usersOnline[user.id] {
                    user.isOnline = isOnline
                } else {
                    user.isOnline = false
                }
                usersUpdate.append(user)
            }
            state.users = IdentifiedArrayOf(uniqueElements: usersUpdate)
        case let .setNavigation(selection: .some(id)):
            debugLog(id)
            debugLog(state.users.map{$0.id})
            if let user = state.users.filter({$0.id == id}).first {
                state.selectedUser = user
                state.selection = Identified(user, id: id)
            }
        case .setNavigation(selection: .none):
            state.selection = nil
        }
        
        return .none
    }),
    
    profileUserReducer.pullback(state: \.profileUserState, action: /PeopleAction.profileUserAction, environment: { _ in
        .init()
    })
)
