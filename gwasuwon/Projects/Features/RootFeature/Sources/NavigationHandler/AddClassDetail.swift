//
//  AddClassDetail.swift
//  RootFeature
//
//  Created by 김동준 on 7/13/24
//

import ComposableArchitecture
import HomeFeature

extension RootCoordinator {
    func addClassDetailNavigationHandler(_ action: AddClassDetailFeature.Action, state: inout RootCoordinator.State) {
        switch action {
        case .navigateToBack:
            state.routes.goBack()
        case .navigateToAddClassDone:
            state.routes.push(.addClassDone(.init()))
        default:
            break
        }
    }
}
