import ComposableArchitecture
import Foundation
import Alamofire
import AnyRequest

let settingReducer = Reducer<SettingState, SettingAction, SettingEnvironment> { state, action, enviroment in
    
    switch action {
        
    case .logout:
        state.appState.rootScreen = .logout
    case .done:
        state.mainScreen = .conversation
    case .uploadImage(let data):
        state.appState.isLoading = true
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/fileUpload?key=\(UUID().uuidString).png")
            MethodRequest(.post)
            HttpBody(data)
        }
        
        return request.map { $0.data!.toString()! }.map(SettingAction.receiveImageLink).eraseToEffect()
    case .receiveImageLink(let urlString):
        let urlString = urlString
        let user = state.appState.seesion.user
        let userUpdateInfo = UserUpdateInfo(username: user.username,
                                            email: user.email,
                                            urlString: urlString)
        let data = userUpdateInfo.toData()
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/users/\(user.id)")
            MethodRequest(.put)
            HttpBody(data)
            Encoding(encoding: JSONEncoding.default)
        }
        return request.compactMap{$0.data}.map(SettingAction.updateResult).eraseToEffect()
    case .updateResult(let data):
        if let user = data.toModel(User.self) {
            state.appState.seesion.user = user
        }
    }
    
    
    return .none
    
}.debug()
