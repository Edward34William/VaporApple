import ComposableArchitecture
import Foundation
import AnyRequest
import Alamofire

let mainReducer = Reducer<MainState, MainAction, MainEnvironment>.combine(

    conversationReducer
        .pullback(state: \.conversationState, action: /MainAction.conversationAction, environment: { _ in
            .init()
        }),
    
    messageReducer
        .pullback(state: \.messageState, action: /MainAction.messageAction, environment: { _ in
            .init()
        }),
    
    Reducer({ state, action, environment in
        
        switch action {
        case .getConversation:
            let request = Request {
                Url(urlString: "http://127.0.0.1:8080/api/conversations")
                MethodRequest(.get)
            }
            return request.compactMap {$0.data}.compactMap (MainAction.receiveConversation).eraseToEffect()
        case .receiveConversation(let data):
            debugLog(data.toJson())
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
            
        case .selected(let id, action: let conversationItemAction):
            if let currentConversation = state.conversations.filter({$0.id == id}).first {
                state.messageState.currentConversation = currentConversation
                state.currentConversation = currentConversation
            }
            break
        case let .setNavigation(selection: .some(id)):
            for index in state.conversations.indices {
                state.conversations[index].selected = state.conversations[index].id == id
            }
            state.selection = Identified(state.messageState, id: id)
            if let currentConversation = state.conversations.filter({$0.id == id}).first {
                state.messageState.currentConversation = currentConversation
                state.currentConversation = currentConversation
            }
        case .setNavigation(selection: .none):
            state.selection = nil
        default:
            break
        }
        
        return .none
    })
)
