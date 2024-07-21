//
//  SignUp.swift
//  RootFeature
//
//  Created by 김동준 on 7/11/24
//

import ComposableArchitecture
import SignUpFeature

extension RootCoordinator {
    func signUpNavigationHandler(_ action: SignUpFeature.Action, state: inout RootCoordinator.State) {
        switch action {
        case let .navigateToSignUpRole(signInResult):
            state.routes.push(.signUpRole(.init(signInResult: signInResult)))
        default:
            break
        }
    }
}
