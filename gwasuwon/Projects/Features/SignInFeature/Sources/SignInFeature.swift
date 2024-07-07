//
//  SignInFeature.swift
//  SignIn
//
//  Created by 김동준
//

import ComposableArchitecture

public struct SignInFeature: Reducer {
    public init() {}

    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case onAppear
        case kakaoButtonTapped
        case appleButtonTapped
    }

    public var body: some ReducerOf<SignInFeature> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
            case .kakaoButtonTapped:
                break
            case .appleButtonTapped:
                break
            }
            return .none
        }
    }
}
