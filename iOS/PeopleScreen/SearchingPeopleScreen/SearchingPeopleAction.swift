import Foundation

enum SearchingPeopleAction: Equatable {
    case node(index: UUID, action: PeopleAction)
    case requestSearchUsers(String)
    case resposeSearchUsers(Data)
    case changeSearchText(String)
    case viewAppear
    case viewDisappear
}
