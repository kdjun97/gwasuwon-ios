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
    @Dependency(\.accountUseCase) var accountUseCase

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
        case navigateToSignUp(SignInResult)
        case successToGetKakaoAccessToken(String)
        case failureToGetKakaoAccessToken(NetworkError)
        case signInSuccess(SignInResult)
        case signInError(NetworkError)
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
            case let .successToGetKakaoAccessToken(thirdPartyAccessToken):
                return .run { [provider = SignInProvider.kakao.rawValue] send in
                    await send(signIn(provider: provider, thirdPartyAccessToken: thirdPartyAccessToken))
                }
            case let .failureToGetKakaoAccessToken(error):
                state.isLoading = false
            case let .signInSuccess(signInResult):
                state.isLoading = false
                if (signInResult.status == SignInStatus.needSignUp.rawValue) {
                    return .send(.navigateToSignUp(signInResult))
                } else {
                    UserManager.shared.setUserInfo(id: signInResult.id, email: signInResult.email, role: signInResult.role)
                    return .send(.navigateToHome)
                }
            case let .signInError(error):
                state.isLoading = false
            }
            return .none
        }
    }
    
    private enum SignInStatus: String {
        case needSignUp = "PENDING"
        case success
    }
    
    private enum SignInProvider: String {
        case kakao = "kakao"
    }
}

extension SignInFeature {
    private func signInWithKakao() async -> Action {
        let response = await socialUseCase.signInWithKakao()
        switch response {
        case let .success(result):
            return .successToGetKakaoAccessToken(result)
        case let .failure(error):
            return .failureToGetKakaoAccessToken(error)
        }
    }
    
    private func signIn(provider: String, thirdPartyAccessToken: String) async -> Action {
        let response = await accountUseCase.signIn(provider, thirdPartyAccessToken)
        switch response {
        case let .success(result):
            return .signInSuccess(result)
        case let .failure(error):
            return .signInError(error)
        }
    }
}
