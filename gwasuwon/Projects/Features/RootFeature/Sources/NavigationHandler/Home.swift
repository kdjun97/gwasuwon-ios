//
//  Home.swift
//  RootFeature
//
//  Created by 김동준 on 7/12/24
//

import ComposableArchitecture
import HomeFeature

extension RootCoordinator {
    func homeNavigationHandler(_ action: HomeFeature.Action, state: inout RootCoordinator.State) {
        switch action {
        case let .teacherAction(teacherAction):
            teacherNavigationHandler(teacherAction, state: &state)
        default:
            break
        }
    }
}

extension RootCoordinator {
    func teacherNavigationHandler(_ action: TeacherFeature.Action, state: inout RootCoordinator.State) {
        switch action {
        case .addClassButtonTapped:
            state.routes.push(.addClass(.init()))
        case let .navigateToClassDetail(id):
            // TODO: 디테일 페이지로 연결 + id 넘겨주기
            break
        default:
            break
        }
    }
}
