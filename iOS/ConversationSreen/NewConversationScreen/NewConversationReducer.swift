import ComposableArchitecture
import AnyRequest
import Alamofire
import Foundation
import Json

let newConverstionReducer = Reducer<NewConversationState, NewConversationAction, NewConversationEnviroment> { state, action, enviroment in
    switch action {
    case .changeTextFieldConversationName(let text):
        state.newConversation.name = text
    case .changeTextFieldDescription(let text):
        state.newConversation.descriptionConversation = text
    case .toggleChange(isOn: let isOn):
        state.newConversation.isPublic = isOn
    case .uploadImage(let data):
        if state.newConversation.name.isEmpty {
            break
        }
        state.appState.isLoading = true
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/fileUpload?key=\(UUID().uuidString).png")
            MethodRequest(.post)
            HttpBody(data)
        }
        return request.map { $0.data!.toString()! }.map(NewConversationAction.receiveImageLink).eraseToEffect()
    case .receiveImageLink(let urlString):
        state.newConversation.urlString = urlString
        return Effect(value: .createnewConversationAction).eraseToEffect()
    case .createnewConversationAction:
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/conversations")
            MethodRequest(.post)
            HttpBody(state.newConversation.toData())
            Encoding(encoding: JSONEncoding.default)
        }
        return request.compactMap{$0.data}.map(NewConversationAction.receiveNewRoom).eraseToEffect()
    case .receiveNewRoom(let data):
        state.appState.isLoading = false
        debugLog(data.toJson())

    }
    return .none
}
