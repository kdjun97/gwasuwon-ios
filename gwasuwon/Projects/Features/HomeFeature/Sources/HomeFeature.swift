//
//  HomeFeature.swift
//  Home
//
//  Created by 김동준
//

import ComposableArchitecture
import Domain

@Reducer
public struct HomeFeature {
    public init() {}

    public struct State: Equatable {
        public init() {}
        
        var role: AuthRole = .teacher
        public var teacherState = TeacherFeature.State()
    }

    public enum Action {
        case onAppear
        case teacherAction(TeacherFeature.Action)
    }

    public var body: some ReducerOf<HomeFeature> {
        Reduce { _, action in
            switch action {
            case .onAppear:
                break
            case .teacherAction:
                break
            }
            return .none
        }
        Scope(state: \.teacherState, action: /Action.teacherAction, child: {
            TeacherFeature()
        })
    }
}
