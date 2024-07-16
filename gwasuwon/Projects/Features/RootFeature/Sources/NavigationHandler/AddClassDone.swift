//
//  AddClassDone.swift
//  RootFeature
//
//  Created by 김동준 on 7/14/24
//

import ComposableArchitecture
import HomeFeature

extension RootCoordinator {
    func addClassDoneNavigationHandler(_ action: AddClassDoneFeature.Action, state: inout RootCoordinator.State) {
        switch action {
        case let .showClassInfoButtonTapped(id):
            var destination = state.routes
            destination = [.root(.home(.init()), embedInNavigationView: true)]
            destination.push(.detailClass(.init(id: id)))
            state.routes = destination
        default:
            break
        }
    }
}
