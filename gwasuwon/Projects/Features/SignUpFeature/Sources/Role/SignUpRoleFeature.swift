//
//  SignUpRoleFeature.swift
//  SignUpFeature
//
//  Created by 김동준 on 7/11/24
//

import ComposableArchitecture
import Domain
import BaseFeature

@Reducer
public struct SignUpRoleFeature {
    @Dependency(\.accountUseCase) var accountUseCase
    
    public init() {}

    public struct State: Equatable {
        public init(signInResult: SignInResult) {
            self.signInResult = signInResult
        }
        
        enum AlertCase {
            case none
            case failure
        }
        
        var signInResult: SignInResult
        @BindingState var isLoading = false
        @BindingState var alertState: AlertFeature.State = .init()
        var alertCase: AlertCase = .none
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case teacherButtonTapped
        case studentButtonTapped
        case signUpSuccess(SignUpResult)
        case signUpFailure(NetworkError)
        case navigateToSignUpComplete
        case alertAction(AlertFeature.Action)
        case showFailureAlert
    }

    public var body: some ReducerOf<SignUpRoleFeature> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
            case .binding:
                break
            case .alertAction:
                break
            case .teacherButtonTapped:
                state.isLoading = true
                return .run { [accessToken = state.signInResult.accessToken] send in
                    await send(signUp(accessToken: accessToken, type: AuthRole.teacher.rawValue))
                }
            case .studentButtonTapped:
                state.isLoading = true
                return .run { [accessToken = state.signInResult.accessToken] send in
                    await send(signUp(accessToken: accessToken, type: AuthRole.student.rawValue))
                }
            case let .signUpSuccess(signUpResult):
                state.isLoading = false
                UserManager.shared.setUserInfo(id: signUpResult.id, email: signUpResult.email, role: signUpResult.role)
                return .send(.navigateToSignUpComplete)
            case let .signUpFailure(error):
                state.isLoading = false
                return .send(.showFailureAlert)
            case .navigateToSignUpComplete:
                break
            case .showFailureAlert:
                state.alertCase = .failure
                return .send(.alertAction(.present))
            }
            return .none
        }
        Scope(state: \.alertState, action: \.alertAction, child: {
            AlertFeature()
        })
    }
}

extension SignUpRoleFeature {
    private func signUp(accessToken: String, type: String) async -> Action {
        let response = await accountUseCase.signUp(accessToken, type)
        
        switch response {
        case let .success(result):
            return .signUpSuccess(result)
        case let .failure(error):
            return .signUpFailure(error)
        }
    }
}
