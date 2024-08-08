//
//  QRGeneration.swift
//  RootFeature
//
//  Created by 김동준 on 7/25/24
//

import ComposableArchitecture
import HomeFeature

extension RootCoordinator {
    func qrGenerationNavigationHandler(_ action: QRGenerationFeature.Action, state: inout RootCoordinator.State) {
        switch action {
        case .navigateToBack:
            state.routes.goBack()
        default:
            break
        }
    }
}
