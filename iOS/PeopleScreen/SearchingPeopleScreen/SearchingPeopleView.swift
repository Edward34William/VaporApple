import SwiftUI
import ComposableArchitecture
import Kingfisher

struct SearchingPeopleView: View {
    
    @State var searchText = ""
    @State var searching = false
    
    let store: Store<SearchingPeopleState, SearchingPeopleAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(alignment: .leading) {
                List {
                    SearchView(searchText: viewStore.binding(get: \.searchText, send: SearchingPeopleAction.changeSearchText), searching: $searching)
                    ForEachStore(self.store.scope(state: \.users, action: SearchingPeopleAction.node(index:action:))) { childStore in
                        WithViewStore(childStore) { childViewStore in
                            NavigationLink(
                                destination: VaporEmptyView(),
                                label: {
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
                                            }
                                        })
                                        
                                        Spacer()
                                        ZStack {
                                            Capsule()
                                                .fill(Color("facebook"))
                                                .frame(width: 80, height: 35, alignment: .center)
                                            Text("Add")
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.white)
                                        }
                                        .padding(.trailing, 20)
                                        .onTapGesture {
                                            print("Hello")
                                        }
                                    })
                                })
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("People")
                .toolbar {
                    if searching {
                        Button("Cancel") {
                            searchText = ""
                            withAnimation {
                                searching = false
                                UIApplication.shared.dismissKeyboard()
                            }
                        }
                    }
                }
                .gesture(DragGesture().onChanged({ _ in
                    UIApplication.shared.dismissKeyboard()
                })
                )
            }
            .onAppear {
                viewStore.send(.viewAppear)
            }
            .onDisappear {
                viewStore.send(.viewDisappear)
            }
        }
        
    }
    
}

struct SearchingPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchingPeopleView(store: Store(initialState: SearchingPeopleState(), reducer: searchingPeopleReducer, environment: SearchingPeopleEnvironment()))
    }
}

