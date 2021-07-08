import Foundation

struct MainState: Equatable {
    var appState = AppState()

    // MARK: - Properties

    var mainScreen = MainScreen.conversation

    var usersOnline = [UUID: Bool]()
    var usersTyping = [UserTyping]()
    var showNotificationMessage: Bool = false
    
    var currentConversation: Conversation?
    
    var notificationMessageState = NotificationMessageState()
    
    var conversationStateCached = ConversationState()
    var conversationState: ConversationState {
        get {
            ConversationState(
                // - AppState
                appState: appState,
                mainScreen: mainScreen,
                // - Properties
                currentConversation: conversationStateCached.currentConversation,
                conversations: conversationStateCached.conversations
            )
        }
        
        set {
            mainScreen = newValue.mainScreen
            appState = newValue.appState
            conversationStateCached = newValue
        }
    }
    
    var peopleStateCached = PeopleState()
    var peopleState: PeopleState {
        get {
            PeopleState(
                // - AppState
                appState: appState,
                // - Properties
                users: peopleStateCached.users,
                selection: peopleStateCached.selection,
                selectedUser: peopleStateCached.selectedUser,
                usersOnline: usersOnline
            )
        }
        
        set {
            usersOnline = newValue.usersOnline
            appState = newValue.appState
            peopleStateCached = newValue
        }
    }
    
    var newsStateCached = NewsState()
    var newsState: NewsState {
        get {
            NewsState(
                // - AppState
                appState: appState,
                // - Properties
                mainScreen: mainScreen,
                news: newsStateCached.news
            )
        }
        
        set {
            mainScreen = newValue.mainScreen
            appState = newValue.appState
            newsStateCached = newValue
        }
    }
    
    var newConversationStateCached = NewConversationState()
    var newConversationState: NewConversationState {
        get {
            NewConversationState(
                // - SharedState
                appState: appState,
                // - Properties
                newConversation: newConversationStateCached.newConversation
            )
        }
        
        set {
            // - SharedState
            appState = newValue.appState
            // - Properties
            newConversationStateCached.newConversation = newValue.newConversation
        }
    }
    
    var newNewStateCached = NewNewsState()
    var newNewsState: NewNewsState {
        get {
            NewNewsState(
                // - SharedState
                appState: appState,
                // - Properties
                news: newNewStateCached.news
            )
        }
        
        set {
            appState = newValue.appState
            newNewStateCached.news = newValue.news
            newNewStateCached = newValue
        }
    }

    var messageStateCached = MessageState()
    var messageState: MessageState {
        get {
            MessageState(
                // - SharedState
                appState: appState,
                mainScreen: mainScreen,
                currentConversation: messageStateCached.currentConversation,
                // - Properties
                messages: messageStateCached.messages,
                composedMessage: messageStateCached.composedMessage,
                page: messageStateCached.page,
                usersOnline: usersOnline,
                usersTyping: usersTyping
            )
        }
        
        set {
            appState = newValue.appState
            mainScreen = newValue.mainScreen
            // - Properties
            messageStateCached.messages = newValue.messages
            messageStateCached = newValue
        }
    }
    
    var settingStateCached = SettingState()
    var settingState: SettingState {
        get {
            SettingState(
                appState: appState,
                mainScreen: mainScreen
            )
        }
        
        set {
            appState = newValue.appState
            settingStateCached = newValue
            mainScreen = newValue.mainScreen
        }
    }
    
    var conversationSettingState: ConverstionSettingState {
        return ConverstionSettingState(conversation: currentConversation)
    }
}

enum MainScreen: Equatable {
    case conversation
    case settingConversation
    case newConversation
    case people
    case news
    case newNews
    case message
    case setting
}
