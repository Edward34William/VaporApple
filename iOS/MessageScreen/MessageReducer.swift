import Alamofire
import AnyRequest
import ComposableArchitecture
import Foundation
import ConvertSwift

let messsageReduer = Reducer<MessageState, MessageAction, MessageEnvironment> { state, action, environment in
    guard let conversationID = state.currentConversation?.id else {
        return .none
    }
    let userID = state.appState.seesion.user.id
    
    switch action {
    case .changeTextNewMesage(let text):
        if state.composedMessage.isEmpty && !text.isEmpty {
            userTypingSocket?.sendModel(model: UserTyping(userID: userID, conversationID: conversationID, isTyping: true))
        }
        state.composedMessage = text
        if state.composedMessage.isEmpty {
            userTypingSocket?.sendModel(model: UserTyping(userID: userID, conversationID: conversationID, isTyping: false))
        }

    case .sendNewMessage:
        if state.composedMessage.isEmpty {
            break
        }
        let messageOutput = MessageOutput.createTextMessage(message: state.composedMessage, userID: userID, conversationID: conversationID)
        state.composedMessage = ""
        return Effect(value: messageOutput).map(MessageAction.sendMessage).eraseToEffect()
    case .uploadImage(let data):
        state.appState.isLoading = true
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/fileUpload?key=\(UUID().uuidString).png")
            MethodRequest(.post)
            HttpBody(data)
        }
        state.composedMessage = ""
        return request.map { $0.data!.toString()! }.map(MessageAction.receiveImageLink).eraseToEffect()
    case .receiveImageLink(let urlString):
        let urlString = urlString
        let userID = state.appState.seesion.user.id
        let message = MessageOutput.createImageMessage(urlString: urlString, userID: userID, conversationID: conversationID)
        return Effect(value: message).map(MessageAction.sendMessage).eraseToEffect()
    case .sendMessage(let message):
        state.appState.isLoading = false
        debugLog(message.toJson())
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/messages")
            MethodRequest(.post)
            HttpBody(message.toData())
            Encoding(encoding: JSONEncoding.default)
        }
        //        request.call()
        userTypingSocket?.sendModel(model: UserTyping(userID: userID, conversationID: conversationID, isTyping: false))
        return request.compactMap {$0.data}.map(MessageAction.receiveMessage).eraseToEffect()
    case .receiveMessage(let data):
        if let message = data.toModel(Message.self) {
//            var messages = state.messages
//            messages.append(message)
//            state.messages = messages
            messageSocket?.sendModel(model: message)
//            messageSocket?.sendString(string: message.toData()?.toString())
        }
        
    case .loadFirstMessage:
        state.messages = []
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/conversations/").append(conversationID.toString()).append("/messages")
        }
        return request.compactMap{$0.data}
            .receive(on: environment.mainQueue)
            .eraseToEffect()
            .map(MessageAction.receiveMessages)
    case .receiveMessages(let data):
        debugLog(data.toJson())
        if let page = data.toModel(Page<Message>.self) {
            state.page = page
            for item in page.items {
                state.messages.append(item)
            }
        }
        
    case .loadMoreMessage:
        if !state.page.metadata.ableLoading {
            return .none
        }
        let request = Request {
            Url(urlString: "http://127.0.0.1:8080/api/conversations/")
                .append(conversationID.toString())
                .append("/messages")
                .append("?page=\(state.page.metadata.page+1)&per=\(state.page.metadata.per)")
        }
        return request.compactMap { $0.data }.map(MessageAction.receiveMessages).eraseToEffect()
    case .changetoSettingMesage:
        break
    case .receiveMessageWebSocketEvent(let event):
        switch event {
        case .binary(let data):
            if let message = data.toModel(Message.self) {
                var messages = state.messages
                messages.append(message)
                state.messages = messages
            }
        case .text(let text):
            if let message = text.toData().toModel(Message.self) {
                var messages = state.messages
                messages.append(message)
                state.messages = messages
            }
        default:
            break
        }
    case .updateUserTyping(let userTyping):
        debugLog(userTyping)
        state.usersTyping = userTyping
        break
    case .onDisappear:
        userTypingSocket?.sendModel(model: UserTyping(userID: userID, conversationID: conversationID, isTyping: false))
    default:
        return .none
    }
    return .none
}
