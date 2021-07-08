import Foundation


indirect enum PeopleAction: Equatable {
    case requestGetUsers
    case resposeGetUsers(Data)
    case node(index: UUID, action: PeopleAction)
    case setNavigation(selection: UUID?)
    case profileUserAction(ProfileUserAction)
    case updateUsersOnline([UUID: Bool])
}

extension PeopleAction {
    

}
