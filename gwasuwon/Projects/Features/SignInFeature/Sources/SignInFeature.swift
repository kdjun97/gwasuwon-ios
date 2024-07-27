//
//  SignInFeature.swift
//  SignIn
//
//  Created by 김동준
//

import ComposableArchitecture
import Domain
import BaseFeature

public struct SignInFeature: Reducer {
    @Dependency(\.socialUseCase) var socialUseCase
    @Dependency(\.accountUseCase) var accountUseCase

    public init() {}
    
    public struct State: Equatable {
        public init() {}
        @BindingState var isLoading = false
        
        public enum AlertCase {
            case none
            case failure
            case appleNotice
        }
        
        @BindingState var alertState: AlertFeature.State = .init()
        var alertCase: AlertCase = .none
    }

    public enum Action: BindableAction, Equatable {
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
        case alertAction(AlertFeature.Action)
        case showAlert(State.AlertCase)
    }

    public var body: some ReducerOf<SignInFeature> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
            case .alertAction:
                break
            case let .showAlert(alertCase):
                state.alertCase = alertCase
                return .send(.alertAction(.present))
            case .binding:
                break
            case .kakaoButtonTapped:
                state.isLoading = true
                return .run { send in
                    await send(signInWithKakao())
                }
            case .appleButtonTapped:
                return .send(.showAlert(.appleNotice))
            case .navigateToHome, .navigateToSignUp:
                break
            case let .successToGetKakaoAccessToken(thirdPartyAccessToken):
                return .run { [provider = SignInProvider.kakao.rawValue] send in
                    await send(signIn(provider: provider, thirdPartyAccessToken: thirdPartyAccessToken))
                }
            case let .failureToGetKakaoAccessToken(error):
                state.isLoading = false
                return .send(.showAlert(.failure))
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
                return .send(.showAlert(.failure))
            }
            return .none
        }
        Scope(state: \.alertState, action: /SignInFeature.Action.alertAction, child: {
            AlertFeature()
        })
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
