import ComposableArchitecture


let conversationItemReducer = Reducer<Conversation, ConversationItemAction, ConversationItemEnviroment> { state, action, enviroment in
    
    switch action {
    case .selected:
        debugLog(action)
    }
    
    return .none
}
