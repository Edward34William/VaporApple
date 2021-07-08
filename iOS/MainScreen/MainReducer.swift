import Alamofire
import AnyRequest
import ComposableArchitecture
import Foundation

var messageSocket: RootWebSocket?
var userOnlineSocket: RootWebSocket?
var userTypingSocket: RootWebSocket?
var userOnSocket: RootWebSocket?

let mainReducer = Reducer<MainState, MainAction, MainEnvironment>.combine(
    Reducer.init { state, action, _ in
        switch action {
        case .conversation(let conversationAction):
            switch conversationAction {
            case .node(let id, let conversationItemAction):
                if let currentConversation = state.conversationStateCached.conversations.filter({ $0.id == id }).first {
                    debugLog(currentConversation.toJson())
                    state.conversationStateCached.currentConversation = currentConversation
                    state.messageStateCached.currentConversation = currentConversation
                    state.currentConversation = currentConversation
                    state.mainScreen = .message
//                    return .merge(Effect(value: MainAction.startSocketUserTyping), Effect(value: MainAction.startSocketConversation)).eraseToEffect()
                } else {
                    state.conversationStateCached.currentConversation = nil
                    state.messageStateCached.currentConversation = nil
                    state.currentConversation = nil
                }
            default:
                break
            }
        case .selectedScreen(let screen):
            state.mainScreen = screen
            
            switch screen {
            case .conversation:
                state.messageStateCached.composedMessage = ""
                let userID = state.appState.seesion.user.id
                if let conversationID = state.currentConversation?.id {
                    userTypingSocket?.sendModel(model: UserTyping(userID: userID, conversationID: conversationID, isTyping: false))
                }
                state.currentConversation = nil
//                return .merge(Effect(value: MainAction.stopSocketConversation), Effect(value: MainAction.stopSocketUserTyping))
            default:
                break
            }
            
        case .logout:
            state.appState.rootScreen = .auth
        case .people:
            break
        case .message:
            break
        case .setting:
            state.mainScreen = .setting
        case .newConversationAction(let newConversationAction):
            state.mainScreen = .newConversation
            
            switch newConversationAction {
            case .receiveNewRoom:
                state.mainScreen = .conversation
            default:
                break
            }
            
        case .messageAction(let messageAction):
//            state.mainScreen = .message
            break
            
        case .settingConversation:
            break
        case .news:
            break
        case .newNewsAction:
            break
            
        case .startAllAppSocket:
            return .merge(
                Effect(value: MainAction.startSocketConversation),
                Effect(value: MainAction.startSocketUserOn),
                Effect(value: MainAction.startSocketUserOnline),
                Effect(value: MainAction.startSocketUserTyping)
            )
            
        case .stopAllAppSocket:
            return .merge(
                Effect(value: MainAction.stopSocketUserTyping),
                Effect(value: MainAction.stopSocketConversation),
                Effect(value: MainAction.stopSocketUserOnline),
                Effect(value: MainAction.stopSocketUserOn)
            )
            
        // MARK: - SocketUserOn

        case .startSocketUserOn:
            let userID = state.appState.seesion.user.id
            let path = "userOn/\(userID)"
            userOnSocket = RootWebSocket(path: path)
            return userOnSocket!.toEffect().map(MainAction.receiveUserOnWebSocketEvent)
        case .stopSocketUserOn:
            userOnSocket = nil
            
        case .receiveUserOnWebSocketEvent(let event):
            switch event {
            case .binary(let data):
                debugLog(data.toJson())
            case .text(let text):
                debugLog(text)
            default:
                break
            }
            
            // MARK: - SocketUserOnline

        case .startSocketUserOnline:
            let userID = state.appState.seesion.user.id
            let path = "userOnline/\(userID)"
            userOnlineSocket = RootWebSocket(path: path)
            return userOnlineSocket!.toEffect().map(MainAction.receiveUserOnlineWebSocketEvent)
        case .stopSocketUserOnline:
            userOnlineSocket = nil
        case .receiveUserOnlineWebSocketEvent(let event):
            switch event {
            case .binary(let data):
                let userID = state.appState.seesion.user.id
//                debugLog(userID)
//                debugLog(data.toJson())
                if let usersOnline = data.toModel([UserOnline].self) {
                    state.usersOnline = [:]
                    for userOnline in usersOnline {
                        state.usersOnline[userOnline.userID] = userOnline.isOnline
                    }
                } else if let userOnline = data.toModel(UserOnline.self) {
                    state.usersOnline[userOnline.userID] = userOnline.isOnline
                }
//                debugLog(state.usersOnline)
            case .text(let text):
                debugLog(text)
            default:
                break
            }
            return Effect(value: MainAction.people(.updateUsersOnline(state.usersOnline))).eraseToEffect()
            
        // MARK: - SocketUserTyping

        case .startSocketUserTyping:
            let userID = state.appState.seesion.user.id
            let path = "userTyping/\(userID)"
            userTypingSocket = RootWebSocket(path: path)
            return userTypingSocket!.toEffect().map(MainAction.receiveUserTypingWebSocketEvent)
        case .stopSocketUserTyping:
            userTypingSocket = nil
        case .receiveUserTypingWebSocketEvent(let event):
            switch event {
            case .binary(let data):
                debugLog(data.toJson())
                let userID = state.appState.seesion.user.id
                if let usersTyping = data.toModel([UserTyping].self) {
                    state.usersTyping = []
                    state.usersTyping = usersTyping
                } else if let userTyping = data.toModel(UserTyping.self) {
                    if state.usersTyping.isEmpty {
                        state.usersTyping = [userTyping]
                    } else {
                        var newUsersTyping = [UserTyping]()
                        for item in state.usersTyping {
                            if item.userID == userTyping.userID {
                                newUsersTyping.append(userTyping)
                            } else {
                                newUsersTyping.append(item)
                            }
                        }
                        state.usersTyping = newUsersTyping
                    }
                }
            case .text(let text):
                debugLog(text)
            default:
                break
            }
            debugLog(state.usersTyping.count)
            return Effect(value: MainAction.messageAction(.updateUserTyping(state.usersTyping)))

            // MARK: - SocketConversation

        case .startSocketConversation:
            let userID = state.appState.seesion.user.id
            let path = "conversation/\(userID)"
            messageSocket = RootWebSocket(path: path)
            return messageSocket!.toEffect().map(MainAction.receiveConversationWebSocketEvent)
        case .stopSocketConversation:
            messageSocket = nil
        case .receiveConversationWebSocketEvent(let event):
            switch event {
            case .binary(let data):
                if let message = data.toModel(Message.self) {
                    if message.conversation.id != state.currentConversation?.id, message.user.id != state.appState.seesion.user.id {
                        state.notificationMessageState = NotificationMessageState(message: message)
                        state.showNotificationMessage = true
                    }
                }
            case .text(let text):
                debugLog(text)
                if let message = text.toData().toModel(Message.self) {
                    if message.conversation.id != state.currentConversation?.id, message.user.id != state.appState.seesion.user.id {
                        state.notificationMessageState = NotificationMessageState(message: message)
                        state.showNotificationMessage = true
                    }
                }
            default:
                break
            }
            
            return Effect(value: MainAction.messageAction(.receiveMessageWebSocketEvent(event)))
        case .showNotificationMessage:
            state.showNotificationMessage = false
        case .notificationMesageAction(let action):
            if let conversation = state.notificationMessageState.message?.conversation.toConversation() {
                state.currentConversation = conversation
                state.conversationState.currentConversation = conversation
                state.messageState.currentConversation = conversation
                state.mainScreen = .message
            }

        case .conversationSettingAction:
            break
        }
        return .none
    },
    
    notificationMessageReducer
        .pullback(state: \.notificationMessageState, action: /MainAction.notificationMesageAction, environment: { _ in
            .init()
        }),
    
    conversationReducer
        .pullback(state: \.conversationState, action: /MainAction.conversation, environment: { _ in
            .init()
        }),
    
    peopleReducer
        .pullback(state: \.peopleState, action: /MainAction.people, environment: { _ in
            .init()
        }),
    
    newsReducer
        .pullback(state: \.newsState, action: /MainAction.news, environment: { _ in
            .init()
        }),
    
    settingReducer
        .pullback(state: \.settingState, action: /MainAction.setting, environment: { _ in
            .init()
        }),
    
    newConverstionReducer
        .pullback(state: \.newConversationState, action: /MainAction.newConversationAction, environment: { _ in
            .init()
        }),
    
    newNewsReducer
        .pullback(state: \.newNewsState, action: /MainAction.newNewsAction, environment: { _ in
            .init()
        }),
    
    messsageReduer
        .pullback(state: \.messageState, action: /MainAction.messageAction, environment: { _ in
            .init()
        })
)
