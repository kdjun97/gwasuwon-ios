//
//  RootCoordinator.swift
//  RootFeature
//
//  Created by 김동준 on 6/6/24
//

import TCACoordinators
import ComposableArchitecture
import HomeFeature

@Reducer
public struct RootCoordinator {
    public init() {}
    
    public struct State: Equatable, IndexedRouterState {
        public init() { routes = [.root(.signIn(.init()), embedInNavigationView: true)] }
        public var routes: [Route<RootScreen.State>]
    }
  
    public enum Action: IndexedRouterAction {
        case routeAction(_ index: Int, action: RootScreen.Action)
        case updateRoutes([Route<RootScreen.State>])
    }
    
    public var body: some ReducerOf<RootCoordinator> {
        Reduce<State, Action> { state, action in
            switch action {
            case let .routeAction(_, action: .signIn(signInAction)):
                signInNavigationHandler(signInAction, state: &state)
            case let .routeAction(_, action: .signUp(signUpAction)):
                signUpNavigationHandler(signUpAction, state: &state)
            case let .routeAction(_, action: .signUpRole(signUpRoleAction)):
                signUpRoleNavigationHandler(signUpRoleAction, state: &state)
            case let .routeAction(_, action: .signUpComplete(signUpCompleteAction)):
                signUpCompleteNavigationHandler(signUpCompleteAction, state: &state)
            case let .routeAction(_, action: .home(homeAction)):
                homeNavigationHandler(homeAction, state: &state)
            case let .routeAction(_, action: .addClass(addClassAction)):
                addClassNavigationHandler(addClassAction, state: &state)
            case let .routeAction(_, action: .addClassDetail(addClassDetailAction)):
                addClassDetailNavigationHandler(addClassDetailAction, state: &state)
            case let .routeAction(_, action: .addClassDone(addClassDoneAction)):
                addClassDoneNavigationHandler(addClassDoneAction, state: &state)
            case let .routeAction(_, action: .detailClass(detailClassAction)):
                detailClassNavigationHandler(detailClassAction, state: &state)
            case let .routeAction(id, action: .qrCode(qrAction)):
                return qrCodeNavigationHandler(qrAction, state: &state, id: id)
            case let .routeAction(_, action: .qrGenerator(qrGenerationAction)):
                qrGenerationNavigationHandler(qrGenerationAction, state: &state)
            default:
                break
            }
            return .none
        }.forEachRoute(screenReducer: { RootScreen() })
    }
}
