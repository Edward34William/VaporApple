import ComposableArchitecture
import Foundation
import Starscream
import SwiftUI

let rootReducer = Reducer<RootState, RootAction, RootEnvironment>.combine(
    .init { state, action, _ in
        switch action {
        case .onAppear:
            initApp()
        case .logout:
            state = RootState()
            debugLog("Logout Will Reset All Content")
            logOutApp()
            return .merge(
                Effect(value: RootAction.mainAction(.stopSocketConversation)),
                Effect(value: RootAction.mainAction(.stopSocketUserOn)),
                Effect(value: RootAction.mainAction(.stopSocketUserOnline)),
                Effect(value: RootAction.mainAction(.stopSocketUserTyping))
            ).eraseToEffect()
        case .mainAction(let action):
            break
        case .authAction(let authAction):
            break
        default:
            return .none
        }
        return .none
    },
    
    mainReducer
        .pullback(state: \.mainState, action: /RootAction.mainAction, environment: { _ in
            .init()
        }),
    
    authReducer
        .pullback(state: \.authState, action: /RootAction.authAction, environment: { _ in
            .init()
        })
)
// .debugActions(" 🟢 RootApp", actionFormat: ActionFormat.prettyPrint)

func initApp() {}

func logOutApp() {}
