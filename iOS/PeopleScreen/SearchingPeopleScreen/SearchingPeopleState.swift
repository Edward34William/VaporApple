import Foundation
import ComposableArchitecture

struct SearchingPeopleState: Equatable {
    
    var appState = AppState()
    
    var users: IdentifiedArrayOf<User> = []
//    var users = [User]()
    var selectedIndex: Int = 0
    
    var searchText = ""

}
