//
//  SignUpFeature.swift
//  SignUp
//
//  Created by 김동준
//

import ComposableArchitecture
import Domain

@Reducer
public struct SignUpFeature {
    public init() {}

    public struct State: Equatable {
        public init(signInResult: SignInResult) {
            self.signInResult = signInResult
        }
        
        var isAllAgreementChecked: Bool {
            get {
                isPersonalInformationChecked && isGwasuwonTermsChecked
            }
            
            set(value) {
                isPersonalInformationChecked = value
                isGwasuwonTermsChecked = value
            }
        }
        @BindingState var isPersonalInformationChecked: Bool = false
        @BindingState var isGwasuwonTermsChecked: Bool = false
        
        var signInResult: SignInResult
    }

    public enum Action: BindableAction, Equatable {
        case onAppear
        case binding(BindingAction<State>)
        case setAllAgreement(Bool)
        case togglePersonalInformation
        case toggleGwasuwonTerms
        case nextButtonTapped
        case navigateToSignUpRole(SignInResult)
    }

    public var body: some ReducerOf<SignUpFeature> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
            case .binding:
                break
            case let .setAllAgreement(value):
                state.isAllAgreementChecked = value
            case .togglePersonalInformation:
                state.isPersonalInformationChecked.toggle()
            case .toggleGwasuwonTerms:
                state.isGwasuwonTermsChecked.toggle()
            case .nextButtonTapped:
                return .send(.navigateToSignUpRole(state.signInResult))
            case let .navigateToSignUpRole(signInResult):
                break
            }
            return .none
        }
    }
}
