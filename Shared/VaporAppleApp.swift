import SwiftUI
import ComposableArchitecture

@main
struct VaporAppleApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            RootView(store: Store(initialState: RootState(), reducer: rootReducer, environment: RootEnvironment()))
            #elseif os(macOS)
            RootView(store: Store(initialState: RootState(), reducer: rootReducer, environment: RootEnvironment()))
            #endif
        }
    }
}
