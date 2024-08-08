//
//  SignUpCompleteFeature.swift
//  SignUpFeature
//
//  Created by 김동준 on 7/12/24
//

import ComposableArchitecture

@Reducer
public struct SignUpCompleteFeature {
    public init() {}

    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case onAppear
        case startClassButtonTapped
    }

    public var body: some ReducerOf<SignUpCompleteFeature> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
            case .startClassButtonTapped:
                break
            }
            return .none
        }
    }
}
