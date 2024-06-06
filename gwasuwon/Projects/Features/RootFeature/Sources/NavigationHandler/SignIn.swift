//
//  SignIn.swift
//  RootFeature
//
//  Created by 김동준 on 6/6/24
//

import SignInFeature
import ComposableArchitecture

extension RootCoordinator {
    func signInNavigationHandler(_ action: SignInFeature.Action, state: inout RootCoordinator.State) {
        switch action {
        case .navigateToSignUp:
            state.routes.push(.signUp(.init()))
        default:
            break
        }
    }
}
