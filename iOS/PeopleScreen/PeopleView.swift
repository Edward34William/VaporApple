import SwiftUI
import ComposableArchitecture
import Kingfisher

struct PeopleView: View {
    
    let store: Store<PeopleState, PeopleAction>
    @State var searchText = ""
    @State var sortOnline = false
    var body: some View {
        WithViewStore(self.store) { viewStore in
                List {
//                    if searching {
//                        SearchView(searchText: $searchText, searching: $searching)
//                    }
                    ForEachStore(self.store.scope(state: \.users, action: PeopleAction.node)) { childStore in
                        WithViewStore(childStore) { childViewStore in
                            NavigationLink(destination: ProfileUserView(store: self.store.scope(state: \.profileUserState, action: PeopleAction.profileUserAction)), tag: childViewStore.id, selection: viewStore.binding(get: \.selection?.id, send: PeopleAction.setNavigation(selection:))) {
                                HStack(alignment: .center, spacing: 10, content: {
                                    KFImage(childViewStore.urlString.toURL())
                                        .loadImmediately(true)
                                        .resizable()
                                        .placeholder({
                                            Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .foregroundColor(Color.gray)
                                        })
                                        .frame(width: 40, height: 40, alignment: .center)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    VStack(alignment: .leading, spacing: 5, content: {
                                        Text(childViewStore.username)
                                            .bold()
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        
                                        HStack {
                                            Text(childViewStore.email)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                            Spacer()
                                        }
                                    })
                                    
                                    if childViewStore.isOnline == true {
                                        Circle()
                                            .fill(Color.green)
                                            .frame(width: 15, height: 15, alignment: .center)
                                    } else {
                                        Circle()
                                            .fill(Color.gray)
                                            .frame(width: 15, height: 15, alignment: .center)
                                    }
                                })
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle(Text("People"), displayMode: .inline)
                .navigationBarItems(leading: HStack {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(Color("facebook"))
                            .onTapGesture {
                                sortOnline.toggle()
                            }
                    })
                }
                , trailing: HStack {
                    NavigationLink(
                        destination: SearchingPeopleView(store: Store(initialState: SearchingPeopleState(), reducer: searchingPeopleReducer, environment: SearchingPeopleEnvironment())),
                        label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .foregroundColor(Color("facebook"))
                        })
                })
            .onAppear {
                viewStore.send(.requestGetUsers)
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView(store: Store(initialState: PeopleState(), reducer: peopleReducer, environment: PeopleEnviroment()))
    }
}
