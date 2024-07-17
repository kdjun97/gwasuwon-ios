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
        case let .studentAction(studentAction):
            studentNavigationHandler(studentAction, state: &state)
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
            state.routes.push(.detailClass(.init(id: id)))
        default:
            break
        }
    }
    
    func studentNavigationHandler(_ action: StudentFeature.Action, state: inout RootCoordinator.State) {
        switch action {
        case .qrScanButtonTapped:
            state.routes.push(.qrCode(.init()))
        default:
            break
        }
    }
}
