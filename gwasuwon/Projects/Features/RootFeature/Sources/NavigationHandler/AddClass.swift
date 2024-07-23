//
//  AddClass.swift
//  RootFeature
//
//  Created by 김동준 on 7/12/24
//

import ComposableArchitecture
import HomeFeature

extension RootCoordinator {
    func addClassNavigationHandler(_ action: AddClassFeature.Action, state: inout RootCoordinator.State) {
        switch action {
        case .navigateToBack:
            state.routes.goBack()
        case let .navigateToAddClassDetail(studentName, grade, memo):
            state.routes.push(
                .addClassDetail(
                    .init(
                        studentName: studentName,
                        grade: grade,
                        memo: memo
                    )
                )
            )
        default:
            break
        }
    }
}
