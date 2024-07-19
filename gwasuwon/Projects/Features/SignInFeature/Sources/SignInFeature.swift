//
//  SignInFeature.swift
//  SignIn
//
//  Created by 김동준
//

import ComposableArchitecture
import Domain

public struct SignInFeature: Reducer {
    @Dependency(\.socialUseCase) var socialUseCase

    public init() {}

    public struct State: Equatable {
        public init() {}
        @BindingState var isLoading = false
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case kakaoButtonTapped
        case appleButtonTapped
        case navigateToHome
        case navigateToSignUp
        case successToGetKakaoAccessToken
        case failureToGetKakaoAccessToken
    }

    public var body: some ReducerOf<SignInFeature> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
            case .binding:
                break
            case .kakaoButtonTapped:
                state.isLoading = true
                return .run { send in
                    await send(signInWithKakao())
                }
            case .appleButtonTapped:
                return .send(.navigateToHome)
            case .navigateToHome, .navigateToSignUp:
                break
            case .successToGetKakaoAccessToken:
                state.isLoading = false
                break
            case .failureToGetKakaoAccessToken:
                state.isLoading = false
                break
            }
            return .none
        }
    }
}

extension SignInFeature {
    private func signInWithKakao() async -> Action {
        let response = await socialUseCase.signInWithKakao()
        switch response {
        case let .success(result):
            return .successToGetKakaoAccessToken
        case let .failure(error):
            return .failureToGetKakaoAccessToken
        }
    }
}
