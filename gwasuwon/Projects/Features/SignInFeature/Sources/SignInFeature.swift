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
        case navigateToHome
        case navigateToSignUp
    }

    public var body: some ReducerOf<SignInFeature> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
            case .kakaoButtonTapped:
                return .send(.navigateToSignUp)
            case .appleButtonTapped:
                return .send(.navigateToHome)
            case .navigateToHome, .navigateToSignUp:
                break
            }
            return .none
        }
    }
}
