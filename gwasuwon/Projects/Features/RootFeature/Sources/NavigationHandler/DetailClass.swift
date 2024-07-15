//
//  DetailClass.swift
//  RootFeature
//
//  Created by 김동준 on 7/14/24
//

import HomeFeature
import ComposableArchitecture

extension RootCoordinator {
    func detailClassNavigationHandler(_ action: DetailClassFeature.Action, state: inout RootCoordinator.State) {
        switch action {
        case .navigateToBack:
            state.routes.goBack()
        default:
            break
        }
    }
}
