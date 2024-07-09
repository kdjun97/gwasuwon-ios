//
//  RootCoordinatorView.swift
//  RootFeature
//
//  Created by 김동준 on 6/6/24
//

import Foundation
import TCACoordinators
import ComposableArchitecture
import SwiftUI
import SignInFeature
import SignUpFeature
import HomeFeature

public struct RootCoordinatorView: View {
    let store: StoreOf<RootCoordinator>
    
    public init(store: StoreOf<RootCoordinator>) {
        self.store = store
    }

    public var body: some View {
        TCARouter(store) { screen in
            SwitchStore(screen) { screen in
                switch screen {
                case .signIn:
                    CaseLet(/RootScreen.State.signIn, action: RootScreen.Action.signIn, then: SignInView.init)
                case .signUp:
                    CaseLet(/RootScreen.State.signUp, action: RootScreen.Action.signUp, then: SignUpView.init)
                case .home:
                    CaseLet(/RootScreen.State.home, action: RootScreen.Action.home, then: HomeView.init)
                }
            }
        }
    }
}
