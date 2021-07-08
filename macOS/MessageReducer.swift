import ComposableArchitecture
import Alamofire
import AnyRequest
import ConvertSwift

let messageReducer = Reducer<MessageState, MessageAction, MessageEnvironment> { state, action, environment in
    let userID = SharedState.shared.appState.seesion.user.id.toUUID()!
    let conversationID = state.currentConversation.id
    switch action {
    case .changeTextNewMesage(let text):
        state.composedMessage = text
    case .loadFirstMessage:
        state.messages = []
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/conversations/").append(state.currentConversation.id.toString()).append("/messages")
        }
        return request.compactMap { $0.data }.map(MessageAction.receiveMessages).eraseToEffect()
    case .sendNewMessage:
        if state.composedMessage.isEmpty {
            break
        }
        let message = MessageOutput(message: state.composedMessage, messageType: "text", urlString: "", conversationID: conversationID, userID: userID)
        state.composedMessage = ""
        return Effect(value: message).map(MessageAction.sendMessage).eraseToEffect()
        
    case .uploadImage(let data):
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/fileUpload?key=\(UUID().uuidString).png")
            MethodRequest(.post)
            HttpBody(data)
        }
        state.composedMessage = ""
        return request.map { $0.data!.toString()! }.map(MessageAction.receiveImageLink).eraseToEffect()
    case .receiveImageLink(let urlString):
        let urlString = urlString
        let message = MessageOutput(message: "", messageType: "image", urlString: urlString, conversationID: conversationID, userID: userID)
        return Effect(value: message).map(MessageAction.sendMessage).eraseToEffect()
        
    case .sendMessage(let message):
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/messages")
            MethodRequest(.post)
            HttpBody(message.toData())
            Encoding(encoding: JSONEncoding.default)
        }
        return request.compactMap { $0.data }.map(MessageAction.receiveMessage).eraseToEffect()
        
    case .receiveMessage(let data):
        if let message = data.toModel(Message.self) {
            var messages = state.messages
            messages.append(message)
            state.messages = messages
        }
    case .receiveMessages(let data):
        if let page = data.toModel(Page<Message>.self) {
            for item in page.items {
                state.messages.append(item)
            }
        }
    default:
        break
    }
    
    return .none
}.debug()
