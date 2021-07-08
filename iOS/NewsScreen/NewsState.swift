import Foundation
import ComposableArchitecture

struct NewsState: Equatable {
    
    var appState = AppState()
    
    var mainScreen = MainScreen.conversation
    var news: [News] = []

}
