import Foundation
import ComposableArchitecture

struct PeopleState: Equatable {

    var appState = AppState()
    var sortUserOnline: Bool = false
    var users: IdentifiedArrayOf<User> = []
    var selection: Identified<User.ID, User>?
    var selectedUser: User?
    var usersOnline = [UUID: Bool]()
    var profileUserState: ProfileUserState {
        get {
            ProfileUserState(appState: appState, user: selectedUser)
        }
        
        set {
            appState = newValue.appState
            selectedUser = newValue.user
        }
    }
}
