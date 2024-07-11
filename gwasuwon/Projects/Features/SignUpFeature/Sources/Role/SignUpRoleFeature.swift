//
//  SignUpRoleFeature.swift
//  SignUpFeature
//
//  Created by 김동준 on 7/11/24
//

import ComposableArchitecture

@Reducer
public struct SignUpRoleFeature {
    public init() {}

    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case onAppear
        case teacherButtonTapped
        case studentButtonTapped
    }

    public var body: some ReducerOf<SignUpRoleFeature> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
            case .teacherButtonTapped:
                break
            case .studentButtonTapped:
                break
            }
            return .none
        }
    }
}
