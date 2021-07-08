import Combine
import ComposableArchitecture
import Foundation
import SwiftUI

struct RootView: View {
    let store: Store<RootState, RootAction>

    var body: some View {
        WithViewStore(self.store.scope(state: \.sharedState)) { viewStore in
            ZStack {
                Color.white.onAppear {
                    viewStore.send(.onAppear)
                }

                if viewStore.state.appState.rootScreen == .auth {
                    AuthView(store: self.store.scope(state: \.authState, action: RootAction.authAction))
                } else if viewStore.state.appState.rootScreen == .app {
                    MainView(store: self.store.scope(state: \.mainState, action: RootAction.mainAction))
                } else {
                    AuthView(store: self.store.scope(state: \.authState, action: RootAction.authAction))
                        .onAppear {
                            viewStore.send(.logout)
                        }
                }
            }
        }
    }
}
