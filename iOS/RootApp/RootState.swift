import Foundation

struct RootState: Equatable {
    var sharedState = SharedState()
    
    var authStateCached = AuthState()
    var authState: AuthState {
        get {
            AuthState(
                // - SharedState
                appState: sharedState.appState,
                // - Properties
                email: authStateCached.email,
                username: authStateCached.username,
                password: authStateCached.password,
                resetPasswordWithEmail: authStateCached.resetPasswordWithEmail
            )
        }
        set {
            sharedState.appState = newValue.appState
            authStateCached = newValue
        }
    }
    
    var mainStateCached = MainState()
    var mainState: MainState {
        get {
            MainState(
                // - SharedState
                appState: sharedState.appState,
                // - Properties
                mainScreen: mainStateCached.mainScreen,
                usersOnline: mainStateCached.usersOnline,
                usersTyping: mainStateCached.usersTyping,
                showNotificationMessage: mainStateCached.showNotificationMessage,
                currentConversation: mainStateCached.currentConversation,
                notificationMessageState: mainStateCached.notificationMessageState,
                conversationStateCached: mainStateCached.conversationStateCached,
                peopleStateCached: mainStateCached.peopleStateCached,
                newsStateCached: mainStateCached.newsStateCached,
                newConversationStateCached: mainStateCached.newConversationStateCached,
                newNewStateCached: mainStateCached.newNewStateCached,
                messageStateCached: mainStateCached.messageStateCached,
                settingStateCached: mainStateCached.settingStateCached
            )
        }
        set {
            sharedState.appState = newValue.appState
            mainStateCached = newValue
        }
    }
}

enum RootScreen: Equatable {
    case auth
    case app
    case logout
}
