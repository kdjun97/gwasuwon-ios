//
//  SignUpRole.swift
//  RootFeature
//
//  Created by 김동준 on 7/11/24
//

import ComposableArchitecture
import SignUpFeature

extension RootCoordinator {
    func signUpRoleNavigationHandler(_ action: SignUpRoleFeature.Action, state: inout RootCoordinator.State) {
        switch action {
        case .navigateToSignUpComplete:
            state.routes.push(.signUpComplete(.init()))
        default:
            break
        }
    }
}
