//
//  QRCode.swift
//  RootFeature
//
//  Created by 김동준 on 7/17/24
//  Copyright © 2024 QCells. All rights reserved.
//

import ComposableArchitecture
import HomeFeature

extension RootCoordinator {
    func qrCodeNavigationHandler(_ action: QRFeature.Action, state: inout RootCoordinator.State, id: Int) -> Effect<Action> {
        switch action {
        case let .navigateToBackWithQRData(qrData):
            state.routes.goBack()
            return .send(.routeAction(id-1, action: .home(.studentAction(.setQRResult(qrData)))))
        case .navigateToBack:
            state.routes.goBack()
        default:
            break
        }
        return .none
    }
}
