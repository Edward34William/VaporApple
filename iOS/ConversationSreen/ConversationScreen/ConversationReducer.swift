import Foundation
import Alamofire
import AnyRequest
import Json
import ComposableArchitecture

let conversationReducer = Reducer<ConversationState, ConversationAction, ConversationEnvironment>.combine(
    
    conversationItemReducer.forEach(
        state: \.conversations,
        action: /ConversationAction.node,
        environment: { _ in
            .init()
        }
    ),
    
    .init() {state, action, enviroment in
        switch action {
        case .changeMainScreen(let mainScreen):
            state.mainScreen = mainScreen
        case .logout:
            state.appState.rootScreen = .logout
            break
        case .getConversation:
            let request = Request {
                Url(urlString: "http://127.0.0.1:8080/api/conversations")
                MethodRequest(.get)
            }
            return request.compactMap {$0.data}.compactMap (ConversationAction.receiveConversation).eraseToEffect()
        case .receiveConversation(let data):
            debugLog(data.toJson())
            if let error = data.toModel(VaporError.self) {
                debugLog(error.toJson())
            } else {
                if let conversations = data.toModel([Conversation].self) {
                    state.conversations = IdentifiedArrayOf(uniqueElements: conversations)
                }
            }
            
        case .node(let id, let action):
//            if let currentConversation = state.conversations.filter({ $0.id == id }).first {
//                state.currentConversation = currentConversation
//            }
            break
        }
        
        return .none
    }
).debugActions(" 🟢 RootApp", actionFormat: ActionFormat.prettyPrint)
