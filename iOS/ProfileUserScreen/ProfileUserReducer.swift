import ComposableArchitecture
import Foundation
import Alamofire
import AnyRequest

let profileUserReducer = Reducer<ProfileUserState, ProfileUserAction, ProfileUserEnviroment> {state, action, enviroment in
    
    switch action {
    case .sendFriendRequest:
        break
    }
    
    return .none
}

