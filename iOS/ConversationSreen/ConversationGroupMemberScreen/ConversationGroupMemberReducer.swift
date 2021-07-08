import ComposableArchitecture
import AnyRequest
import Alamofire

let conversationGroupMemberReducer = Reducer<ConversationGroupMemberState, ConversationGroupMemberAction, ConversationGroupMemberEnvironment> {
    state, action, environment in
    switch action {
    case .getMemberInGroup:
        break
    }
    return .none
}
