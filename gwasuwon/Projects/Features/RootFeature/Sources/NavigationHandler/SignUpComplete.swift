//
//  SignUpComplete.swift
//  RootFeature
//
//  Created by 김동준 on 7/12/24
//

import SignUpFeature
import ComposableArchitecture

extension RootCoordinator {
    func signUpCompleteNavigationHandler(_ action: SignUpCompleteFeature.Action, state: inout RootCoordinator.State) {
        switch action {
        case .startClassButtonTapped:
            state.routes = [.root(.home(.init()), embedInNavigationView: true)]
        default:
            break
        }
    }
}
