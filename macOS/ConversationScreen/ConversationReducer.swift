import Foundation
import Alamofire
import AnyRequest
import ComposableArchitecture

let conversationReducer = Reducer<ConversationState, ConversationAction, ConversationEnvironment> {state, action, environment in
    
    switch action {
    case .getConversation:
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/conversations")
            MethodRequest(.get)
        }
        return request.compactMap {$0.data}.compactMap (ConversationAction.receiveConversation).eraseToEffect()
    case .receiveConversation(let data):
        if let error = data.toModel(VaporError.self) {
            debugLog(error.toJson())
        } else {
            if let conversations = data.toModel([Conversation].self) {
                state.conversations = IdentifiedArrayOf(conversations)
                if let currentConversation = conversations.first {
                    state.currentConversation = currentConversation
                }
            }
        }
    }
    
    return .none
}
