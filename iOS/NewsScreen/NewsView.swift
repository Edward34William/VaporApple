import ComposableArchitecture
import Kingfisher
import SwiftUI

struct NewsView: View {
    let store: Store<NewsState, NewsAction>
    
    init(store: Store<NewsState, NewsAction>) {
        self.store = store
        UITableView.appearance().showsVerticalScrollIndicator = false
        UITableView.appearance().tableHeaderView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                List {
                    LazyVStack {
                        ForEach(viewStore.news, id: \.id) { item in
                            VStack {
                                HStack(alignment: .center, spacing: 10, content: {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40, alignment: .center)
                                        .foregroundColor(Color.gray)
                                    VStack(alignment: .leading, spacing: 5, content: {
                                        HStack {
                                            Text("username")
                                                .bold()
                                                .font(.headline)
                                                .foregroundColor(.black)
                                            Spacer()
                                            Text("12:00").font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        HStack {
                                            Text(item.caption)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    })
                                    Spacer()
                                })
                                KFImage(item.urlString.toURL())
                                    .resizable()
                                    .loadImmediately()
                                    .frame(height: 200, alignment: .center)
                                    .cornerRadius(8)
                                
                                HStack {
                                    Image("like")
                                    Image("love")
                                    Image("haha")
                                    Spacer()
                                    Text("2.5k Comment")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text("1.6K Shares")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                HStack(alignment: .center) {
                                    Image("Like")
                                        .foregroundColor(.gray)
                                    Text("Like")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Image("comment")
                                        .foregroundColor(.gray)
                                    Text("Comment")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Image("share")
                                        .foregroundColor(.gray)
                                    Text("Share")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding(EdgeInsets(top: 5, leading: 20, bottom: 8, trailing: 20))
                            }
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarTitle(Text("Stories"), displayMode: .inline)
                .navigationBarItems(leading: HStack {
                    Button(action: {}, label: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(Color("facebook"))
                    })
                },
                trailing: HStack {
                    Button {
                        viewStore.send(.openNewNewsScreen)
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(Color("facebook"))
                    }
                })
                .onAppear(perform: {
                    viewStore.send(.getFirstNews)
                })
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(store: Store(initialState: NewsState(), reducer: newsReducer, environment: NewsEnviroment()))
    }
}
