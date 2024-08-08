//
//  EditClass.swift
//  RootFeature
//
//  Created by 김동준 on 7/26/24
//

import ComposableArchitecture
import HomeFeature

extension RootCoordinator {
    func editClassNavigationHandler(_ action: EditClassFeature.Action, state: inout RootCoordinator.State) {
        switch action {
        case .navigateToBack:
            state.routes.goBack()
        default:
            break
        }
    }
}
