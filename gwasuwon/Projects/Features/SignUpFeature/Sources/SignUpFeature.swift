//
//  SignUpFeature.swift
//  SignUp
//
//  Created by 김동준
//

import ComposableArchitecture

@Reducer
public struct SignUpFeature {
    public init() {}

    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case onAppear
    }

    public var body: some ReducerOf<SignUpFeature> {
        Reduce { _, action in
            switch action {
            case .onAppear:
                break
            }
            return .none
        }
    }
}
