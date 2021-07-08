import SwiftUI
import ComposableArchitecture

struct AccountInfoView: View {
    let store: Store<AccountInfoState, AccountInfoAction>
    var body: some View {
        VaporEmptyView()
    }
}

struct AccountInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInfoView(store: Store(initialState: AccountInfoState(), reducer: accountInfoReducer, environment: AccountInfoEnvironment()))
    }
}
